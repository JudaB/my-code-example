#!/bin/bash

# Make sure you have Docker
install_or_update_binaries() {
    local binaries=("kubectl" "helm" "k3d")
    for binary in "${binaries[@]}"; do
        if ! command -v "$binary" &> /dev/null; then
            echo "$binary is not installed. Installing..."
            case "$binary" in
                "kubectl")
                    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
                    chmod +x kubectl
                    sudo mv kubectl /usr/local/bin/
                    ;;
                "helm")
                    curl -LO https://get.helm.sh/helm-v3.7.1-linux-amd64.tar.gz
                    tar -zxvf helm-v3.7.1-linux-amd64.tar.gz
                    sudo mv linux-amd64/helm /usr/local/bin/
                    rm -rf linux-amd64 helm-v3.7.1-linux-amd64.tar.gz
                    ;;
                "k3d")
                    curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
                    ;;
                "argocd")
                    sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
                    sudo chmod +x /usr/local/bin/argocd
                    ;;
                *)
                    echo "Unknown binary: $binary"
                    ;;
            esac
            echo "$binary has been installed."
        else
            echo "$binary is already installed."
        fi
    done
}

create_k3d_cluster() {
    k3d cluster create mycluster -p "8900:30080@agent:0" -p "8901:30081@agent:0" -p "8902:30082@agent:0" --agents 2
    # Check the return code of the k3d cluster creation command
    if [ $? -eq 0 ]; then
        echo "k3d cluster 'mycluster' created successfully."
        return 0
    else
        echo "Failed to create k3d cluster 'mycluster'."
        return 1
    fi
}

wait_for_deployments() {
    # $1  is the namespace name
    local NAMESPACE="$1"

    # Check if namespace argument is provided and not empty
    if [ -z "$NAMESPACE" ]; then
        echo "Error: Namespace argument is missing or empty."
        exit 1
    fi

    # Get the list of deployments in the specified namespace
    deployments=$(kubectl get deployments -n "$NAMESPACE" -o jsonpath='{.items[*].metadata.name}')

    # Iterate through each deployment and wait for it to become available
    for deployment in $deployments; do
        echo "Waiting for deployment $deployment to finish..."
        kubectl wait --for=condition=available deployment/"$deployment" --timeout=300s -n "$NAMESPACE"
    done
}


install_argocd() {
    # Create the argocd namespace
    kubectl create namespace argocd
    # Apply Argo CD installation manifest to the argocd namespace
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    # Check if the installation was successful
    if [ $? -eq 0 ]; then
        echo "Argo CD installed successfully."
        return 0
    else
        echo "Failed to install Argo CD."
        return 1
    fi
    wait_for_deployments argocd
}


install_or_update_binaries
create_k3d_cluster
install_argocd
# Add Application
kubectl apply -f app.yaml -n argocd
wait_for_deployments



#kubectl port-forward svc/argocd-server -n argocd 8080:443
#kubectl get secret argocd-initial-admin-secret -n argocd -o json | jq -r '.data.password'  | base64 -d
#kubectl config set-context --current --namespace=argocd
#argocd login localhost:8080 --insecure
#kubectl create guestbook
#argocd app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-server https://localhost:8080 --dest-namespace defaul
#argocd app sync guestbook

kubectl apply -f app.yaml -n argocd



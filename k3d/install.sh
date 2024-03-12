
# Make sure you have Docker

# install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
# install helm (this one takes some time)
curl -s https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
# install k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

k3d cluster create mycluster -p "8900:30080@agent:0" -p "8901:30081@agent:0" -p "8902:30082@agent:0" --agents 2

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl port-forward svc/argocd-server -n argocd 8080:443
kubectl port-forward svc/argocd-server -n argocd 8080:443
kubectl get secret argocd-initial-admin-secret -n argocd -o json | jq -r '.data.password'  | base64 -d

kubectl config set-context --current --namespace=argocd

sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo chmod +x /usr/local/bin/argocd
kubectl port-forward svc/argocd-server -n argocd 8080:443
argocd login localhost:8080 --insecure

argocd app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-server https://localhost:8080 --dest-namespace defaul

argocd app sync guestbook
kubectl get ns guestbook
kubectl apply -f app.yaml -n argocd

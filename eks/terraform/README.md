
tf files to deploy kubernetes in aws, 

connect to tf-cloud:
exprot TF_CLOUD_ORGANIZATION="juda-barnes-org"
terraform init
terraform plan
terraform apply 

update kubeconfig:
aws eks list-clusters
aws eks update-kubeconfig --region us-east-1 --name $CLUSTER_NAME


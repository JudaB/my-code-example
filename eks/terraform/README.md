

use terraform plan
use terraform init
exprot TF_CLOUD_ORGANIZATION="juda-barnes-org"

aws eks update-kubeconfig --region us-east-1 --name $CLUSTER_NAME


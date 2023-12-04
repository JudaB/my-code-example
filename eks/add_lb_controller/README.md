Install Load Balancer with the following Link

https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html


or use script

create.sh



kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/examples/2048/2048_full.yaml

kubectl -n game-2048 get ing

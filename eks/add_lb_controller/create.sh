#!/bin/bash
set -x
set -e

curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/install/iam_policy.json

aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json

CLUSTER_NAME=$(aws eks list-clusters | jq '.clusters[0]' -r)

LB_ARN=$(aws iam list-policies  | jq -r '.Policies[] | select(.PolicyName == "AWSLoadBalancerControllerIAMPolicy") | .Arn')
AccountID=$( echo $LB_ARN | awk -F: '{ print $5 }' ) 
oidc_id=$(aws eks describe-cluster --name ${CLUSTER_NAME} --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5)
aws iam list-open-id-connect-providers | grep $oidc_id | cut -d "/" -f4
REGION="us-east-1"



cat >load-balancer-role-trust-policy.json <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::${AccountID}:oidc-provider/oidc.eks.${REGION}.amazonaws.com/id/${oidc_id}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "oidc.eks.${REGION}.amazonaws.com/id/${oidc_id}:aud": "sts.amazonaws.com",
                    "oidc.eks.${REGION}.amazonaws.com/id/${oidc_id}:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
                }
            }
        }
    ]
}
EOF


aws iam create-role \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --assume-role-policy-document file://"load-balancer-role-trust-policy.json"




LB_PolicyId=$(aws iam list-policies  | jq -r '.Policies[] | select(.PolicyName == "AWSLoadBalancerControllerIAMPolicy") | .PolicyId')
LB_PolicyId=$(aws iam list-policies  | jq -r '.Policies[] | select(.PolicyName == "AWSLoadBalancerControllerIAMPolicy") | .PolicyId')
LBPOLICY_ARN=$(aws iam list-policies  | jq -r '.Policies[] | select(.PolicyName == "AWSLoadBalancerControllerIAMPolicy") | .Arn')


aws iam attach-role-policy \
  --policy-arn $LBPOLICY_ARN \
  --role-name AmazonEKSLoadBalancerControllerRole

ROLE_ARN=$( aws iam list-roles |  jq -r '.Roles[] |  select(.RoleName == "AmazonEKSLoadBalancerControllerRole") | .Arn ')

# Create SA in kubernetes

cat >aws-load-balancer-controller-service-account.yaml <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    app.kubernetes.io/component: controller
    app.kubernetes.io/name: aws-load-balancer-controller
  name: aws-load-balancer-controller
  namespace: kube-system
  annotations:
    eks.amazonaws.com/role-arn: ${ROLE_ARN}
EOF


# 1. Create an EKS Cluster

# 2. Create an IAM OIDC provider for your cluster
```sh
cluster_name=dev
oidc_id=$(aws eks describe-cluster --name $cluster_name --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5)
echo $oidc_id
aws iam list-open-id-connect-providers | grep $oidc_id | cut -d "/" -f4
eksctl utils associate-iam-oidc-provider --cluster $cluster_name --approve
```
# Step 4: Create IAM Role using eksctl

## 4a. Download the IAM policy
```sh
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.11.0/docs/install/iam_policy.json
```
## 4b. Create the policy with name AWSLoadBalancerControllerIAMPolicy and can see in aws console
```sh
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json	
```
## 4c. Create IAM Role using eksctl
```sh
eksctl create iamserviceaccount \
  --cluster=dev \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::381492219349:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve
```
# 5. Install helm in local server
```sh
wget https://get.helm.sh/helm-v3.12.3-linux-amd64.tar.gz
tar -xzf helm-v3.12.3-linux-amd64.tar.gz
sudo mv ./linux-amd64/helm /usr/local/bin/
```
# Step 6: # Add the repo, update, Install the load balancer controller using helm

# 6a. Add the eks-charts Helm chart repository
```sh
helm repo add eks https://aws.github.io/eks-charts
```
## 6b. Update your local repo to make sure that you have the most recent charts.
```sh
helm repo update eks
```
# 6c. Install the AWS Load Balancer Controller
```sh
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=dev \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller 
```
## 6d. To view the available versions of the Helm Chart and Load Balancer Controller
```sh
helm search repo eks/aws-load-balancer-controller --versions
```
# Step 7: Verify that the controller is installed
```sh
kubectl get deployment -n kube-system aws-load-balancer-controller
kubectl get pod -n kube-system
kubectl get ingressclass
```
#### For ref: 
https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html
https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html

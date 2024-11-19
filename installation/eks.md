# Launching an EKS Cluster
Introduction
```sh
Elastic Kubernetes Service (EKS) is a fully managed Kubernetes service from AWS.
```

### Create an IAM User with Admin Permissions
```sh
Navigate to IAM > Users.
Click Add user.
Set the following values:
User name: k8-admin
Access type: Programmatic access
Click Next: Permissions.
Select Attach existing policies directly.
Select AdministratorAccess.
Click Next: Tags > Next: Review.
Click Create user.
Copy the access key ID and secret access key, and paste them into a text file, as we'll need them in the next step.
```
### Launch an EC2 Instance and Configure the Command Line Tools
```sh
Navigate to EC2 > Instances.
Click Launch Instance.
On the AMI page, select the Amazon Linux 2 AMI.
Leave t2.micro selected, and click Next: Configure Instance Details.
On the Configure Instance Details page:
Network: Leave default
Subnet: Leave default
Auto-assign Public IP: Enable
Click Next: Add Storage > Next: Add Tags > Next: Configure Security Group.
Click Review and Launch, and then Launch.
In the key pair dialog, select Create a new key pair.
Give it a Key pair name: "eks".
Click Download Key Pair, and then Launch Instances.
Click View Instances, and give it a few minutes to enter the running state.

Once the instance is fully created, check the checkbox next to it and click Connect at the top of the window.
In the Connect to your instance dialog, select EC2 Instance Connect (browser-based SSH connection).
Click Connect.
```
### AWS CLI installation
```sh
In the command line window, check the AWS CLI version:
aws --version
It might be an older version.
Download v2:
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

Unzip the file:
unzip awscliv2.zip

See where the current AWS CLI is installed:
which aws
It should be /usr/bin/aws.

Update it:
sudo ./aws/install --bin-dir /usr/bin --install-dir /usr/bin/aws-cli --update

Check the version of AWS CLI:
aws --version
It should now be updated.
```

### Configure the CLI:
```sh
aws configure
For AWS Access Key ID, paste in the access key ID you copied earlier.
For AWS Secret Access Key, paste in the secret access key you copied earlier.
For Default region name, enter us-east-1.
For Default output format, enter json.
```

### Download kubectl:
```sh
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/kubectl

Apply execute permissions to the binary:
chmod +x ./kubectl

Copy the binary to a directory in your path:
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin

Ensure kubectl is installed:
kubectl version --short --client
```

### Download eksctl(Linux):
```sh
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

Move the extracted binary to /usr/bin:
sudo mv /tmp/eksctl /usr/bin

Get the version of eksctl:
eksctl version

See the options with eksctl:
eksctl help
```
#### Download eksctl (Windows) -> Using Git Bash: 
```sh
# for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`
ARCH=amd64
PLATFORM=windows_$ARCH

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.zip"

# (Optional) Verify checksum
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

unzip eksctl_$PLATFORM.zip -d $HOME/bin

rm eksctl_$PLATFORM.zip
```

### Provision an EKS Cluster
```sh
# Provision an EKS cluster with two worker nodes in us-east-1:
eksctl create cluster --name dev --region us-east-1 --nodegroup-name standard-workers --node-type t3.medium --nodes 2 --nodes-min 1 --nodes-max 4 --managed

eksctl get cluster
# Enable it to connect to our cluster:
aws eks update-kubeconfig --name dev --region us-east-1

If your EKS resources can't be deployed due to AWS capacity issues, delete your eksctl-dev-cluster CloudFormation stack and retry the command using the --zones parameter and suggested availability zones from the CREATE_FAILED message:

AWS::EKS::Cluster/ControlPlane: CREATE_FAILED – "Resource handler returned message: \"Cannot create cluster 'dev' because us-east-1e, the targeted availability zone, does not currently have sufficient capacity to support the cluster. Retry and choose from these availability zones: us-east-1a, us-east-1b, us-east-1c, us-east-1d, us-east-1f (Service: Eks, Status Code: 400, Request ID: 21e7e4aa-17a5-4c79-a911-bf86c4e93373)\" (RequestToken: 18b731b0-92a1-a779-9a69-f61e90b97ee1, HandlerErrorCode: InvalidRequest)"
In this example, the --zones parameter was added using the us-east-1a,us-east-1b,us-east-1c,us-east-1d,us-east-1f AZs from the message above:

eksctl create cluster --name dev --region us-east-1 --zones us-east-1a,us-east-1b,us-east-1c,us-east-1d,us-east-1f --nodegroup-name standard-workers --node-type t3.medium --nodes 3 --nodes-min 1 --nodes-max 4 --managed

It will take 10–15 minutes since it's provisioning the control plane and worker nodes, attaching the worker nodes to the control plane, and creating the VPC, security group, and Auto Scaling group.

In the AWS Management Console, navigate to CloudFormation and take a look at what’s going on there.
Select the eksctl-dev-cluster stack (this is our control plane).

Click Events, so you can see all the resources that are being created.
We should then see another new stack being created — this one is our node group.

Once both stacks are complete, navigate to Elastic Kubernetes Service > Clusters.

Click the listed cluster.

If you see a Your current user or role does not have access to Kubernetes objects on this EKS cluster message just ignore it, as it won't impact the next steps of the activity.

Click the Compute tab (under Configuration), and then click the listed node group. There, we'll see the Kubernetes version, instance type, status, etc.

Click dev in the breadcrumb navigation link at the top of the screen.

Click the Networking tab (under Configuration), where we'll see the VPC, subnets, etc.

Click the Logging tab (under Configuration), where we'll see the control plane logging info.

The control plane is abstracted — we can only interact with it using the command line utilities or the console. It’s not an EC2 instance we can log into and start running Linux commands on.
Navigate to EC2 > Instances, where you should see the instances have been launched.

Close out of the existing CLI window, if you still have it open.

Select the original t2.micro instance, and click Connect at the top of the window.

In the Connect to your instance dialog, select EC2 Instance Connect (browser-based SSH connection).

Click Connect.

In the CLI, check the cluster:

eksctl get cluster
Enable it to connect to our cluster:
aws eks update-kubeconfig --name dev --region us-east-1

Get the nodegroup:
eksctl get nodegroup --cluster <cluster name>

Create the nodegroup:(Optional)
eksctl create nodegroup --cluster dev --nodegroup-name standard-workers --node-type t3.medium --nodes 2 --nodes-min 1 --nodes-max 4 --managed

# Create Cluster without node group
eksctl create cluster --name=eksdemo1 \
--region=us-east-1 \
--zones=us-east-1a,us-east-1b \
--without-nodegroup

# Create a node group + ssh access
# Create Public Node Group   
eksctl create nodegroup --cluster=eksdemo1 \
--region=us-east-1 \
--name=eksdemo1-ng-public1 \
--node-type=t3.medium \
--nodes=2 \
--nodes-min=2 \
--nodes-max=4 \
--node-volume-size=20 \
--ssh-access \
--ssh-public-key=cg \
--managed \
--asg-access \
--external-dns-access \
--full-ecr-access \
--appmesh-access \
--alb-ingress-access 

# Create a Cluster + managed node group + ssh access
eksctl create cluster --name dev \
--region us-east-1 \
--nodegroup-name standard-workers \
--node-type t3.medium \
--nodes 3 --nodes-min 1 --nodes-max 4 \
--node-volume-size 20 \
--ssh-access \
--ssh-public-key=cg \
--managed \
--asg-access \
--external-dns-access \
--full-ecr-access \
--appmesh-access \
--alb-ingress-access


```

### Delete Your EKS Cluster

```sh
In the CLI, delete everything:

eksctl delete cluster dev # Update /home/ec2-user/.kube
eksctl delete cluster dev --region us-east-1
```

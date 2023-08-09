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

Configure the CLI:

aws configure
For AWS Access Key ID, paste in the access key ID you copied earlier.

For AWS Secret Access Key, paste in the secret access key you copied earlier.

For Default region name, enter us-east-1.

For Default output format, enter json.

Download kubectl:

curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/kubectl
Apply execute permissions to the binary:

chmod +x ./kubectl
Copy the binary to a directory in your path:

mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
Ensure kubectl is installed:

kubectl version --short --client
Download eksctl:

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
Move the extracted binary to /usr/bin:

sudo mv /tmp/eksctl /usr/bin
Get the version of eksctl:

eksctl version
See the options with eksctl:

eksctl help
Provision an EKS Cluster
Provision an EKS cluster with three worker nodes in us-east-1:

eksctl create cluster --name dev --region us-east-1 --nodegroup-name standard-workers --node-type t3.medium --nodes 3 --nodes-min 1 --nodes-max 4 --managed
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
Create a Deployment on Your EKS Cluster
Install Git:

sudo yum install -y git
Download the course files:

git clone https://github.com/ACloudGuru-Resources/Course_EKS-Basics
Change directory:

cd Course_EKS-Basics
Take a look at the deployment file:

cat nginx-deployment.yaml
Take a look at the service file:

cat nginx-svc.yaml
Create the service:

kubectl apply -f ./nginx-svc.yaml
Check its status:

kubectl get service
Copy the external DNS hostname of the load balancer, and paste it into a text file, as we'll need it in a minute.

Create the deployment:

kubectl apply -f ./nginx-deployment.yaml
Check its status:

kubectl get deployment
View the pods:

kubectl get pod
View the ReplicaSets:

kubectl get rs
View the nodes:

kubectl get node
Access the application using the load balancer, replacing <LOAD_BALANCER_DNS_HOSTNAME> with the IP you copied earlier (it might take a couple of minutes to update):

curl "<LOAD_BALANCER_DNS_HOSTNAME>"
The output should be the HTML for a default Nginx web page.

In a new browser tab, navigate to the same IP, where we should then see the same Nginx web page.

Test the High Availability Features of Your EKS Cluster
In the AWS console, on the EC2 instances page, select the three t3.medium instances.

Click Actions > Instance State > Stop.

In the dialog, click Yes, Stop.

After a few minutes, we should see EKS launching new instances to keep our service running.

In the CLI, check the status of our nodes:

kubectl get node
All the nodes should be down (i.e., display a NotReady status).

Check the pods:

kubectl get pod
We'll see a few different statuses — Terminating, Running, and Pending — because, as the instances shut down, EKS is trying to restart the pods.

Check the nodes again:

kubectl get node
We should see a new node, which we can identify by its age.

Wait a few minutes, and then check the nodes again:

kubectl get node
We should have one in a Ready state.

Check the pods again:

kubectl get pod
We should see a couple pods are now running as well.

Check the service status:

kubectl get service
Copy the external DNS Hostname listed in the output.

Access the application using the load balancer, replacing <LOAD_BALANCER_DNS_HOSTNAME> with the DNS Hostname you just copied:

curl "<LOAD_BALANCER_EXTERNAL_IP>"
We should see the Nginx web page HTML again. (If you don't, wait a few more minutes.)

In a new browser tab, navigate to the same IP, where we should again see the Nginx web page.

In the CLI, delete everything:

eksctl delete cluster dev

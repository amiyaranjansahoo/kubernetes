### Launch ec2 Amazon Linux t2-medium(2 CPU 4 GB RAM )

# Download and Install kubectl
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/kubectl

#Apply execute permissions to the binary:
chmod +x ./kubectl

#Copy the binary to a directory in your path:
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin

#Ensure kubectl is installed:
kubectl version --short --client



# Download and Install docker
# Login as ec2-user)
sudo yum install docker
docker version 
sudo service docker start
sudo systemctl enable docker
docker image ls 
# Add the ec2-user to the docker group so you can execute Docker commands without using sudo
cat /etc/group # docker group present and ec2-user does not present to the group
sudo usermod -G docker ec2-user 
cat /etc/group  # We must see ec2-user belongs to the docker group.
# Logout of the screen and login again
docker image ls



# Minikube Installation
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

minikube start
minikube status

################## end ##################



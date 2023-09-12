# Amazon EKS recommended maximum Pods for each Amazon EC2 instance type
curl -O https://raw.githubusercontent.com/awslabs/amazon-eks-ami/master/files/max-pods-calculator.sh
chmod +x max-pods-calculator.sh
# Create an user with admin access and configure as below and tehn execute the script
aws cpnfigure
./max-pods-calculator.sh --instance-type <instance type> --cni-version <cni version>
./max-pods-calculator.sh --instance-type m5.large --cni-version 1.9.0-eksbuild.1

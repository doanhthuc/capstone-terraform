#VPC vars
main_vpc_cidr = "10.0.0.0/16"
region        = "ap-southeast-1"

#Subnet vars
public_subnet_1_cidr  = "10.0.1.0/24"
private_subnet_1_cidr = "10.0.2.0/24"
public_subnet_2_cidr  = "10.0.3.0/24"
private_subnet_2_cidr = "10.0.4.0/24"
subnet_1_az           = "ap-southeast-1a"
subnet_2_az           = "ap-southeast-1b"

#EKS vars
eks-cluster-name    = "eks-capstone-cluster"
eks-cluster-verison = "1.24"
eks-cluster-role    = "eks-node-group-general"
eks-node-group-role = "eks-node-group-general"
node-group-name     = "eks-node-group-general"

#Bastion Host vars
instance-type-bastion     = "t2.micro"
ami-instance-type-bastion = "ami-03f6a11788f8e319e"
bastion-tag-name          = "ec2-bastion-public"


resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = var.subnet_1_az
  map_public_ip_on_launch = true

  tags = {
    Name                                         = "public-ap-southeast-1a"
    "kubernetes.io/cluster/eks-capstone-cluster" = "shared"
    "kubernetes.io/role/elb"                     = 1
  }
}

resource "aws_subnet" "public_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_2_cidr
  availability_zone = var.subnet_2_az

  # Required for EKS. Instances launched into the subnet should be assigned a public IP address.
  map_public_ip_on_launch = true

  tags = {
    Name                                         = "public-ap-southeast-1b"
    "kubernetes.io/cluster/eks-capstone-cluster" = "shared"
    "kubernetes.io/role/elb"                     = 1
  }
}

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = var.subnet_1_az

  tags = {
    Name                                         = "private-ap-southeast-1a"
    "kubernetes.io/cluster/eks-capstone-cluster" = "shared"
    "kubernetes.io/role/internal-elb"            = 1
  }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = var.subnet_2_az

  tags = {
    Name                                         = "private-ap-southeast-1b"
    "kubernetes.io/cluster/eks-capstone-cluster" = "shared"
    "kubernetes.io/role/internal-elb"            = 1
  }
}
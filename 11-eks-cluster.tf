# resource "aws_iam_role" "eks_cluster" {
#   name = "eks-cluster"

#   # The policy that grants an entity permission to assume the role.
#   # Used to access AWS resources that you might not normally have access to.
#   # The role that Amazon EKS will use to create AWS resources for Kubernetes clusters
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Service = "eks.amazonaws.com"
#         }
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
#   # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKSClusterPolicy
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.eks_cluster.name
# }

# resource "aws_eks_cluster" "eks" {
#   name = var.eks-cluster-name

#   # The Amazon Resource Name (ARN) of the IAM role that provides permissions for 
#   # the Kubernetes control plane to make calls to AWS API operations on your behalf
#   role_arn = aws_iam_role.eks_cluster.arn

#   # Desired Kubernetes master version
#   version = var.eks-cluster-verison

#   vpc_config {
#     # Indicates whether or not the Amazon EKS private API server endpoint is enabled
#     endpoint_private_access = false

#     # Indicates whether or not the Amazon EKS public API server endpoint is enabled
#     endpoint_public_access = true

#     # subnet_ids = [
#     #   aws_subnet.public_1.id,
#     #   aws_subnet.public_2.id,
#     #   aws_subnet.private_1.id,
#     #   aws_subnet.private_2.id
#     # ]

#     subnet_ids = [
#       aws_subnet.public_1.id,
#       aws_subnet.private_1.id,
#       aws_subnet.private_2.id
#     ]
#   }

#   # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
#   # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
#   depends_on = [
#     aws_iam_role_policy_attachment.amazon_eks_cluster_policy
#   ]
# }
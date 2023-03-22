# resource "aws_iam_role" "nodes_general" {
#   name = var.eks-node-group-role
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# resource "aws_iam_policy" "ebs_policy" {
#   name = "ebs-policy"
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = [
#           "ec2:AttachVolume",
#           "ec2:DetachVolume",
#           "ec2:CreateSnapshot",
#           "ec2:CreateTags",
#           "ec2:CreateVolume",
#           "ec2:DeleteSnapshot",
#           "ec2:DeleteTags",
#           "ec2:DeleteVolume",
#           "ec2:DescribeAvailabilityZones",
#           "ec2:DescribeInstances",
#           "ec2:DescribeSnapshots",
#           "ec2:DescribeTags",
#           "ec2:DescribeVolumes",
#           "ec2:DescribeVolumesModifications",
#           "ec2:DetachVolume",
#           "ec2:ModifyVolume",
#           "ec2:DescribeRegions"
#         ]
#         Resource = "*"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "amazone_eks_ebs_policy" {
#   policy_arn = aws_iam_policy.ebs_policy.arn
#   role       = aws_iam_role.nodes_general.name
# }


# resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy_general" {
#   # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKSWorkerNodePolicy
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.nodes_general.name
# }

# resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_general" {
#   # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKS_CNI_Policy
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   role       = aws_iam_role.nodes_general.name
# }

# resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
#   # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEC2ContainerRegistryReadOnly
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   role       = aws_iam_role.nodes_general.name
# }

# resource "aws_eks_node_group" "nodes_general" {
#   cluster_name    = aws_eks_cluster.eks.name
#   node_group_name = "nodes-general"

#   # Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group.
#   node_role_arn = aws_iam_role.nodes_general.arn

#   # Identifiers of EC2 Subnets to associate with the EKS Node Group. 
#   # These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME 
#   # (where CLUSTER_NAME is replaced with the name of the EKS Cluster).
#   subnet_ids = [
#     aws_subnet.private_1.id,
#     aws_subnet.private_2.id
#   ]

#   scaling_config {
#     desired_size = 1
#     max_size     = 2
#     min_size     = 1
#   }

#   ami_type      = "AL2_x86_64"
#   capacity_type = "ON_DEMAND"
#   disk_size     = 10

#   # Force version update if existing pods are unable to be drained due to a pod disruption budget issue.
#   force_update_version = false

#   instance_types = ["t3.xlarge"]

#   labels = {
#     role = "nodes-general"
#   }

#   # Kubernetes version
#   version = var.eks-cluster-verison

#   # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
#   # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#   depends_on = [
#     aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
#     aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
#     aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
#   ]
# }
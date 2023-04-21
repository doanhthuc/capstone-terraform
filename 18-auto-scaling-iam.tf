data "aws_iam_policy_document" "cluster_autoscaler_sts_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:cluster-autoscaler"]
    }
    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}
# IAM Role for IAM Cluster Autoscaler
resource "aws_iam_role" "cluster_autoscaler" {
  assume_role_policy = data.aws_iam_policy_document.cluster_autoscaler_sts_policy.json
  name               = "eks-capstone-cluster-autoscaler-role"

  depends_on = [
    aws_iam_policy.cluster_autoscaler
  ]
}
# IAM Policy for IAM Cluster Autoscaler role allowing ASG operations
resource "aws_iam_policy" "cluster_autoscaler" {
  name = "eks-capstone-cluster-autoscaler-policy"
  policy = jsonencode({
    Statement = [{
      Action = [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeLaunchConfigurations",
        "autoscaling:DescribeTags",
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup",
        "ec2:DescribeLaunchTemplateVersions"
      ]
      Effect   = "Allow"
      Resource = "*"
    }]
    Version = "2012-10-17"
  })
}
resource "aws_iam_role_policy_attachment" "eks_ca_iam_policy_attach" {
  role       = aws_iam_role.cluster_autoscaler.name
  policy_arn = aws_iam_policy.cluster_autoscaler.arn

  depends_on = [
    aws_iam_role.cluster_autoscaler,
    aws_iam_policy.cluster_autoscaler
  ]
}

output "eks_ca_iam_role_arn" {
  value       = aws_iam_role.cluster_autoscaler.arn
  description = "AWS IAM role ARN for EKS Cluster Autoscaler"
}
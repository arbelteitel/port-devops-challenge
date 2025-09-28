module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id                         = var.vpc_id
  subnet_ids                     = var.private_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    instance_types             = var.node_instance_types
    iam_role_attach_cni_policy = true
  }

  # We'll manage node groups separately
  eks_managed_node_groups = {}

  manage_aws_auth_configmap = false

  tags = var.tags
}
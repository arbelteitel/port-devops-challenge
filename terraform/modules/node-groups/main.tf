module "eks_managed_node_group" {
  source = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  version = "~> 19.0"

  name            = var.node_group_name
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  subnet_ids = var.private_subnets

  instance_types = var.instance_types
  capacity_type  = var.capacity_type

  min_size     = var.min_size
  max_size     = var.max_size
  desired_size = var.desired_size

  disk_size = var.disk_size

  labels = var.labels

  update_config = {
    max_unavailable_percentage = var.max_unavailable_percentage
  }

  tags = var.tags
}
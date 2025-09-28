aws_region = "eu-west-1"

cluster_name    = "port-devops-dev"
cluster_version = "1.28"
environment     = "dev"

vpc_cidr = "10.0.0.0/16"

# Ultra cost-optimized for dev while maintaining smooth operation
node_instance_types = ["m6g.medium"]  # ARM-based Graviton2 for better price-performance
node_ami_type       = "AL2_ARM_64"    # ARM64 AMI for Graviton processors
node_desired_size   = 1             # Start with minimal nodes
node_max_size       = 2             # Allow scaling up if needed
node_min_size       = 1             # Always keep at least 1 node
single_nat_gateway  = true
# Terraform variables for EKS cluster



# vpc_id       = "vpc-0dd1e20336beb75e5"
# subnet_ids   = [
#   "subnet-0ad1f45dee4200759",
#   "subnet-062c801042588df9a",
#   "subnet-0006f815c074a166b",
# ]

cluster_name    = "tct-eks-cluster-prod"
project_name    = "tct-final-project"
cluster_version = "1.32"
node_groups = {
  eks_nodes = {
    instance_types = ["t3.large"]
    capacity_type  = "ON_DEMAND"
    scaling_config = {
      desired_size = 2
      max_size     = 3
      min_size     = 1
    }
  }
}

cluster_role_arn = "arn:aws:iam::xxxxxxxxxxxx:role/devops_role"
node_role_arn    = "arn:aws:iam::xxxxxxxxxxxx:role/devops_role"
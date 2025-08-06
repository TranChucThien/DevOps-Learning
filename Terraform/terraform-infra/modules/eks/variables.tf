variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "tct-eks-cluster-prod"
}


variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.32"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  # Example: "vpc-0dd1e20336beb75e5"
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(string)
  default     = ["subnet-0ad1f45dee4200759"]
  # Example: ["subnet-0ad1f45dee4200759", "subnet-062c801042588df9a", "subnet-0006f815c074a166b"]
  # Note: You can use module.vpc.public_subnet_ids or module.vpc.private_subnet_ids if using a VPC module
}

variable "node_groups" {
  description = "EKS node group configuration"
  type = map(object({
    instance_types = list(string)
    capacity_type  = string
    scaling_config = object({
      desired_size = number
      max_size     = number
      min_size     = number
    })
  }))
  # Example:
  # node_groups = {
  #   eks_nodes = {
  #     instance_types = ["t3.large"]
  #     capacity_type  = "ON_DEMAND"
  #     scaling_config = {
  #       desired_size = 2
  #       max_size     = 3
  #       min_size     = 1
  #     }
  #   }
  # }

}


variable "cluster_role_arn" {
  description = "IAM role ARN for the EKS cluster"
  type        = string
  default     = null
  # Example: "arn:aws:iam::XXXXXXXXXXXX:role/devops_role"
}

variable "node_role_arn" {
  description = "IAM role ARN for the EKS node group"
  type        = string
  default     = null
  # Example: "arn:aws:iam::XXXXXXXXXXXX:role/devops_role"

}
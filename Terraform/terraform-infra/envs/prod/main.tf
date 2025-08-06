provider "aws" {
  region = "us-east-2"

}

terraform {

  backend "s3" {
    bucket       = "tct-backend"
    key          = "prod/terraform.tfstate"
    region       = "us-east-2"
    use_lockfile = true
    encrypt      = true
  }
}

module "vpc" {
  source = "../../modules/vpc"
  name   = "${var.project_name}-prod-vpc"

}


module "eks" {
  source           = "../../modules/eks"
  cluster_name     = var.cluster_name
  cluster_version  = var.cluster_version
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.private_subnet_ids
  node_groups      = var.node_groups
  cluster_role_arn = var.cluster_role_arn
  node_role_arn    = var.node_role_arn


}


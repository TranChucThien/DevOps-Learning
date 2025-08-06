provider "aws" {
  region = "us-east-2"

}

terraform {

  backend "s3" {
    bucket       = "tct-backend"
    key          = "dev/terraform.tfstate"
    region       = "us-east-2"
    use_lockfile = true
    encrypt      = true
  }
}


module "vpc" {
  source = "../../modules/vpc"
  name   = "${var.project_name}-dev-vpc"

}


module "security_group" {
  source         = "../../modules/security_group"
  vpc_id         = module.vpc.vpc_id
  sg_name        = "${var.project_name}-dev-sg"
  sg_description = var.sg_description

  ingress_rules = [
    { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }, # SSH, "0.0.0.0/0" because use GitHub action runner(don't know its IP) to SSH into EC2
    { from_port = 8888, to_port = 8888, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 5000, to_port = 5000, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
  ]

}

module "ec2" {
  source               = "../../modules/ec2"
  key_name             = var.ssh_key_name
  key_path             = var.ssh_key_path
  ec2_name             = "${var.project_name}-dev-ec2"
  sg_id                = module.security_group.security_group_id
  vpc_id               = module.vpc.vpc_id
  subnet_id            = element(module.vpc.public_subnet_ids, 0) # Use the first public subnet
  provisioner_commands = null                                     #var.provisioner_commands
  user                 = var.ssh_user
  instance_ami         = var.instance_ami


}

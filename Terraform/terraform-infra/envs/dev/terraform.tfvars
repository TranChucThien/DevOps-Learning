# This file contains the main configuration for the EKS cluster and node groups.
# It uses the AWS provider to create an EKS cluster and node groups based on the provided variables.
# The configuration includes the following:

project_name   = "tct-final-project"
sg_description = "Security group for my EC2 instance in dev"
ssh_key_name   = "tct-ssh-key"       # Example key pair name, can be overridden
ssh_key_path   = "./tct-ssh-key.pem" # Example path, can be overridden
provisioner_commands = [
  # "sudo yum update -y",
  # "sudo amazon-linux-extras enable docker",
  # "sudo yum install -y docker",
  # "sudo systemctl start docker",
  # "sudo systemctl enable docker",
  # "sudo usermod -aG docker $USER",
  # "newgrp docker",
  # # "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose",
  # # "sudo chmod +x /usr/local/bin/docker-compose",
  # # "docker-compose version",

]
ssh_user     = "ec2-user"              # Example SSH user, can be overridden for Amazon Linux 2
instance_ami = "ami-0100e595e1cc1ff7f" # Example AMI ID for Amazon Linux 2 in us-east-2, can be overridden

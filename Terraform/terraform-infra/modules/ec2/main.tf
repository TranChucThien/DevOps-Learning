# provider "aws" {
#   region = var.aws_region
# }

resource "aws_instance" "my_ec2_instance" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  # count = var.number_instances # Uncomment if using count

  # vpc_security_group_ids = var.security_group_ids
  vpc_security_group_ids = [var.sg_id] # Uncomment if using a VPC module
  # security_groups = [aws_security_group.my_sg.name]

  tags = {
    Name = var.ec2_name
  }

  provisioner "remote-exec" {
    connection {
      type        = var.connection_type # type = "ssh" # Uncomment if using SSH connection
      user        = var.user            # 
      private_key = file(var.key_path)
      host        = self.public_ip

    }
    inline = var.provisioner_commands # Use the variable for commands]

  }
}



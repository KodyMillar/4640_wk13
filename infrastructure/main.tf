provider "aws" {
  region = "us-west-2"
}

# resource "aws_instance" "instance1" {
#   ami             = "ami-03839f1dba75bb628"
#   instance_type   = "t2.micro"
#   subnet_id       = aws_subnet.subnet1.id
#   key_name        = module.ssh_key.ssh_key_name
#   security_groups = [module.vpc.subnet_lab13_public.id]
#   tags = {
#     Name = "i1"
#   }
#   user_data = <<-EOF
#               #!/bin/bash
#               hostnamectl set-hostname i1
#               EOF
# }

# resource "aws_instance" "instance2" {
#   ami             = "ami-03839f1dba75bb628"
#   instance_type   = "t2.micro"
#   subnet_id       = aws_subnet.subnet2.id
#   security_groups = [aws_security_group.main.id]
#   key_name        = module.ssh_key.ssh_key_name
#   tags = {
#     Name = "i2"
#   }

#   user_data = <<-EOF
#               #!/bin/bash
#               hostnamectl set-hostname i2
#               EOF

# }

module "vpc" {
  source = "./modules/terrafrom_vpc"
}

module "ec2" {
  source = "./modules/terraform_ec2_multiple"
  security_group_public = module.vpc.sg_lab13_public.id
  security_group_private = module.vpc.sg_lab13_private.id
  subnet_public = module.vpc.subnet_lab13_public.id
  subnet_private = module.vpc.subnet_lab13_private.id
  ssh_key_name = module.ssh_key.ssh_key_name
}

module "ssh_key" {
  source       = "git::https://gitlab.com/acit_4640_library/tf_modules/aws_ssh_key_pair.git"
  ssh_key_name = "acit_4640_lab_13"
  output_dir   = path.root
}

module "connect_script" {
  source           = "git::https://gitlab.com/acit_4640_library/tf_modules/aws_ec2_connection_script.git"
  ec2_instances    = { "i1" = module.ec2.instance1, "i2" = module.ec2.instance2 }
  output_file_path = "${path.root}/connect_vars.sh"
  ssh_key_file     = module.ssh_key.priv_key_file
  ssh_user_name    = "ubuntu"
}

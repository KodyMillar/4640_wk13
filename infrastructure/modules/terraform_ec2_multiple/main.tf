resource "aws_instance" "instance1" {
  ami             = "ami-05d38da78ce859165"
  instance_type   = "t2.micro"
  subnet_id       = var.subnet_public
  key_name        = var.ssh_key_name
  security_groups = [var.security_group_public]
  tags = {
    Name = "i1"
    Project = "lab13"
    Server_Role = "web"
  }
  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname i1
              EOF
}

resource "aws_instance" "instance2" {
  ami             = "ami-05d38da78ce859165"
  instance_type   = "t2.micro"
  subnet_id       = var.subnet_private
  security_groups = [var.security_group_private]
  key_name        = var.ssh_key_name
  tags = {
    Name = "i2"
    Project = "lab13"
    Server_Role = "backend"
  }

  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname i2
              EOF

}
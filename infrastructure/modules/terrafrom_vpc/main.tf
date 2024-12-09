resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_subnet" "lab13_public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "lab13_private" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true
}

resource "aws_route_table_association" "routetable1" {
  subnet_id      = aws_subnet.lab13_public.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "routetable2" {
  subnet_id      = aws_subnet.lab13_private.id
  route_table_id = aws_route_table.main.id
}

resource "aws_security_group" "lab13_public" {
  name        = "sg_lab13_public"
  description = "Allow ssh access"
  vpc_id      = aws_vpc.main.id
}

resource "aws_security_group" "lab13_private" {
  name        = "sg_lab13_private"
  description = "Allow ssh access"
  vpc_id      = aws_vpc.main.id
}

# ----------------- Security Group for PUBLIC -----------------
# Allow all traffic from the security group itself
resource "aws_vpc_security_group_egress_rule" "pubic_out" {
  security_group_id = aws_security_group.lab13_public.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  tags = {
    Name = "sg_egress_lab13_public"
  }
}

# Allow all traffic from the VPC
resource "aws_vpc_security_group_egress_rule" "vpc_pubic_out" {
  security_group_id = aws_security_group.lab13_public.id
  ip_protocol       = "-1"
  cidr_ipv4         = aws_vpc.main.cidr_block
  tags = {
    Name = "sg_vpc_egress_lab13_public"
  }
}

# Allow all SSH traffic in from anywhere
resource "aws_vpc_security_group_ingress_rule" "public_in" {
  security_group_id = aws_security_group.lab13_public.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
  tags = {
    Name = "sg_ingress_lab13_public"
  }
}

# Allow all HTTP traffic in from anywhere
resource "aws_vpc_security_group_ingress_rule" "all_public_in" {
  security_group_id = aws_security_group.lab13_public.id
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"
  tags = {
    Name = "sg_ingress_lab13_public"
  }
}

# Allow all traffic from VPC
resource "aws_vpc_security_group_ingress_rule" "inside" {
  security_group_id = aws_security_group.lab13_public.id
  ip_protocol       = "-1"
  cidr_ipv4         = aws_vpc.main.cidr_block
  tags = {
    Name = "sg_vpc_ingress_lab13_public"
  }
}

# ----------------- Security Group for PRIVATE -----------------
resource "aws_vpc_security_group_egress_rule" "private_out" {
  security_group_id = aws_security_group.lab13_private.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  tags = {
    Name = "sg_egress_lab13_private"
  }
}

# Allow all traffic from the VPC
resource "aws_vpc_security_group_egress_rule" "vpc_private_out" {
  security_group_id = aws_security_group.lab13_private.id
  ip_protocol       = "-1"
  cidr_ipv4         = aws_vpc.main.cidr_block
  tags = {
    Name = "sg_vpc_egress_lab13_private"
  }
}

# Allow all SSH traffic in from anywhere
resource "aws_vpc_security_group_ingress_rule" "private_in" {
  security_group_id = aws_security_group.lab13_private.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
  tags = {
    Name = "sg_ingress_lab13_private"
  }
}

# Allow all traffic from VPC
resource "aws_vpc_security_group_ingress_rule" "inside2" {
  security_group_id = aws_security_group.lab13_private.id
  ip_protocol       = "-1"
  cidr_ipv4         = aws_vpc.main.cidr_block
  tags = {
    Name = "sg_vpc_ingress_lab13_private"
  }
}
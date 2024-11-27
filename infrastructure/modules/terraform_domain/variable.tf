variable "vpc_id" {
    description = "VPC ID"
    type = string
}

variable "ec2_public_instance" {
    description = "the public ec2 instance"
    type = string
}

variable "ec2_private_instance" {
    description = "the private ec2 instance"
    type = string
}
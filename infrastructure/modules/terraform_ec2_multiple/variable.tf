variable "security_group_public" {
    description = "The public instance security group"
    type = string
}

variable "security_group_private" {
    description = "The private instance security group"
    type = string
}

variable "subnet_public" {
    description = "public subnet"
    type = string
}

variable "subnet_private" {
    description = "private subnet"
    type = string
}

variable "ssh_key_name" {
    description = "ssh key to connect to instances"
    type = string
}
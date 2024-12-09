output "vpc" {
  value = aws_vpc.main
}

output "subnet_lab13_public" {
  value = aws_subnet.lab13_public
}

output "subnet_lab13_private" {
  value = aws_subnet.lab13_private
}

output "sg_lab13_public" {
  value = aws_security_group.lab13_public
}

output "sg_lab13_private" {
  value = aws_security_group.lab13_private
}
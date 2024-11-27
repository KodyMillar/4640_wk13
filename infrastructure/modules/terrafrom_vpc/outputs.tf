output "vpc" {
  value = aws_vpc.main
}

output "sg_lab13_public" {
  value = aws_subnet.lab13_public
}

output "sg_lab13_private" {
  value = aws_subnet.lab13_private
}
output "frontend_dns" {
    value = aws_route53_record.public.name
}

output "backend_dns" {
    value = aws_route53_record.private.name
}
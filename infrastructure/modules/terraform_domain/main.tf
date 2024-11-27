resource "aws_vpc_dhcp_options" "main" {
  domain_name         = "cit.local"
  domain_name_servers = ["AmazonProvidedDNS"]
}

resource "aws_vpc_dhcp_options_association" "main" {
  vpc_id          = aws_vpc.main.id
  dhcp_options_id = aws_vpc_dhcp_options.main.id
}

resource "aws_route53_zone" "main" {
  name = "cit.local"
  vpc {
    vpc_id = var.vpc_id
  }
}

resource "aws_route53_record" "public" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "${var.ec2_public_instance.tags.Name}.cit.local"
  type    = "A"
  ttl     = "300"
  records = [var.ec2_public_instance.private_ip]
}

resource "aws_route53_record" "private" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "${var.ec2_private_instance.tags.Name}.cit.local"
  type    = "A"
  ttl     = "300"
  records = [var.ec2_private_instance.private_ip]
}
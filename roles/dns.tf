provider "aws" {
  region = "us-east-1"  # Adjust the region
}

resource "aws_route53_zone" "example_com" {
  name = "example.com."
}

# Share hosted zones
resource "aws_ram_resource_share" "share_zones" {
  name               = "ShareDNSZones"
  allow_external_principals = true
}

resource "aws_ram_principal_association" "associate_principals" {
  count       = length(var.associated_account_ids)
  resource_arn = aws_route53_zone.example_com.arn
  principal   = "arn:aws:iam::${var.associated_account_ids[count.index]}:root"
}

# Create Resolver endpoints
resource "aws_route53_resolver_rule" "example_rule" {
  domain_name         = "example.com."
  rule_action         = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.example_endpoint.id
}

resource "aws_route53_resolver_endpoint" "example_endpoint" {
  name        = "example-endpoint"
  direction   = "INBOUND"
  security_group_ids = [aws_security_group.resolver_sg.id]
  ip_address {
    subnet_id = aws_subnet.example_subnet.id
  }
}

# Create Security Group, Subnet, and other resources as needed

variable "associated_account_ids" {
  type    = list(string)
  default = []  # List of AWS account IDs to associate with
}

# Define your VPC, Subnet, Security Group, etc. as needed

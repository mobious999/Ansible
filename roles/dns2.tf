provider "aws" {
  region = "us-east-1"  # Adjust the region
}

# Step 1: Create IAM roles, policies, and permissions as needed

# Step 2: Create DNS zones in shared-services account
resource "aws_route53_zone" "healthpn_com" {
  name = "healthpn.com"
}

resource "aws_route53_zone" "medpro_com" {
  name = "medpro.com"
}

# Step 3: Share DNS zones with other AWS accounts
resource "aws_ram_resource_share" "share_zones" {
  name               = "ShareDNSZones"
  allow_external_principals = true
}

resource "aws_ram_principal_association" "associate_principals" {
  count       = length(var.associated_account_ids)
  resource_arn = aws_route53_zone.healthpn_com.arn
  principal   = "arn:aws:iam::${var.associated_account_ids[count.index]}:root"
}

# Step 4: Set up VPCs, subnets, security groups, etc. in other AWS accounts

# Step 5: Create inbound and outbound endpoints in shared-services account

# Step 6: Configure resolver rules for outbound endpoints
resource "aws_route53_resolver_rule" "healthpn_outbound_rule" {
  domain_name         = "healthpn.com."
  rule_action         = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.healthpn_endpoint.id
}

resource "aws_route53_resolver_rule" "medpro_outbound_rule" {
  domain_name         = "medpro.com."
  rule_action         = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.medpro_endpoint.id
}

resource "aws_route53_resolver_endpoint" "healthpn_endpoint" {
  name        = "healthpn-endpoint"
  direction   = "OUTBOUND"
  security_group_ids = [aws_security_group.healthpn_sg.id]
  ip_address {
    subnet_id = aws_subnet.healthpn_subnet.id
  }
}

resource "aws_route53_resolver_endpoint" "medpro_endpoint" {
  name        = "medpro-endpoint"
  direction   = "OUTBOUND"
  security_group_ids = [aws_security_group.medpro_sg.id]
  ip_address {
    subnet_id = aws_subnet.medpro_subnet.id
  }
}

# Define other resources as needed

variable "associated_account_ids" {
  type    = list(string)
  default = []  # List of AWS account IDs to associate with
}

# Define your VPCs, Subnets, Security Groups, etc. as needed

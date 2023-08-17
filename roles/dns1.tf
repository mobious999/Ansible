provider "aws" {
  region = "us-east-1"  # Adjust the region
}

# Step 1: Create IAM roles, policies, and permissions as needed

# Step 2: Create DNS zones in shared-services account
resource "aws_route53_zone" "aws07" {
  name = "aws07.wfl.cloud"
}

resource "aws_route53_zone" "dev" {
  name = "dev.wfl.cloud"
}

resource "aws_route53_zone" "uat" {
  name = "uat.wfl.cloud"
}

resource "aws_route53_zone" "prod" {
  name = "prod.wfl.cloud"
}

# Step 3: Share DNS zones with other AWS accounts
resource "aws_ram_resource_share" "share_zones" {
  name               = "ShareDNSZones"
  allow_external_principals = true
}

resource "aws_ram_principal_association" "associate_principals" {
  count       = length(var.associated_account_ids)
  resource_arn = aws_route53_zone.aws07.arn
  principal   = "arn:aws:iam::${var.associated_account_ids[count.index]}:root"
}

# Step 4: Set up VPCs, subnets, security groups, etc. in other AWS accounts

# Step 5: Create inbound and outbound endpoints in other AWS accounts

# Step 6: Associate DNS zones with specific VPCs in shared-services account
resource "aws_route53_resolver_rule" "aws07_rule" {
  domain_name         = "aws07.wfl.cloud."
  rule_action         = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.aws07_endpoint.id
}

resource "aws_route53_resolver_endpoint" "aws07_endpoint" {
  name        = "aws07-endpoint"
  direction   = "INBOUND"
  security_group_ids = [aws_security_group.resolver_sg.id]
  ip_address {
    subnet_id = aws_subnet.aws07_subnet.id
  }
}

# Define other resources as needed

variable "associated_account_ids" {
  type    = list(string)
  default = []  # List of AWS account IDs to associate with
}

# Define your VPCs, Subnets, Security Groups, etc. as needed

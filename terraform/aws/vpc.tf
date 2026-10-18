resource "aws_vpc" "primary" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "multicloud-sre-aws-vpc"
    Environment = "lab"
    Project     = "multicloud-sre-lab"
    ManagedBy   = "Terraform"
  }
}

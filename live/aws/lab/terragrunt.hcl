include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/aws-networking"
}

inputs = {
  aws_region   = "us-east-1"
  project_name = "multicloud-sre-lab"
  environment  = "lab"
  vpc_cidr     = "10.30.0.0/16"

  public_subnets = {
    a = {
      cidr_block        = "10.30.1.0/24"
      availability_zone = "us-east-1a"
    }
    b = {
      cidr_block        = "10.30.2.0/24"
      availability_zone = "us-east-1b"
    }
  }

  private_subnets = {
    a = {
      cidr_block        = "10.30.11.0/24"
      availability_zone = "us-east-1a"
    }
    b = {
      cidr_block        = "10.30.12.0/24"
      availability_zone = "us-east-1b"
    }
  }
}

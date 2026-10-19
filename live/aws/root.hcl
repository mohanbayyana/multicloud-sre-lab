remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket       = "multicloud-sre-lab-tfstate-888521354368-us-east-1"
    key          = "${path_relative_to_include()}/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

terraform {
  extra_arguments "ci_validate_without_remote_backend" {
    commands  = ["init"]
    arguments = get_env("CI", "false") == "true" ? ["-backend=false"] : []
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<-EOT
    provider "aws" {
      region = var.aws_region
    }
  EOT
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<-EOT
    provider "aws" {
      region = var.aws_region
    }
  EOT
}

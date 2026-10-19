# Multi-Cloud SRE Lab

A hands-on Infrastructure as Code (IaC) and Site Reliability Engineering (SRE) learning project. The current implementation focuses on AWS networking using Terraform, Terragrunt, and GitHub Actions.

## Project Goals

- Build reusable cloud infrastructure using Terraform modules.
- Manage environment-specific configuration with Terragrunt.
- Automate infrastructure code validation using GitHub Actions.
- Practice Git branching, pull requests, code reviews, and CI/CD workflows.
- Gradually expand the project with monitoring, alerting, and reliability exercises.
- Keep infrastructure changes controlled and cloud costs predictable.

## Architecture

The current AWS networking configuration defines:

- One VPC.
- Two public subnets across two Availability Zones.
- Two private subnets across two Availability Zones.
- An Internet Gateway.
- Public and private route tables.
- Subnet-to-route-table associations.

The Terragrunt lab configuration uses the following settings:

| Component | Configuration |
|---|---|
| AWS Region | `us-east-1` |
| Environment | `lab` |
| VPC CIDR | `10.30.0.0/16` |
| Public subnets | `10.30.1.0/24`, `10.30.2.0/24` |
| Private subnets | `10.30.11.0/24`, `10.30.12.0/24` |

The public route table routes internet-bound traffic through the Internet Gateway. The private route table does not configure a NAT gateway or a default internet route.

These values describe the Terraform configuration, not a verified live AWS deployment.

## Repository Structure

```text
multicloud-sre-lab/
├── .github/
│   └── workflows/
│       └── terraform-validate.yml
├── terraform/
│   └── aws/
│       ├── providers.tf
│       ├── vpc.tf
│       ├── subnets.tf
│       ├── internet-gateway.tf
│       ├── route-tables.tf
│       └── outputs.tf
├── modules/
│   └── aws-networking/
│       ├── versions.tf
│       ├── variables.tf
│       ├── vpc.tf
│       ├── subnets.tf
│       ├── internet-gateway.tf
│       ├── route-tables.tf
│       └── outputs.tf
└── live/
    └── aws/
        ├── root.hcl
        └── lab/
            ├── terragrunt.hcl
            └── .terraform.lock.hcl
```

## Terraform and Terragrunt

### Terraform

Terraform defines the infrastructure resources and their relationships.

The reusable networking module is located in `modules/aws-networking/`.

- `versions.tf` declares the required Terraform and AWS provider versions.
- `variables.tf` declares module inputs.
- `vpc.tf` defines the VPC.
- `subnets.tf` defines the public and private subnets.
- `internet-gateway.tf` defines the Internet Gateway.
- `route-tables.tf` defines routing and subnet associations.
- `outputs.tf` exposes useful resource information.

### Terragrunt

Terragrunt configures and runs the reusable Terraform module.

- `live/aws/root.hcl` contains shared configuration and generates the AWS provider configuration.
- `live/aws/lab/terragrunt.hcl` specifies the module source and lab-specific input values.

Terraform modules provide reusable resource definitions, while Terragrunt helps manage environment-specific inputs and shared configuration.

## Prerequisites

Install the following tools:

- Git
- Terraform
- Terragrunt
- Visual Studio Code or another code editor

The project has been validated locally with Terraform `1.16.5` and Terragrunt `1.1.6`.

AWS credentials are not required for the configuration-only validation commands below. AWS credentials may be needed for operations that inspect or modify real AWS infrastructure.

## Local Validation

### Validate the original Terraform configuration

```bash
terraform -chdir=terraform/aws fmt -check -recursive
terraform -chdir=terraform/aws init -backend=false -input=false
terraform -chdir=terraform/aws validate
```

### Validate the reusable networking module

```bash
terraform -chdir=modules/aws-networking fmt -check -recursive
terraform -chdir=modules/aws-networking init -backend=false -input=false
terraform -chdir=modules/aws-networking validate
```

### Validate the Terragrunt lab configuration

Run these commands from the repository root:

```bash
cd live/aws
terragrunt hcl fmt --check --diff
cd lab
terragrunt hcl validate
terragrunt run -- validate
```

## GitHub Actions

The workflow at `.github/workflows/terraform-validate.yml` automates configuration checks for applicable pull requests targeting `main`.

It validates:

- Terraform formatting.
- Terraform initialization and configuration validity.
- The reusable networking module.
- Terragrunt HCL formatting and validity.
- Terraform validation through the Terragrunt lab configuration.

The workflow validates code; it does not deploy infrastructure.

## Development Workflow

1. Update your local `main` branch.
2. Create a feature branch.
3. Make a focused infrastructure or documentation change.
4. Run the relevant validation commands.
5. Review and commit your changes.
6. Push the feature branch and open a pull request.
7. Review the changes and confirm CI checks pass.
8. Merge only when the required checks and reviews are satisfied.

## Cost and Deployment Safety

This repository is intended for controlled learning and experimentation.

- Configuration validation does not deploy AWS infrastructure.
- Review Terraform plans before considering any deployment.
- Check estimated AWS charges before creating billable resources.
- Avoid committing credentials, access keys, state files, or sensitive configuration.
- Do not run `terraform apply` or `terragrunt run -- apply` without reviewing the plan and explicitly approving the deployment.

## Planned Enhancements

- Improve infrastructure documentation and architecture diagrams.
- Review Terraform plans and resource dependencies.
- Add monitoring, health checks, and alerting.
- Practice incident response and recovery scenarios.
- Explore additional cloud providers as the project evolves.

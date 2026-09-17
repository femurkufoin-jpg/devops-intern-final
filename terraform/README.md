# Terraform Infrastructure

This directory contains Terraform configuration for an AWS VPC and public subnet.

## What it creates

- One VPC
- One public subnet

## Requirements

- Terraform >= 1.6.0
- An AWS account and configured AWS credentials for deployment

## Validate without AWS

The configuration can be formatted and validated without creating AWS resources:

```bash
terraform -chdir=terraform fmt
terraform -chdir=terraform init
terraform -chdir=terraform validate
```

`terraform validate` checks the configuration syntax and structure. It does not create infrastructure.

## Deploy

Deployment requires an AWS account and credentials:

```bash
terraform -chdir=terraform plan
terraform -chdir=terraform apply
```

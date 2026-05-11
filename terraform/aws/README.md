# AWS RDS PostgreSQL Module for SlackerNews

This Terraform module provisions an Amazon RDS PostgreSQL instance optimized for SlackerNews.

## Features

- PostgreSQL 16 (aligned with in-cluster default)
- Multi-AZ high availability
- Encryption at rest
- Preset sizing tiers with override capability
- Outputs a `postgres://` connection URI compatible with the SlackerNews Helm chart

## Usage

```hcl
module "slackernews_postgres" {
  source = "github.com/slackernews/slackernews-terraform//aws?ref=v1.0.0"

  name   = "slackernews-db"
  region = "us-east-1"
  size   = "medium"

  # Optional: override the preset instance class
  # instance_class = "db.r6g.xlarge"
}
```

## Inputs

See `variables.tf` for all inputs and defaults.

## Outputs

See `outputs.tf` for all outputs.

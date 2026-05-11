# GCP Cloud SQL PostgreSQL Module for SlackerNews

This Terraform module provisions a Google Cloud SQL PostgreSQL instance optimized for SlackerNews.

## Features

- PostgreSQL 16 (aligned with in-cluster default)
- High availability (regional instance)
- Encryption at rest (Cloud KMS or default Google-managed)
- Preset sizing tiers with override capability
- Outputs a `postgres://` connection URI compatible with the SlackerNews Helm chart

## Usage

```hcl
module "slackernews_postgres" {
  source = "github.com/slackernews/slackernews-terraform//gcp?ref=v1.0.0"

  name   = "slackernews-db"
  region = "us-central1"
  size   = "medium"

  # Optional: override the preset tier
  # tier = "db-custom-4-16384"
}
```

## Inputs

See `variables.tf` for all inputs and defaults.

## Outputs

See `outputs.tf` for all outputs.

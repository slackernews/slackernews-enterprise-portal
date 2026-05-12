# Azure Database for PostgreSQL Flexible Server Module for SlackerNews

This Terraform module provisions an Azure Database for PostgreSQL Flexible Server optimized for SlackerNews.

## Features

- PostgreSQL 16 (aligned with in-cluster default)
- Zone-redundant high availability
- Encryption at rest (Azure-managed keys by default)
- Preset sizing tiers with override capability
- Outputs a `postgres://` connection URI compatible with the SlackerNews Helm chart

## Usage

```hcl
module "slackernews_postgres" {
  source = "github.com/slackernews/slackernews-terraform//azure?ref=v1.0.0"

  name                = "slackernews-db"
  location            = "East US"
  resource_group_name = "my-rg"
  size                = "medium"

  # Optional: override the preset SKU
  # sku_name = "GP_Standard_D4s_v3"
}
```

## Inputs

See `variables.tf` for all inputs and defaults.

## Outputs

See `outputs.tf` for all outputs.

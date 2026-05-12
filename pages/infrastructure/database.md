---
title: Database Setup
visible_when:
  entitlements:
    - is_terraform_enabled
---

# Database Setup

SlackerNews requires a PostgreSQL database. The standard Helm chart can deploy one in-cluster, but for production workloads we recommend using a managed database service.

## Why use a managed database?

- **High availability** — managed services provide automated failover and redundancy
- **Automated backups** — point-in-time recovery without manual configuration
- **Encryption at rest** — data is encrypted by default on managed services
- **Stateless application** — keeping the database outside the cluster makes your SlackerNews deployment easier to manage and upgrade

## Using Terraform

If your license includes infrastructure automation, you can use the provided Terraform modules to provision a managed PostgreSQL 16 database on your cloud provider of choice.

### Prerequisites

1. Terraform installed on your workstation (1.4.0 or later)
2. Cloud provider CLI authenticated (AWS CLI, gcloud, or Azure CLI)
3. A VPC / network / resource group already provisioned

### Quick Start

Choose your cloud provider from the Infrastructure section in the sidebar. Each module provides:

- **Preset sizing** — choose `small`, `medium`, `large`, or `extra_large` for common workloads
- **Custom overrides** — experienced operators can override individual cloud-specific specs (instance class, tier, SKU)
- **High availability** — enabled by default
- **Encryption at rest** — enabled by default
- **Connection URI output** — copy the `connection_uri` output directly into your SlackerNews Helm values

### Connecting SlackerNews

After running `terraform apply`, retrieve the connection URI from the module outputs:

```bash
terraform output -raw connection_uri
```

Use this value when installing or upgrading SlackerNews:

```bash
helm install slackernews slackernews/slackernews \
  --set postgres.deploy_postgres=false \
  --set postgres.uri="$(terraform output -raw connection_uri)"
```

### Sizing Guide

| Tier | Recommended For |
|------|----------------|
| **Small** | Teams up to 50, light usage, evaluation |
| **Medium** | Teams up to 500, moderate daily usage |
| **Large** | Teams up to 2,000, heavy usage |
| **Extra Large** | Enterprise deployments, very high concurrency |

If you're unsure, start with **Medium** and monitor utilization. You can resize most managed instances with minimal downtime.

## Manual Setup

If you prefer not to use Terraform, you can manually provision a PostgreSQL 16 instance on any supported managed service and provide the connection URI to the SlackerNews Helm chart using the `postgres.uri` value.

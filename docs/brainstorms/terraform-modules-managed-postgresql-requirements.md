---
date: 2026-05-11
topic: terraform-modules-managed-postgresql
---

# Terraform Modules for Managed PostgreSQL Database

## Summary

Create Terraform modules (AWS RDS, GCP Cloud SQL, Azure Flexible Server) that provision a managed PostgreSQL 16 database for Slacker News with preset sizing tiers and raw-spec overrides. Integrate the modules into the Slacker News Enterprise Portal via module reference docs and the proxy registry.

---

## Problem Frame

Slacker News requires a PostgreSQL database. The standard Helm chart deploys Postgres in-cluster by default, but the documentation recommends using a managed service to keep the application stateless. Today, customers who want to follow that recommendation must research, design, and implement their own Terraform (or equivalent) to provision a managed database on their chosen cloud provider. This creates friction during installation and increases the risk of misconfiguration. Providing ready-made, cloud-specific Terraform modules inside the Enterprise Portal collapses that work into a single, documented, license-authenticated step.

---

## Requirements

**Module content**
- R1. Terraform modules for AWS RDS, GCP Cloud SQL, and Azure Database for PostgreSQL Flexible Server that provision a managed PostgreSQL 16 instance
- R2. Each module must enable high availability and encryption at rest by default
- R3. A single `size` variable (small, medium, large, extra_large) that maps to cloud-specific instance classes / tiers / SKUs, with the mapping documented in each module's README
- R4. Optional raw cloud-specific spec variables (e.g., `instance_class`, `tier`, `sku_name`) that override the preset mapping when explicitly set
- R5. Each module must output the `postgres://` connection URI (or host, port, database, username, password separately) so it can be consumed directly by the Slacker News Helm chart's `postgres.uri` value

**Enterprise Portal integration**
- R6. Add `terraform_module` entries to `toc.yaml` for each cloud module, linking to the Terraform repo source
- R7. Gate Terraform content with an `isTerraformEnabled` entitlement (applied in license fields)
- R8. Gate per-cloud content with per-cloud entitlements (`isAWSEnabled`, `isAzureEnabled`, `isGCPEnabled`)
- R9. Enable the proxy registry so customers can `terraform init` using `proxy.replicated.com` with their license ID

**Module structure**
- R10. Each module follows standard Terraform conventions: `variables.tf`, `outputs.tf`, `versions.tf`, and `README.md`
- R11. `versions.tf` declares minimum Terraform and provider versions required for the managed service resources

---

## Acceptance Examples

- AE1. **Covers R1, R2, R3, R5.** Given a customer selects `size = "medium"` on the AWS module, when they run `terraform apply`, the result is an RDS PostgreSQL 16 instance with Multi-AZ enabled, storage encrypted, and the module outputs a `postgres://` URI.
- AE2. **Covers R3, R4.** Given a customer sets `size = "small"` and also `instance_class = "db.r6g.xlarge"` on the AWS module, when they run `terraform apply`, the instance class used is `db.r6g.xlarge` (raw override takes precedence over preset mapping).
- AE3. **Covers R6, R7, R8.** Given a customer with `isTerraformEnabled` and `isAWSEnabled` entitlements, when they open the Enterprise Portal, they see an "Infrastructure" or "Database" nav section containing the AWS Terraform module reference page.
- AE4. **Covers R9.** Given a customer on a promoted release channel, when they run `terraform init` with `source = "proxy.replicated.com/slackernews/slackernews-terraform/github"` and `version = "1.0.0"`, the module tarball is fetched via the proxy registry using their license ID.
- AE5. **Covers R1, R4.** Given a customer using the Azure module, when they set `sku_name = "GP_Standard_D4s_v3"` explicitly, the Flexible Server is provisioned with that SKU regardless of the `size` preset.

---

## Success Criteria

- A licensed customer can browse cloud-specific Terraform module docs inside the Enterprise Portal and copy a usage example without leaving the portal
- A customer can run `terraform init` and `terraform apply` using the proxy registry and produce a working PostgreSQL 16 database that the Slacker News Helm chart can connect to
- The modules reduce the time from "I need a managed database" to "Slacker News is running" compared to writing custom Terraform
- Module reference pages in the EP correctly display inputs, outputs, and requirements parsed from the linked Terraform repo

---

## Scope Boundaries

- No Terraform modules for databases other than PostgreSQL or for cloud providers other than AWS, GCP, and Azure
- No changes to in-cluster PostgreSQL deployment logic in the Slacker News Helm chart
- No application-level database migration, seeding, or schema management tooling
- No multi-region replication, read replicas, or cross-cloud failover automation
- No backup/restore automation beyond what the managed service provides by default
- No Terraform state backend provisioning or guidance for customers
- No cost estimation, pricing calculators, or billing dashboards

---

## Key Decisions

- **Preset sizing + raw override.** The module interface exposes a simple `size` enum for quickstarts while allowing experienced operators to override with native cloud specs. Rationale: balances ease-of-use for new customers with flexibility for power users.
- **Separate Terraform repo for module source.** Module source code lives in its own repository (linked in Vendor Portal for proxy registry) rather than inside the content repo. Rationale: the proxy registry requires a distinct linked repo; mixing module source with markdown content complicates tagging and versioning.
- **Per-cloud entitlements for gating.** Each cloud module is gated by its own entitlement in addition to the global `isTerraformEnabled` flag. Rationale: Slacker News may license cloud support selectively or pilot one provider before others.
- **PostgreSQL 16 aligned with in-cluster default.** The managed database version matches the version deployed when `postgres.deploy_postgres: true`. Rationale: keeps behavior consistent across deployment modes and avoids version drift.

---

## Dependencies / Assumptions

- The `Terraform Modules in Enterprise Portal` feature flag is enabled by Replicated for the Slacker News team in the Vendor Portal
- The Replicated GitHub App has access to both the content repo and the Terraform module repo
- Managed PostgreSQL 16 is available on AWS RDS, GCP Cloud SQL, and Azure Flexible Server in all target regions
- The Terraform repo will be tagged with `v`-prefixed git tags that match promoted release `version_label` values (e.g., release `1.0.0` requires tag `v1.0.0`)
- Customers using the modules have an existing VPC / network / resource group (or the modules accept network IDs as variables)
- The Slacker News chart's `postgres.uri` format is compatible with the connection string output by the modules

---

## Outstanding Questions

### Deferred to Planning

- [Affects R3][Technical] What are the exact cloud-specific instance classes / tiers / SKUs for each size preset? Needs mapping table per cloud.
- [Affects R1][Technical] Should the modules create the VPC/network/subnet resources, or accept existing network IDs as input variables?
- [Affects R5][Technical] Should the module output a full `postgres://` URI string, or individual host/port/user/password outputs (or both)?
- [Affects R1][Needs research] Do AWS RDS, GCP Cloud SQL, and Azure Flexible Server all support PostgreSQL 16 in general availability today?

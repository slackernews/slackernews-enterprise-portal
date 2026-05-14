---
title: Installation Overview
---

# Installation Overview

SlackerNews supports three installation methods. Choose the one that fits your infrastructure.

## Embedded Cluster (Linux VM)

The simplest way to get started with SlackerNews is on a single Linux VM using Embedded Cluster. This method bundles Kubernetes and SlackerNews into a single installer — no existing cluster required.

<Tip title="Best for">
Teams without an existing Kubernetes cluster who want the fastest path to a working SlackerNews instance.
</Tip>

{{#if entitlements.isEmbeddedClusterDownloadEnabled}}
- [Linux Installation](linux)
- [System Requirements](requirements)
{{/if}}

## Helm (Existing Kubernetes)

If you already have a Kubernetes cluster (EKS, GKE, AKS, Rancher, etc.), install SlackerNews using Helm. This gives you full control over the deployment and integrates into your existing infrastructure and CI/CD pipelines.

<Tip title="Best for">
Teams with existing Kubernetes expertise and cluster resources.
</Tip>

{{#if entitlements.isHelmInstallEnabled}}
- [Helm Installation](helm)
{{/if}}

{{#if entitlements.isDockerComposeEnabled}}
## Docker Compose

If you prefer a container-based deployment without Kubernetes, use Docker Compose. This method runs PostgreSQL, SlackerNews, and a Caddy reverse proxy on a single host with automatic TLS via Let's Encrypt.

<Tip title="Best for">
Teams that want a simple, self-managed container deployment without cluster orchestration.
</Tip>

- [Docker Compose Installation](docker-compose)
{{/if}}

## Demo Mode

If you want to evaluate SlackerNews without connecting it to your live Slack workspace, you can run in **Demo Mode**. This generates synthetic content so you can explore the UI and features immediately.

- [Demo Mode Installation](demo)

## Release History

View past releases and changelogs:

- [Release History](release-history)

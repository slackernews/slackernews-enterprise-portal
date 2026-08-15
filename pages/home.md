---
title: SlackerNews Documentation
---

# SlackerNews Documentation

Welcome to the SlackerNews documentation portal. The navigation and content are customized based on your license entitlements.

## What is SlackerNews?

SlackerNews is a private news site (like Hacker News or Reddit) automatically populated from your company's internal tools — Slack, Google Workspace, GitHub, Jira, Asana, and more. Your team can discover the most discussed documents, links, repos, and issues each week.

SlackerNews is self-hosted, giving your organization full control over data security and privacy.

## Available Features

Your installation includes access to the following features:

{{#if entitlements.isEmbeddedClusterDownloadEnabled}}
- **Linux (Embedded Cluster):** Install on a Linux server using Embedded Cluster
{{/if}}
{{#if entitlements.isHelmInstallEnabled}}
- **Helm Installation:** Deploy to existing Kubernetes clusters using Helm charts
{{/if}}
{{#if entitlements.isDockerComposeEnabled}}
- **Docker Compose:** Run on a single host with Docker Compose and automatic TLS
{{/if}}
{{#if entitlements.isAirgapSupported}}
- **Air Gap Support:** Install in disconnected environments
{{/if}}

## Getting Started

<Tip title="New to SlackerNews?">
Start with the Getting Started guide to set up your domain, Slack app, and installation prerequisites.
</Tip>

1. **[Getting Started](../getting-started/intro)** — Learn how SlackerNews works and what you need before installing
2. **[Prerequisites](../getting-started/prerequisites)** — License, domain, Slack admin rights, and cluster access
3. **[Domain Setup](../getting-started/domain)** — Configure your custom domain and TLS
4. **[Slack App](../getting-started/slack-app)** — Create and install the Slack app with the correct scopes
5. **[Installation](../installation/overview)** — Choose your installation method (Embedded Cluster or Helm)

## Quick Links

<OptionSelector label="Install Method" defaultOption="Linux" storageKey="install-method">
<Option value="Linux">

{{#if entitlements.isEmbeddedClusterDownloadEnabled}}
- [Installation Requirements](../installation/requirements)
- [Linux Installation](../installation/linux)
{{/if}}
- [Release History](../installation/release-history)
- [Post-Install Configuration](../post-install/configuration)
- [Support Bundles](../support/bundles)
- [FAQ](../support/faq)

</Option>
<Option value="Helm">

{{#if entitlements.isHelmInstallEnabled}}
- [Helm Installation](../installation/helm)
{{/if}}
- [Release History](../installation/release-history)
- [Post-Install Configuration](../post-install/configuration)
- [Support Bundles](../support/bundles)
- [FAQ](../support/faq)

</Option>
{{#if entitlements.isDockerComposeEnabled}}
<Option value="Docker Compose">

- [Docker Compose Installation](../installation/docker-compose)
- [Release History](../installation/release-history)
- [Post-Install Configuration](../post-install/configuration)
- [Support Bundles](../support/bundles)
- [FAQ](../support/faq)

</Option>
{{/if}}
</OptionSelector>

## Need Help?

- **[Troubleshooting](../support/troubleshooting)** — Common issues and diagnostic steps
- **[Support Bundles](../support/bundles)** — Generate and upload diagnostic bundles
- **[Contact Support](../support/contact)** — Reach out to our support team

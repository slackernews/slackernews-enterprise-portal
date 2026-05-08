---
title: Frequently Asked Questions
---

# Frequently Asked Questions

## General

{{#if entitlements.isEmbeddedClusterDownloadEnabled}}
<Accordion title="What are the system requirements?">

See [Requirements](../installation/requirements) for Embedded Cluster system requirements, and [Prerequisites](../getting-started/prerequisites) for SlackerNews-specific prerequisites.

</Accordion>
{{/if}}

<Accordion title="What is SlackerNews?">

SlackerNews is a private news site (like Hacker News or Reddit) automatically populated from your company's internal tools (Slack, Google Workspace, GitHub, Jira, Asana, etc). For more details, see the [Getting Started Intro](../getting-started/intro).

</Accordion>

<Accordion title="How do I check for updates?">

See [Updates](../post-install/updates) for update instructions, or visit the [Instances & Updates](../post-install/updates) page to manage your deployment.

</Accordion>

<Accordion title="Do I need a Slack workspace admin to install?">

Yes, you need admin rights on your Slack Workspace (or approval from an admin) to create the Slack app required for SlackerNews. See the [Slack App setup guide](../getting-started/slack-app).

</Accordion>

{{#if entitlements.isHelmInstallEnabled}}
## Installation

<Accordion title="Which installation method should I use?">

{{#if entitlements.isEmbeddedClusterDownloadEnabled}}
Choose [Embedded Cluster (Linux)](../installation/linux) for installing on a Linux server, or [Helm](../installation/helm) for deploying to an existing Kubernetes cluster.
{{else}}
Use [Helm](../installation/helm) to deploy to your existing Kubernetes cluster.
{{/if}}

</Accordion>
{{/if}}

## Troubleshooting

<Accordion title="How do I collect diagnostic information?">

See [Support Bundles](./bundles) to generate a new bundle, or [upload an existing one](./bundles#upload-an-existing-bundle).

</Accordion>

<Accordion title="I forgot to set my domain before installing — what now?">

You can update the domain and TLS settings after installation via the admin console or by running a Helm upgrade with the correct `slackernews.domain` and `service.tls.*` values.

</Accordion>

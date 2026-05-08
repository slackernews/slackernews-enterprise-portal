---
title: Demo Mode
---

# Demo Mode

Demo Mode allows you to evaluate SlackerNews without connecting it to your live Slack workspace. In Demo Mode, the application generates synthetic content so you can explore the UI and features immediately.

## Prerequisites

- A valid SlackerNews license
- One of the supported installation methods (Embedded Cluster or Helm)
- No Slack app or workspace admin rights required

## Installation

Install SlackerNews using your preferred method:

{{#if entitlements.isEmbeddedClusterDownloadEnabled}}
- Follow the [Linux Installation](linux) instructions
{{/if}}
{{#if entitlements.isHelmInstallEnabled}}
- Follow the [Helm Installation](helm) instructions
{{/if}}

## Enabling Demo Mode

After installation, enable Demo Mode by setting the following environment variable or Helm value:

<CommandBlock>
# For Embedded Cluster
kubectl set env deployment/slackernews-web SLACKERNEWS_DEMO_MODE=true -n slackernews

# For Helm
helm upgrade slackernews oci://chart.slackernews.io/slackernews/slackernews \
  --namespace slackernews \
  --set slackernews.demoMode=true
</CommandBlock>

## Accessing the Application

Once Demo Mode is enabled, you can access the application via port-forward:

<CommandBlock>
kubectl port-forward svc/slackernews-nginx 8080:80 -n slackernews
</CommandBlock>

Then open `http://localhost:8080` in your browser.

<Tip title="Evaluate and Migrate">
Demo Mode is great for evaluation. When you're ready to move to production, reinstall with your real Slack app credentials and disable Demo Mode.
</Tip>

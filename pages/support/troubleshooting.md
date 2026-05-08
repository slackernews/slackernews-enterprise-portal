---
title: Troubleshooting
---

# Troubleshooting SlackerNews

Sometimes things aren't working right and we've included some built-in tools to help troubleshoot your installation.

## Support Bundles

The first place to start troubleshooting is to collect a support bundle. A support bundle is a single archive that has redacted logs, metrics, and other data about the installation. Application data and sensitive information (IP addresses, passwords, etc) are all automatically redacted from this archive.

### Using the Admin Console

If you deployed SlackerNews with Embedded Cluster, navigate to the admin console URL printed at install time. The admin console includes a "Troubleshoot" tab for generating support bundles.

### Using the CLI

If you don't have access to the admin console, you can also collect the same support bundle from the CLI, assuming you have `kubectl` access to the cluster:

<CommandBlock>
kubectl krew install support-bundle
kubectl support-bundle oci://registry.replicated.com/slackernews/unstable
</CommandBlock>

The CLI will tell you where the archive is saved. If the built-in analyzers don't solve your problem, please [contact us](./contact) and send the support bundle archive for our team to look at.

## Common Issues

### Pods Not Starting

<CommandBlock>
kubectl get pods -n slackernews
kubectl describe pod <pod-name> -n slackernews
kubectl logs <pod-name> -n slackernews
</CommandBlock>

### Slack Events Not Received

- Verify your Slack app's **Request URL** points to `https://<your-domain>/api/webhooks/slack`
- Ensure your domain is publicly accessible and uses HTTPS
- Check the Slack app manifest matches the [Slack App setup guide](../getting-started/slack-app)

### Database Connection Errors

If using an external Postgres, verify:
- The `postgres.uri` value is correct and accessible from the cluster
- Network policies or firewalls are not blocking the connection
- The database user has the necessary permissions

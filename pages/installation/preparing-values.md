---
title: Preparing Values
visible_when:
  entitlements:
    - isHelmInstallEnabled
---

# Preparing Values

## Postgres

SlackerNews can use a Postgresql database to store and track activity on shared links. The standard Helm chart includes a containerized version of Postgres to run, and defaults to enabling this.

It may be preferable to run your own Postgres database, if you'd prefer to manage the stateful components of SlackerNews separately.

If you want to run Postgres outside of the cluster, use the following parameters to `helm install` or `helm upgrade`:

```
--set postgres.deploy_postgres=false \
--set postgres.uri=postgres://...
```

## Slack

Once you've created a [Slack app](../getting-started/slack-app), you'll need the ClientID, ClientSecret, and Bot Token to use as parameters:

```
--set slack.clientId=3688491666547.38597... \
--set slack.clientSecret=96761d... \
--set slack.token=xoxb-3688491666...
```

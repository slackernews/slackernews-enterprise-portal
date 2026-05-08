---
title: Helm Installation
visible_when:
  entitlements:
    - isHelmInstallEnabled
---

# Helm Installation

Install SlackerNews on a Kubernetes cluster using Helm charts. Read the docs or select your deployment preferences.

## Requirements

Review the following prerequisites before installing.

- Kubernetes cluster v1.26 or later
- Helm 3.x installed on your workstation
- kubectl configured with cluster access
- StorageClass available for persistent volumes

<Tip title="Before You Begin">
Run `kubectl get sc` to confirm a default StorageClass is available. If no default is set, the installation will fail when creating persistent volume claims.
</Tip>

## Choose an installation

<PendingInstallSelector method="helm" />

<NewInstall method="helm" />

<InstanceName method="helm" />

## Configuration

Customize the options below. The install commands will update automatically based on your selections.

<KubernetesDistribution />
<NetworkAvailability installType="helm" />
<RegistryAccess />
<VersionSelector installType="helm" />

## Install

<Note>
The commands below are personalized to your selected installation. If you switch installations or rename your instance, the commands will update automatically.
</Note>

<HelmInstallAssets />

## Post-Install

<Note>
After installation, verify that all pods are running with `kubectl get pods -n <namespace>` before proceeding to post-installation configuration.
</Note>

After installation, configure your Slack app tokens in the admin console at `/admin/slack` to complete setup. See the [Post-Install Configuration](../post-install/configuration) page for more details.

## Chart Configuration

The following values can be provided to the chart when installing. For more information on these parameters, see the [Preparing Values](./preparing-values) docs.

### Required and Commonly Used Values

#### Database

| Key | Default | Description |
|-----|---------|-------------|
| `postgres.deploy_postgres` | `true` | When `true`, the required postgres database will be deployed in cluster. Set to false if you are running this on your own. We recommend using a managed service to run the database, and then the SlackerNews instance in your cluster will be stateless. |
| `postgres.password` | | Required when running postgres in the cluster only. This must be set to the password for the postgres database. When deploying postgres in-cluster, set to the value you want to use for the password |
| `postgres.uri` | | This is required when `postgres.deploy_postgres` is set to `false`. Set this to the psql:// connection string for your managed postgres service |
| `postgres.existingSecretName` | | Optionally set to the name of an existing Kubernetes secret (in the same namespace) that has the postgres secrets |
| `postgres.existingSecretPasswordKey` | | Optionally set to the key in the `postgres.existingSecretName` secret, containing the password (used when `postgres.deploy_postgres` is `true`) |
| `postgres.existingSecretUriKey` | | Optionally set to the key in the `postgres.existingSecretName` secret, containing the psql:// uri (used when `postgres.deploy_postgres` is `false`) |

#### Service

| Key | Default | Description |
|-----|---------|-------------|
| `slackernews.domain` | | Set to the FQDN (fully qualified domain name) you will configure for this instance |
| `service.tls.existingSecretName` | | Set to an existing secret name that has the TLS key and cert (optional) |
| `service.tls.existingSecretCertKey` | | Set to the key in the `existingSecretName` for the cert |
| `service.tls.existingSecretKeyKey` | | Set to the key in the `existingSecretName` for the key |
| `service.tls.cert` | | Set to the value of a TLS cert |
| `service.tls.key` | | Set to the value of a TLS key |
| `service.tls.enabled` | | Set to true to enable TLS |

#### Slack

| Key | Default | Description |
|-----|---------|-------------|
| `slack.clientId` | | Set to the clientId from your Slack app. If not provided, you will be prompted to enter this in the application after installing. |
| `slack.clientSecret` | | Set to the clientSecret from your Slack app. If not provided, you will be prompted to enter this in the application after installing. |
| `slack.botToken` | | Set to the bot token from your Slack app (starts with `xoxb-`). If not provided, you will be prompted to enter this in the application after installing. |
| `slack.userToken` | | Set to the user token from your Slack app (starts with `xoxp-`). If not provided, you will be prompted to enter this in the application after installing. |
| `slack.existingSecretName` | | Optionally, set to the name of a secret that contains the Slack values. |
| `slack.existingSecretBotTokenKey` | | Optionally, set to the name of the key in the `existingSecretName` that contains the bot token for the Slack app. |
| `slack.existingSecretUserTokenKey` | | Optionally, set to the name of the key in the `existingSecretName` that contains the user token for the Slack app. |
| `slack.existingSecretClientIdKey` | | Optionally, set to the name of the key in the `existingSecretName` that contains the clientId for the Slack app. |
| `slack.existingSecretClientSecretKey` | | Optionally, set to the name of the key in the `existingSecretName` that contains the clientSecret for the Slack app. |

### Additional Values

| Key | Default | Description |
|-----|---------|-------------|
| `images.slackernews.repository` | `images.slackernews.io/proxy/slackernews/ghcr.io/slackernews/slackernews-web:1.0.5` | The container image (without the tag) to pull the SlackerNews Web image from |
| `images.slackernews.pullPolicy` | `IfNotPresent` | Image pull policy for the slackernews image |
| `images.slackernews.pullSecret` | `replicated` | The name of the image pull secret to use in the slackernews image |

## Example values.yaml

<CodeBlock language="yaml" title="values.yaml">
postgres:
  deploy_postgres: true
  password: changeme
slackernews:
  domain: news.example.com
service:
  tls:
    enabled: true
    cert: |
      -----BEGIN CERTIFICATE-----
      ...
      -----END CERTIFICATE-----
    key: |
      -----BEGIN PRIVATE KEY-----
      ...
      -----END PRIVATE KEY-----
slack:
  clientId: ""
  clientSecret: ""
  botToken: ""
  userToken: ""
</CodeBlock>

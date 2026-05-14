---
title: Docker Compose Installation
---

# Docker Compose Installation

Install SlackerNews on any Linux or macOS host using Docker Compose. This method runs PostgreSQL, the SlackerNews application, and a Caddy reverse proxy as containers — no Kubernetes cluster required.

<Note title="Self-Managed Infrastructure">
Docker Compose is best for teams that prefer container-based deployments without orchestration. Caddy handles TLS automatically via Let's Encrypt.
</Note>

## Requirements

Before starting, ensure you have the following prerequisites in place:

- Docker Engine 20.10+ and Docker Compose v2.x installed
- A public domain or subdomain with a DNS A/AAAA record pointing to your host
- Ports **80** and **443** available on the host (Caddy binds these for Let's Encrypt)
- Your Slack app credentials (Client ID, Client Secret, Bot Token, User Token)
- Root or sudo access to manage Docker services

<Warning title="Port Availability">
If another service (such as nginx or Apache) is using ports 80 or 443, stop it before running Docker Compose. Caddy requires these ports to provision and renew TLS certificates.
</Warning>

## Download Configuration Files

Create a directory for your SlackerNews deployment and download the following files:

- [docker-compose.yml]({{asset "assets/docker-compose.yml"}})
- [.env.example]({{asset "assets/.env.example"}})
- [Caddyfile]({{asset "assets/Caddyfile"}})

You will rename `.env.example` to `.env` and customize it with your values in the next step.

## Environment Configuration

Copy `.env.example` to `.env` and fill in all values marked with `<...>`.

### Required Variables

| Variable | Description |
|----------|-------------|
| `SLACKERNEWS_DOMAIN` | Public FQDN where SlackerNews will be served. Must resolve to this host. |
| `SLACKERNEWS_SLACK_AUTH_CLIENT_ID` | Client ID from your Slack app's **Basic Information** page. |
| `SLACKERNEWS_SLACK_AUTH_CLIENT_SECRET` | Client Secret from your Slack app's **Basic Information** page. |
| `SLACKERNEWS_SLACK_USER_TOKEN` | User token (starts with `xoxp-`) from **OAuth & Permissions**. |
| `SLACKERNEWS_SLACK_BOT_TOKEN` | Bot token (starts with `xoxb-`) from **OAuth & Permissions**. |
| `POSTGRES_PASSWORD` | Password for the PostgreSQL database. Must match the password embedded in `DB_URI`. |
| `DB_URI` | PostgreSQL connection string. The hostname `postgres` resolves inside the Docker network. |
| `SLACKERNEWS_ADMIN_USER_EMAILS` | Comma-separated Slack email addresses granted super-admin on first login. |

### Optional: Let's Encrypt Staging

Uncomment the following line in `.env` to use the Let's Encrypt staging server during initial setup. This avoids rate limits while testing.

```bash
CADDY_TLS_CA=https://acme-staging-v02.api.letsencrypt.org/directory
```

Once everything works, remove or comment this line to switch to production certificates.

## Docker Compose Services

The [`docker-compose.yml`]({{asset "assets/docker-compose.yml"}}) defines three services:

### PostgreSQL

A PostgreSQL 16 container with a persistent volume for data storage. A healthcheck ensures the database is ready before SlackerNews starts.

### SlackerNews

The SlackerNews application container built from the local `slackernews` directory. It depends on PostgreSQL and receives all environment variables from `.env`.

### Caddy

A Caddy 2 reverse proxy that terminates TLS and forwards traffic to the SlackerNews application on port 3000. Caddy automatically provisions and renews Let's Encrypt certificates for `SLACKERNEWS_DOMAIN`.

## Caddy Configuration

The [`Caddyfile`]({{asset "assets/Caddyfile"}}) configures automatic HTTPS with Let's Encrypt. Caddy uses the `SLACKERNEWS_DOMAIN` environment variable to determine which domain to serve, and reverse-proxies all requests to the `slackernews` container on port 3000.

## Install

After configuring `.env`, start the services:

<CommandBlock>
docker compose up -d
</CommandBlock>

Docker Compose will pull the PostgreSQL and Caddy images, build the SlackerNews image, create the Docker network and volumes, and start all containers in the correct order.

<Tip title="First Start">
The initial build and database initialization may take a few minutes. You can watch the logs with:

```bash
docker compose logs -f slackernews
```
</Tip>

## Verify Installation

Once the containers are running, confirm everything is healthy:

<CommandBlock>
# Check container status
docker compose ps

# View application logs
docker compose logs -f slackernews

# Test the endpoint
curl -I https://$SLACKERNEWS_DOMAIN
</CommandBlock>

You should see a `200 OK` response from Caddy, and the SlackerNews UI should be accessible in your browser at `https://<your-domain>`.

## Post-Install

After the application is running, complete the following steps in the web UI:

1. Navigate to `https://<your-domain>/admin/slack`
2. Enter your Slack app credentials if they were not provided via environment variables
3. Invite the Slack bot to your workspace
4. Confirm that admin users listed in `SLACKERNEWS_ADMIN_USER_EMAILS` can log in

For additional configuration options, see the [Post-Install Configuration](../post-install/configuration) page.

## Updating

To update to a newer version of SlackerNews:

<CommandBlock>
# Pull the latest code
git pull origin main

# Rebuild and restart
docker compose up -d --build
</CommandBlock>

This rebuilds the SlackerNews image with the latest code and restarts the container while preserving the PostgreSQL data volume.

## Troubleshooting

### TLS Certificate Issues

If you see certificate warnings during testing, verify whether `CADDY_TLS_CA` is still set to the staging server. Remove it from `.env` and restart Caddy:

<CommandBlock>
docker compose restart caddy
</CommandBlock>

### Database Connection Failures

If SlackerNews fails to start with database errors, confirm that `POSTGRES_PASSWORD` matches the password in `DB_URI`, and that special characters in the password are URL-encoded.

### Port Conflicts

If Docker reports that ports 80 or 443 are already in use, identify the conflicting service and stop it before starting Caddy:

<CommandBlock>
sudo lsof -i :80
sudo lsof -i :443
</CommandBlock>

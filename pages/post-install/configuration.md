---
title: Configuration
---

# Configuration

Once the chart is installed and running, you can configure the application at:

```
http[s]://<ip address>/admin
```

(The exact URL is going to vary based on how you installed and configured the chart).

The application configuration is split into several sections:

## Authentication

This is used to control which users have access to SlackerNews. We currently support Slack Auth only.

<Note>
Login is automatically restricted to users who are logging into the Slack app that the bot token is installed on.
</Note>

## Chrome Plugin

The SlackerNews Chrome plugin is the easiest way for site admins to turn the URLs collected and displayed into a richer experience by collecting page titles for each link (without having to integrate with each authenticated service directly).

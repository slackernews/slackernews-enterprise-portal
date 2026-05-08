---
title: Integrations
---

# Integrations

SlackerNews can integrate with several external services to enrich shared links with titles, metadata, and context.

## Google Drive

To enable Google Drive integration:

1. Create a GCP project
2. Navigate to IAM -> Service Accounts
3. Create new
    - Name: SlackerNews
    - Service account ID: news.mycompany.com
    - Description: used to get page titles for google drive items
    - Role: basic / viewer
    - Continue -> Done

<Warning title="Copy the Client ID">
Find the new row and copy the auto-generated OAuth2 Client ID (Unique ID). You will need it in step 8.
</Warning>

4. On the new service account, click **Manage keys** -> **Create new key** (JSON format). This will download to your local machine.
5. Log in to [admin.google.com](https://admin.google.com/ac/owl/domainwidedelegation)
6. Click **Add New**
7. Paste in the previously copied Client ID (Unique ID of the service account)
8. Paste in this scope: `https://www.googleapis.com/auth/drive.metadata.readonly`
9. Visit your SlackerNews admin console at `/admin/integrations`
10. Paste the full contents of the JSON key into the configuration for Google Drive
11. Enable the Google Drive integration

## GitHub

The GitHub integration will read and construct titles for github.com links.

For public repos and pages that are accessible, this integration will download the HTML content and use the page title.

For private repos, this will look for known URL patterns and use the GitHub Personal Access Token provided to query the GitHub Rest API and attempt to build the title.

### History

**v0.0.1**
- Support for public pages
- Support for Issues in private repos
- Support for Pull Requests in private repos
- Support for Actions runs in private repos

## Outline

Outline integration is supported for enriching links to Outline documents.

## Shortcut

Shortcut integration is supported for enriching links to Shortcut stories and epics.

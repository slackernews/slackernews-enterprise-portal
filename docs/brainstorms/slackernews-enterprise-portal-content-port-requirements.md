---
date: 2026-05-08
topic: slackernews-enterprise-portal-content-port
---

# SlackerNews Enterprise Portal Content and Branding Integration

## Summary

Port all customer-facing documentation from docs.slackernews.io into the Replicated Enterprise Portal, restructure navigation around the install journey, apply slackernews.io branding, and preserve existing EP-native Replicated installation flows. The EP becomes the primary documentation destination for licensed customers.

---

## Problem Frame

The Replicated Enterprise Portal for SlackerNews currently contains placeholder template content and unconfigured branding. Customers with a license visiting the EP see generic documentation that does not reflect the actual SlackerNews product, its prerequisites, or its configuration options. Meanwhile, a separate public docs site at docs.slackernews.io maintains the real documentation, creating a split experience where customers must leave the portal to find setup and configuration guidance. The Slack app creation steps, domain setup, and post-install integrations are entirely absent from the EP.

---

## Key Flows

- F1. **First-time installation journey**
  - **Trigger:** Customer receives a SlackerNews license and opens the Enterprise Portal
  - **Steps:**
    1. Review security information and vulnerability reports
    2. Review prerequisites and confirm environment readiness
    3. Set up domain and TLS
    4. Create and install the Slack app
    5. Select installation method (Linux/Embedded Cluster or Helm)
    6. Follow personalized installation commands via EP-native components
    7. Complete post-install application configuration
  - **Outcome:** Customer has a running SlackerNews instance configured for their Slack workspace
  - **Covered by:** R1, R2, R4, R6, R9, R10

- F2. **Trial / demo evaluation**
  - **Trigger:** Customer with a trial license wants to evaluate SlackerNews before connecting Slack
  - **Steps:**
    1. Navigate to Demo Mode under Installation
    2. Follow demo-specific prerequisites
    3. Install in demo mode
    4. Access the application via port-forward
  - **Outcome:** Customer can explore SlackerNews UI without Slack connectivity
  - **Covered by:** R2, R8

- F3. **Post-install troubleshooting**
  - **Trigger:** Customer encounters an issue with a running instance
  - **Steps:**
    1. Navigate to Support section
    2. Check FAQ or generate a support bundle
    3. Contact support with bundle attached if needed
  - **Outcome:** Issue is diagnosed or escalated with required diagnostics
  - **Covered by:** R1, R2

---

## Requirements

**Content migration**
- R1. Port all upstream docs.slackernews.io content into the EP `pages/` directory, preserving informational accuracy while adapting to EP conventions
- R2. Restructure `toc.yaml` navigation to reflect the customer journey: **Security** (first and prominent), Getting Started (prerequisites, domain setup, Slack app, preparing values), Installation (Linux/Embedded Cluster, Helm, Demo Mode), Post-Install (configuration, updates, integrations, telemetry), and Support
- R3. Update `theme.yaml` with SlackerNews branding including portal title, primary color, logo, favicon, and support contact information
- R4. Adapt upstream MkDocs Material syntax (admonitions, standard markdown links, tables) to EP MDX components and conventions (`<Tip>`, `<Warning>`, `<Note>`, `<Accordion>`, `{{ }}` template variables, relative EP paths)
- R5. Rewrite all internal cross-links from upstream docs to target the corresponding EP page paths

**Installation experience**
- R6. Preserve existing EP-native Replicated installation pages and components (`<LinuxInstallAssets />`, `<HelmInstallAssets />`, `<PendingInstallSelector />`, `<NewInstall />`, `<VersionSelector />`, etc.) as the primary installation experience
- R7. Apply entitlement-based `visible_when` gating to installation method pages and related navigation items where different customers have different license capabilities
- R8. Add Demo Mode as a standalone page under the Installation section, accessible to customers who want to evaluate before connecting Slack

**Post-install content**
- R9. Port post-install content (application configuration, integrations such as GitHub and Google Drive, telemetry) into new top-level sections or pages within the EP

**Security prominence**
- R10. Place the Security section as the first item in the `toc.yaml` navigation, before Getting Started and Installation, ensuring it is the first thing customers see when opening the portal

---

## Acceptance Examples

- AE1. **Covers R2, R4, R6, R7.** Given a customer with `isEmbeddedClusterDownloadEnabled` entitlement, when they open the EP, they see Linux/Embedded Cluster installation in the nav and the Linux install page renders with `<LinuxInstallAssets />` personalized commands.
- AE2. **Covers R2, R4, R6, R7.** Given a customer without `isHelmInstallEnabled` entitlement, when they open the EP, the Helm installation page and nav item are hidden.
- AE3. **Covers R1, R4, R5.** Given the ported "Slack App" page, when a customer clicks the "Domain Name Setup" link within it, they land on the EP's domain setup page (not the upstream docs URL).
- AE4. **Covers R3.** Given the updated `theme.yaml`, when a customer loads the EP login page, the portal title reads "SlackerNews" (or equivalent branded title) rather than a generic placeholder.
- AE5. **Covers R8.** Given a customer with a trial license, when they navigate to Installation → Demo Mode, they see demo-specific prerequisites and a port-forward command to access the application.
- AE6. **Covers R10.** Given any customer opening the EP, when the sidebar loads, the Security section is the first nav item visible above Getting Started and Installation.

---

## Success Criteria

- A licensed customer can complete the full SlackerNews installation journey — from prerequisites through post-install configuration — using only the Enterprise Portal, without visiting docs.slackernews.io
- The EP navigation structure is intuitive, with Security prominently placed as the first section before any installation or configuration steps
- EP branding matches slackernews.io (colors, logo, favicon, portal title)
- No internal cross-links within the EP return 404s
- Existing Replicated installation components (`<LinuxInstallAssets />`, `<HelmInstallAssets />`, etc.) continue to render personalized commands correctly
- The ported content preserves all factual accuracy from the upstream docs

---

## Scope Boundaries

- No changes to the upstream docs.slackernews.io repository or its deployment infrastructure
- No changes to the SlackerNews application source code
- No new Replicated entitlements or permissions beyond those already used in the EP
- No versioned docs branches (may be added later independently)
- No KOTS or kURL installer documentation (EP v2 does not support these install methods)
- The public docs site may remain as a minimal landing page, but migration or redirection of that site is not part of this work
- Demo mode evaluation is limited to porting existing upstream demo content; no new demo features are being created

---

## Key Decisions

- **EP becomes the primary docs destination.** The upstream public docs site will be deprecated or reduced to a minimal landing page for prospects. Rationale: licensed customers should not need to leave the portal to complete setup.
- **Demo mode is included in the EP.** A standalone Demo Mode page lives under Installation. Rationale: trial license holders may want to evaluate before connecting Slack.
- **kURL-based VM install content is superseded.** The existing Embedded Cluster installation page replaces the older kURL VM documentation. Rationale: EP v2 only supports Embedded Cluster and Helm CLI.
- **Post-install content (app config, integrations, telemetry) gets dedicated sections.** Rationale: customers need guidance after installation completes; this content is currently only on the public docs site.
- **Security is the first and most prominent nav section.** Rationale: customers should review security posture, vulnerability reports, and data handling before proceeding with installation or configuration.

---

## Dependencies / Assumptions

- Branding assets (logo image, favicon, primary brand color) are available from slackernews.io or the upstream repository and can be copied into the EP `assets/` directory
- EP v2 MDX components support the callout types needed to replace upstream MkDocs Material admonitions
- The upstream content can be adapted to EP markdown/MDX conventions without loss of meaning or accuracy
- Existing Replicated entitlements (`isEmbeddedClusterDownloadEnabled`, `isHelmInstallEnabled`) already govern the correct customer segments

---

## Outstanding Questions

### Deferred to Planning

- [Affects R3][Needs research] What are the exact SlackerNews brand color hex codes, and is a logo asset available in the upstream repo or at a known URL?
- [Affects R4][Technical] Which upstream MkDocs-specific extensions or syntax features (beyond admonitions) are used and need equivalent EP MDX handling?
- [Affects R2][Technical] Should post-install configuration and integrations live under a single "Configuration" top-level nav item, or be split into separate "Integrations" and "Administration" sections?

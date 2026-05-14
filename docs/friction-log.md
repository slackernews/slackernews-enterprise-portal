# Enterprise Portal Friction Log

Known rendering, preview, and behavior issues encountered while working with the Replicated Enterprise Portal v2 content repo.

---

## Bash comments rendered as headings inside `<CodeBlock>`

**Date:** 2026-05-14
**Severity:** Medium — breaks readability of code examples

### Problem
Inside a `<CodeBlock language="bash">` (or any fenced code block), lines starting with `# ` are rendered as Markdown H1 headings instead of being treated as literal bash comments. This causes inline code examples to sprout giant headings mid-block.

### Evidence
A `.env` file rendered in a `bash` CodeBlock shows:
- `# The public domain where Slackernews will be served` → giant heading
- `# Caddy will provision a TLS certificate...` → giant heading
- `# Slack OAuth credentials from https://api.slack.com/apps` → giant heading

### Workaround
Use `language="text"` or `language="env"` instead of `language="bash"` when the block contains comments. Alternatively, escape the `#` as `\#` (may not work inside CodeBlock children).

### Status
Open — awaiting upstream fix in EP v2 preview renderer.

---

## Preview fails for branch names containing slashes

**Date:** 2026-05-14
**Severity:** High — blocks local preview of version branches

### Problem
`replicated enterprise-portal preview` fails or returns 404 when the current branch name contains a forward slash (e.g., `feature/foo`, `release/1.4.3`). The preview server appears to treat the slash as a path separator and fails to resolve the branch.

### Workaround
Rename the branch to a slash-free name (e.g., `feat-foo`, `release-1-4-3`) before running preview, or preview from a detached checkout of the branch content.

### Status
Open — verify on latest `replicated` CLI version before reporting.

---

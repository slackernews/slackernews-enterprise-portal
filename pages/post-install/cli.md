---
title: CLI
---

# Command Line Interface

The SlackerNews CLI lets you interact with your instance from the command line.

## Downloads

### macOS

- [Download for Intel (x86_64)]({{asset "assets/slackernews-darwin-amd64"}})
- [Download for Apple Silicon (arm64)]({{asset "assets/slackernews-darwin-arm64"}})

### Linux

- [Download for AMD64]({{asset "assets/slackernews-linux-amd64"}})
- [Download for ARM64]({{asset "assets/slackernews-linux-arm64"}})

### Windows

- [Download Installer (.msi)]({{asset "assets/slackernews-windows-amd64.msi"}})

## Installation

### macOS and Linux

After downloading the appropriate binary for your platform, make it executable and move it into your PATH:

<CommandBlock>
chmod +x slackernews-<platform>-<arch>
sudo mv slackernews-<platform>-<arch> /usr/local/bin/slackernews
</CommandBlock>

Verify the installation:

<CommandBlock>
slackernews --help
</CommandBlock>

### Windows

Run the downloaded `.msi` installer and follow the prompts. The CLI will be added to your system PATH automatically.

<Note>
Replace `<platform>` and `<arch>` in the commands above with the actual values from the downloaded filename (e.g., `darwin-amd64` or `linux-arm64`).
</Note>

# Caesar Agent ⚔️

**The AI agent that conquers your workflow.**

Forked from [Caesar Agent](https://github.com/Sebastians007/caesar-agent) by Nous Research and customized by [Sebastian Sartele](https://github.com/Sebastians007).

Caesar Agent is a self-improving AI agent with a built-in learning loop. It creates skills from experience, improves them during use, persists knowledge across sessions, and builds a deepening model of who you are over time.

Run it on a $5 VPS, a GPU cluster, or serverless infrastructure. Talk to it from Telegram while it works on a cloud VM. Use any model — OpenRouter, OpenAI, Anthropic, or your own endpoint.

## What it does

- **Terminal interface** — Full TUI with multiline editing, slash commands, streaming tool output
- **Lives where you do** — Telegram, Discord, Slack, WhatsApp, Signal, CLI
- **Learning loop** — Creates and improves skills autonomously, remembers across sessions
- **Scheduled automations** — Cron-based tasks with delivery to any platform
- **Parallel workstreams** — Spawn subagents for concurrent tasks
- **Runs anywhere** — Local, Docker, SSH, Daytona, Modal, Singularity

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/Sebastians007/caesar-agent/main/scripts/install.sh | bash
```

After installation:

```bash
source ~/.bashrc
caesar              # start chatting
caesar model        # choose your LLM
caesar tools        # configure tools
caesar setup        # full setup wizard
```

## Commands

```
caesar              # Interactive CLI
caesar model        # Choose LLM provider and model
caesar tools        # Configure enabled tools
caesar config set   # Set config values
caesar gateway      # Start messaging gateway
caesar setup        # Run setup wizard
caesar update       # Update to latest
caesar doctor       # Diagnose issues
```

## Built on

Original project: [Hermes Agent](https://github.com/Sebastians007/caesar-agent) by [Nous Research](https://nousresearch.com)

## License

MIT — see [LICENSE](LICENSE).

Customized by [Sebastian Sartele](https://github.com/Sebastians007).

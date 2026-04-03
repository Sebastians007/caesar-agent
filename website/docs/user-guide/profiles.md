---
sidebar_position: 2
---

# Profiles: Running Multiple Agents

Run multiple independent Caesar agents on the same machine — each with its own config, API keys, memory, sessions, skills, and gateway.

## What are profiles?

A profile is a fully isolated Caesar environment. Each profile gets its own directory containing its own `config.yaml`, `.env`, `SOUL.md`, memories, sessions, skills, cron jobs, and state database. Profiles let you run separate agents for different purposes — a coding assistant, a personal bot, a research agent — without any cross-contamination.

When you create a profile, it automatically becomes its own command. Create a profile called `coder` and you immediately have `coder chat`, `coder setup`, `coder gateway start`, etc.

## Quick start

```bash
caesar profile create coder       # creates profile + "coder" command alias
coder setup                       # configure API keys and model
coder chat                        # start chatting
```

That's it. `coder` is now a fully independent agent. It has its own config, its own memory, its own everything.

## Creating a profile

### Blank profile

```bash
caesar profile create mybot
```

Creates a fresh profile with bundled skills seeded. Run `mybot setup` to configure API keys, model, and gateway tokens.

### Clone config only (`--clone`)

```bash
caesar profile create work --clone
```

Copies your current profile's `config.yaml`, `.env`, and `SOUL.md` into the new profile. Same API keys and model, but fresh sessions and memory. Edit `~/.caesar/profiles/work/.env` for different API keys, or `~/.caesar/profiles/work/SOUL.md` for a different personality.

### Clone everything (`--clone-all`)

```bash
caesar profile create backup --clone-all
```

Copies **everything** — config, API keys, personality, all memories, full session history, skills, cron jobs, plugins. A complete snapshot. Useful for backups or forking an agent that already has context.

### Clone from a specific profile

```bash
caesar profile create work --clone --clone-from coder
```

## Using profiles

### Command aliases

Every profile automatically gets a command alias at `~/.local/bin/<name>`:

```bash
coder chat                    # chat with the coder agent
coder setup                   # configure coder's settings
coder gateway start           # start coder's gateway
coder doctor                  # check coder's health
coder skills list             # list coder's skills
coder config set model.model anthropic/claude-sonnet-4
```

The alias works with every caesar subcommand — it's just `caesar -p <name>` under the hood.

### The `-p` flag

You can also target a profile explicitly with any command:

```bash
caesar -p coder chat
caesar --profile=coder doctor
caesar chat -p coder -q "hello"    # works in any position
```

### Sticky default (`caesar profile use`)

```bash
caesar profile use coder
caesar chat                   # now targets coder
caesar tools                  # configures coder's tools
caesar profile use default    # switch back
```

Sets a default so plain `caesar` commands target that profile. Like `kubectl config use-context`.

### Knowing where you are

The CLI always shows which profile is active:

- **Prompt**: `coder ❯` instead of `❯`
- **Banner**: Shows `Profile: coder` on startup
- **`caesar profile`**: Shows current profile name, path, model, gateway status

## Running gateways

Each profile runs its own gateway as a separate process with its own bot token:

```bash
coder gateway start           # starts coder's gateway
assistant gateway start       # starts assistant's gateway (separate process)
```

### Different bot tokens

Each profile has its own `.env` file. Configure a different Telegram/Discord/Slack bot token in each:

```bash
# Edit coder's tokens
nano ~/.caesar/profiles/coder/.env

# Edit assistant's tokens
nano ~/.caesar/profiles/assistant/.env
```

### Safety: token locks

If two profiles accidentally use the same bot token, the second gateway will be blocked with a clear error naming the conflicting profile. Supported for Telegram, Discord, Slack, WhatsApp, and Signal.

### Persistent services

```bash
coder gateway install         # creates caesar-gateway-coder systemd/launchd service
assistant gateway install     # creates caesar-gateway-assistant service
```

Each profile gets its own service name. They run independently.

## Configuring profiles

Each profile has its own:

- **`config.yaml`** — model, provider, toolsets, all settings
- **`.env`** — API keys, bot tokens
- **`SOUL.md`** — personality and instructions

```bash
coder config set model.model anthropic/claude-sonnet-4
echo "You are a focused coding assistant." > ~/.caesar/profiles/coder/SOUL.md
```

## Updating

`caesar update` pulls code once (shared) and syncs new bundled skills to **all** profiles automatically:

```bash
caesar update
# → Code updated (12 commits)
# → Skills synced: default (up to date), coder (+2 new), assistant (+2 new)
```

User-modified skills are never overwritten.

## Managing profiles

```bash
caesar profile list           # show all profiles with status
caesar profile show coder     # detailed info for one profile
caesar profile rename coder dev-bot   # rename (updates alias + service)
caesar profile export coder   # export to coder.tar.gz
caesar profile import coder.tar.gz   # import from archive
```

## Deleting a profile

```bash
caesar profile delete coder
```

This stops the gateway, removes the systemd/launchd service, removes the command alias, and deletes all profile data. You'll be asked to type the profile name to confirm.

Use `--yes` to skip confirmation: `caesar profile delete coder --yes`

:::note
You cannot delete the default profile (`~/.caesar`). To remove everything, use `caesar uninstall`.
:::

## Tab completion

```bash
# Bash
eval "$(caesar completion bash)"

# Zsh
eval "$(caesar completion zsh)"
```

Add the line to your `~/.bashrc` or `~/.zshrc` for persistent completion. Completes profile names after `-p`, profile subcommands, and top-level commands.

## How it works

Profiles use the `CAESAR_HOME` environment variable. When you run `coder chat`, the wrapper script sets `CAESAR_HOME=~/.caesar/profiles/coder` before launching caesar. Since 119+ files in the codebase resolve paths via `get_caesar_home()`, everything automatically scopes to the profile's directory — config, sessions, memory, skills, state database, gateway PID, logs, and cron jobs.

The default profile is simply `~/.caesar` itself. No migration needed — existing installs work identically.

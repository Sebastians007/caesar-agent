---
sidebar_position: 7
---

# Profile Commands Reference

This page covers all commands related to [Caesar profiles](../user-guide/profiles.md). For general CLI commands, see [CLI Commands Reference](./cli-commands.md).

## `caesar profile`

```bash
caesar profile <subcommand>
```

Top-level command for managing profiles. Running `caesar profile` without a subcommand shows help.

| Subcommand | Description |
|------------|-------------|
| `list` | List all profiles. |
| `use` | Set the active (default) profile. |
| `create` | Create a new profile. |
| `delete` | Delete a profile. |
| `show` | Show details about a profile. |
| `alias` | Regenerate the shell alias for a profile. |
| `rename` | Rename a profile. |
| `export` | Export a profile to a tar.gz archive. |
| `import` | Import a profile from a tar.gz archive. |

## `caesar profile list`

```bash
caesar profile list
```

Lists all profiles. The currently active profile is marked with `*`.

**Example:**

```bash
$ caesar profile list
  default
* work
  dev
  personal
```

No options.

## `caesar profile use`

```bash
caesar profile use <name>
```

Sets `<name>` as the active profile. All subsequent `caesar` commands (without `-p`) will use this profile.

| Argument | Description |
|----------|-------------|
| `<name>` | Profile name to activate. Use `default` to return to the base profile. |

**Example:**

```bash
caesar profile use work
caesar profile use default
```

## `caesar profile create`

```bash
caesar profile create <name> [options]
```

Creates a new profile.

| Argument / Option | Description |
|-------------------|-------------|
| `<name>` | Name for the new profile. Must be a valid directory name (alphanumeric, hyphens, underscores). |
| `--clone` | Copy `config.yaml`, `.env`, and `SOUL.md` from the current profile. |
| `--clone-all` | Copy everything (config, memories, skills, sessions, state) from the current profile. |
| `--clone-from <profile>` | Clone from a specific profile instead of the current one. Used with `--clone` or `--clone-all`. |

**Examples:**

```bash
# Blank profile — needs full setup
caesar profile create mybot

# Clone config only from current profile
caesar profile create work --clone

# Clone everything from current profile
caesar profile create backup --clone-all

# Clone config from a specific profile
caesar profile create work2 --clone --clone-from work
```

## `caesar profile delete`

```bash
caesar profile delete <name> [options]
```

Deletes a profile and removes its shell alias.

| Argument / Option | Description |
|-------------------|-------------|
| `<name>` | Profile to delete. |
| `--yes`, `-y` | Skip confirmation prompt. |

**Example:**

```bash
caesar profile delete mybot
caesar profile delete mybot --yes
```

:::warning
This permanently deletes the profile's entire directory including all config, memories, sessions, and skills. Cannot delete the currently active profile.
:::

## `caesar profile show`

```bash
caesar profile show <name>
```

Displays details about a profile including its home directory, configured model, active platforms, and disk usage.

| Argument | Description |
|----------|-------------|
| `<name>` | Profile to inspect. |

**Example:**

```bash
$ caesar profile show work
Profile:    work
Home:       ~/.caesar/profiles/work
Model:      anthropic/claude-sonnet-4
Platforms:  telegram, discord
Skills:     12 installed
Disk:       48 MB
```

## `caesar profile alias`

```bash
caesar profile alias <name> [options]
```

Regenerates the shell alias script at `~/.local/bin/<name>`. Useful if the alias was accidentally deleted or if you need to update it after moving your Caesar installation.

| Argument / Option | Description |
|-------------------|-------------|
| `<name>` | Profile to create/update the alias for. |
| `--remove` | Remove the wrapper script instead of creating it. |
| `--name <alias>` | Custom alias name (default: profile name). |

**Example:**

```bash
caesar profile alias work
# Creates/updates ~/.local/bin/work

caesar profile alias work --name mywork
# Creates ~/.local/bin/mywork

caesar profile alias work --remove
# Removes the wrapper script
```

## `caesar profile rename`

```bash
caesar profile rename <old-name> <new-name>
```

Renames a profile. Updates the directory and shell alias.

| Argument | Description |
|----------|-------------|
| `<old-name>` | Current profile name. |
| `<new-name>` | New profile name. |

**Example:**

```bash
caesar profile rename mybot assistant
# ~/.caesar/profiles/mybot → ~/.caesar/profiles/assistant
# ~/.local/bin/mybot → ~/.local/bin/assistant
```

## `caesar profile export`

```bash
caesar profile export <name> [options]
```

Exports a profile as a compressed tar.gz archive.

| Argument / Option | Description |
|-------------------|-------------|
| `<name>` | Profile to export. |
| `-o`, `--output <path>` | Output file path (default: `<name>.tar.gz`). |

**Example:**

```bash
caesar profile export work
# Creates work.tar.gz in the current directory

caesar profile export work -o ./work-2026-03-29.tar.gz
```

## `caesar profile import`

```bash
caesar profile import <archive> [options]
```

Imports a profile from a tar.gz archive.

| Argument / Option | Description |
|-------------------|-------------|
| `<archive>` | Path to the tar.gz archive to import. |
| `--name <name>` | Name for the imported profile (default: inferred from archive). |

**Example:**

```bash
caesar profile import ./work-2026-03-29.tar.gz
# Infers profile name from the archive

caesar profile import ./work-2026-03-29.tar.gz --name work-restored
```

## `caesar -p` / `caesar --profile`

```bash
caesar -p <name> <command> [options]
caesar --profile <name> <command> [options]
```

Global flag to run any Caesar command under a specific profile without changing the sticky default. This overrides the active profile for the duration of the command.

| Option | Description |
|--------|-------------|
| `-p <name>`, `--profile <name>` | Profile to use for this command. |

**Examples:**

```bash
caesar -p work chat -q "Check the server status"
caesar --profile dev gateway start
caesar -p personal skills list
caesar -p work config edit
```

## `caesar completion`

```bash
caesar completion <shell>
```

Generates shell completion scripts. Includes completions for profile names and profile subcommands.

| Argument | Description |
|----------|-------------|
| `<shell>` | Shell to generate completions for: `bash` or `zsh`. |

**Examples:**

```bash
# Install completions
caesar completion bash >> ~/.bashrc
caesar completion zsh >> ~/.zshrc

# Reload shell
source ~/.bashrc
```

After installation, tab completion works for:
- `caesar profile <TAB>` — subcommands (list, use, create, etc.)
- `caesar profile use <TAB>` — profile names
- `caesar -p <TAB>` — profile names

## See also

- [Profiles User Guide](../user-guide/profiles.md)
- [CLI Commands Reference](./cli-commands.md)
- [FAQ — Profiles section](./faq.md#profiles)

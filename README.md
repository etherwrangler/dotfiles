# Repository Notes

- Repo workflow and maintenance conventions are documented in [AGENTS.md](AGENTS.md).
- Future cleanup, validation, and linting work is tracked in [TODO.md](TODO.md).
- Review changes with `chezmoi diff` before applying them.

# Encrypted Files

This repo uses chezmoi age encryption for secret-ish SSH config snippets. During
init, answer yes to `Restore encrypted SSH config files` only on machines that
should receive those files. Before running `chezmoi diff` or `chezmoi apply` on
those machines, restore the age identity from Vaultwarden to:

```text
~/.config/chezmoi/key.txt
```

The public age recipient is committed in `chzhome/.chezmoi.toml.tmpl`; only
`key.txt` is secret. If `Restore encrypted SSH config files` is disabled, the
encrypted SSH config snippets are ignored and `key.txt` is not required. If it
is enabled before restoring `key.txt`, init can still render the config, but
commands that need to decrypt encrypted files such as `chezmoi diff`,
`chezmoi status`, and `chezmoi apply` will fail until the identity file is
restored.

# Setup for macOS

Install chezmoi with Homebrew:

```shell
brew install chezmoi
```

Initialize the repo:

```shell
chezmoi init etherwrangler
```

During init, chezmoi prompts for machine tags that control optional package
groups and secrets-related files. Use `nopackages` when you want the dotfiles
without package installation scripts.

Review the pending changes:

```shell
chezmoi diff
```

Apply when the diff looks right:

```shell
chezmoi apply
```

# Setup for Windows

Set ExecutionPolicy to RemoteSigned so that scripts can run, install chezmoi,
and initialize the repo:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
winget install chezmoi
chezmoi init etherwrangler
```

During init, chezmoi prompts for machine tags that control optional package
groups and secrets-related files. Use `nopackages` when you want the dotfiles
without package installation scripts.

Review the pending changes:

```powershell
chezmoi diff
```

Apply when the diff looks right:

```powershell
chezmoi apply
```

# Setup for Debian

Debian, including WSL Debian, is a first-class target. Package installation is
managed with `apt` unless the `nopackages` tag is enabled during init.

Install chezmoi. Minimal Debian installs may not include `curl`, so use the
`wget` form unless `curl` is already available:

```shell
# With curl
sh -c "$(curl -fsLS get.chezmoi.io)"

# With wget
sh -c "$(wget -qO- get.chezmoi.io)"
```

The installer places `chezmoi` in `~/bin`, which may not be on `PATH` until the
dotfiles have been applied and the shell has been restarted. Use the explicit
path for the initial bootstrap commands:

```shell
~/bin/chezmoi init etherwrangler
```

Review the pending changes before applying:

```shell
~/bin/chezmoi diff
```

Apply when the diff looks right:

```shell
~/bin/chezmoi apply
```

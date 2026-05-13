# Repository Notes

- Repo workflow and maintenance conventions are documented in [AGENTS.md](AGENTS.md).
- Future cleanup, validation, and linting work is tracked in [TODO.md](TODO.md).
- Review changes with `chezmoi diff` before applying them.

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

# Setup for Linux

Linux support is secondary. Debian, WSL Debian, and devcontainers are used
occasionally, but Linux package management is not yet a first-class project
target.

## Debian

Install chezmoi:

```shell
# With curl
sh -c "$(curl -fsLS get.chezmoi.io)"

# With wget
sh -c "$(wget -qO- get.chezmoi.io)" 
```

Initialize the repo:

```shell
chezmoi init etherwrangler
```

Review the pending changes before applying:

```shell
chezmoi diff
```

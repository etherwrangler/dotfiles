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

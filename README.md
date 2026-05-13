# Repository Notes

- Repo workflow and maintenance conventions are documented in [AGENTS.md](AGENTS.md).
- Future cleanup, validation, and linting work is tracked in [TODO.md](TODO.md).

# Setup for MacOS

Install chezmoi (via homebrew)
```shell
brew install chezmoi
```
more stuff soon

# Setup for Windows

Set ExecutionPolicy to RemoteSigned so that scripts can run, install chezmoi, init the repo and apply changes
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
winget install chezmoi
chezmoi init etherwrangler
```

# Setup for Linux

## Debian

Install Chezmoi
```shell
# With curl
sh -c "$(curl -fsLS get.chezmoi.io)"

# With wget
sh -c "$(wget -qO- get.chezmoi.io)" 
```

Init the Repo
```shell
chezmoi init etherwrangler
```

# Agent Guidance

This is a chezmoi-managed dotfiles repository. The source root is `chzhome`,
configured by `.chezmoiroot`, and chezmoi applies these files into the user's
home directory.

## Supported Targets

- First-class targets are macOS and Windows 11.
- WSL Debian, native Debian, and devcontainers are occasionally used.
- Devcontainers are rare and should be treated as secondary.

## Chezmoi Command Policy

- `chezmoi diff` may be run freely.
- `chezmoi execute-template` may be run freely.
- Only run `chezmoi apply` when the user explicitly asks for it.
- Package install scripts may be read freely.
- Package install scripts may only be executed as part of an explicitly
  requested `chezmoi apply`, unless the user gives specific permission.

## Data And Machine Tags

The machine tags are defined and documented in `chzhome/.chezmoi.toml.tmpl`:

- `ephemeral`
- `headless`
- `devtools`
- `games`
- `ittools`
- `nopackages`
- `personal`
- `work`
- `osid`

`personal` and `work` may both be true for the same machine.

## Package Management

- Windows packages are managed with `winget`.
- macOS packages are managed with Homebrew.
- Linux package management is currently outside the main project scope, but may
  be added later.
- Package lists should live in `.chezmoidata`.
- Each OS should have its own package data file.
- Package data should use a consistent shape across operating systems.
- Package IDs should be alphabetized within their group.
- Package groups should use `common`, `devtools`, `games`, `ittools`,
  `personal`, and `work` unless there is a clear reason to add another group.

## Install Script Expectations

- Install scripts should ideally be idempotent.
- Package install script names should use explicit numeric ordering when there
  are multiple category scripts, such as
  `run_onchange_after_200-install-packages-common.sh.tmpl`,
  `run_onchange_after_201-install-packages-work.sh.tmpl`, and so on.
- If an idempotency issue is noticed, flag it.
- Install scripts should avoid upgrades unless the user explicitly asks for
  upgrade behavior.
- Failure handling can be chosen based on the script. Some scripts should fail
  fast; package installers may collect failures when that produces a better
  result.
- Direct downloads, such as a Neovim tarball, are acceptable when there is no
  better package-manager solution.

## Shell And Script Style

- For macOS scripts, prefer `sh`, then `zsh`, then `bash`.
- Use `zsh` or `bash` directly when the script is simpler or clearer with those
  features.
- PowerShell scripts should keep strict, predictable behavior when practical.
- Preserve `.editorconfig` rules, including CRLF line endings for PowerShell
  files and LF for most other files.

## Secrets And Sensitive Data

- This repo does not currently use chezmoi encryption.
- Secrets are stored externally in Bitwarden.
- Do not add secrets to this repo.
- SSH config files are generally safe to edit, but do not expose private
  hostnames, usernames, key paths, or secrets unless the user explicitly
  provides and requests them.

## Identity And Machine-Specific Values

- The hardcoded Git identity in `chzhome/dot_gitconfig.tmpl` is intentional and
  is used for GitHub, where most repositories are committed.
- The hardcoded Windows VS Code editor path in `chzhome/dot_gitconfig.tmpl` is
  intentional and fixes a Windows-specific issue.
- Avoid changing identity-related or machine-specific values unless the task
  calls for it.

## Validation

Validation practices are still being developed. Until they are formalized,
prefer non-mutating checks such as `chezmoi diff` and targeted template
rendering.

Track future validation and linting work in `TODO.md`.

## Git Workflow

- Each change and commit should address a single feature, fix, issue, or other
  coherent unit of work so history remains easy to review and track.
- Use Conventional Commits for commit messages, such as
  `docs: add agent guidance` or `chore: add gitattributes`.

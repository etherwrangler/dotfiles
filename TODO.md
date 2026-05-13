# TODO

## Validation

- Define the standard validation commands for repo changes.
- Add a minimal validation section with safe baseline checks such as
  `chezmoi diff`.
- Decide how to validate chezmoi templates without applying changes.
- Add targeted `chezmoi execute-template` examples for important templates.
- Decide whether to use PowerShell syntax checks or linting for `.ps1` and
  `.ps1.tmpl` files.

## Linting And Formatting

- Add YAML linting.
- Add Lua linting for Neovim and WezTerm config.
- Decide whether to add shell linting, such as shellcheck.

## Package Data

- Keep one package data file per OS.
- Keep package data shape consistent across operating systems.
- Keep package IDs alphabetized within each group.

## Git Attributes

- Add explicit binary rules if the repo starts tracking fonts, images,
  archives, or generated binary assets.

## README

- Improve setup instructions after `chezmoi init etherwrangler`.
- Decide whether to document `chezmoi apply` in the setup flow.
- Mention `chezmoi diff` as the preferred review step before applying changes.
- Clarify that package installation is controlled by chezmoi prompts and
  machine tags.

## Linux Scope

- Decide whether Linux package management should become part of this project.
- If Linux package management is added, define the supported distros and package
  manager behavior.
- Review idempotency in
  `chzhome/.chezmoiscripts/linux/run_onchange_before_debian-install-packages.sh.tmpl`.
- Avoid running `chsh -s $(which zsh)` when the user's shell is already zsh.
- Avoid downloading and extracting the Neovim tarball when the desired version
  is already installed.
- Revisit the `/opt/nvim-linux-x86_64` removal/recreate flow before making
  Linux package management first-class.

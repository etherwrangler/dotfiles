# TODO

## Validation

- Define the standard validation commands for repo changes.
- Decide how to validate chezmoi templates without applying changes.
- Decide whether to use PowerShell syntax checks or linting for `.ps1` and
  `.ps1.tmpl` files.

## Linting And Formatting

- Add YAML linting.
- Add Lua linting for Neovim and WezTerm config.
- Decide whether to add shell linting, such as shellcheck.

## Package Data

- Move macOS package lists from scripts into `.chezmoidata`.
- Keep one package data file per OS.
- Keep package data shape consistent across operating systems.
- Keep package IDs alphabetized within each group.

## Linux Scope

- Decide whether Linux package management should become part of this project.
- If Linux package management is added, define the supported distros and package
  manager behavior.

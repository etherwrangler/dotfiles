# TODO

## Git Attributes

- Add explicit binary rules if the repo starts tracking fonts, images,
  archives, or generated binary assets.

## README

- Add troubleshooting notes for common macOS and Windows setup failures.
- Document how to refresh package prompt answers after machine tags change.

## Linux Scope

- Decide whether Linux package management should become part of this project.
- If Linux package management is added, define the supported distros and package
  manager behavior.
- Review idempotency in
  `chzhome/.chezmoiscripts/linux/run_onchange_before_debian-install-packages.sh.tmpl`.
- Revisit the `/opt/nvim-linux-x86_64` removal/recreate flow before making
  Linux package management first-class.

## zsh

- Decide whether to add zoxide.
- Decide whether to add fzf.
- Decide whether to add atuin.

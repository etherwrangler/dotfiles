# TODO

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

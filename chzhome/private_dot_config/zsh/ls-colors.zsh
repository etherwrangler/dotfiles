# GNU ls colors shared by ls, zsh completion, and fzf-tab previews.
_ls_colors_entries=("${(@s.:.)LS_COLORS}")
_ls_colors_entries=("${(@)_ls_colors_entries:#}")
_ls_colors_entries=("${(@)_ls_colors_entries:#di=*}")
_ls_colors_entries=("${(@)_ls_colors_entries:#ow=*}")
_ls_colors_entries=("${(@)_ls_colors_entries:#tw=*}")
_ls_colors_entries+=(
  "di=01;34"
  "ow=01;34"
  "tw=01;34"
)

export LS_COLORS="${(j.:.)_ls_colors_entries}"
unset _ls_colors_entries

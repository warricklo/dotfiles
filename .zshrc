#
# zsh configuration file
#

#
# Basics
#

# Colors

autoload -U colors
colors

# History

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="${HOME}/.cache/zsh/history"

# Automatically `cd`

setopt autocd

# Tab completion

autoload -U compinit
zstyle ":completion:*" menu select
zmodload zsh/complist
compinit

_comp_options+=(globdots)

# Vi controls

# Enable [ ALT + HJKL ] in tab complete menu.
bindkey -M menuselect "^[h" vi-backward-char
bindkey -M menuselect "^[j" vi-down-line-or-history
bindkey -M menuselect "^[k" vi-up-line-or-history
bindkey -M menuselect "^[l" vi-forward-char

# Enable vi controls.
bindkey -v "^?" backward-delete-char
export KEYTIMEOUT=1

# Open in vim buffer.
autoload edit-command-line
zle -N edit-command-line
bindkey "^e" edit-command-line

# Cursor

# Change cursor based on the current vi mode.
function zle-keymap-select {
  if [ ${KEYMAP} == vicmd ] || [ ${1} = "block" ]; then
    echo -ne "\e[1 q"
  elif [ ${KEYMAP} == main ] || [ ${KEYMAP} == viins ] ||
    [ ${KEYMAP} = "" ] || [ ${1} = "beam" ]; then
    echo -ne "\e[5 q"
  fi
}

zle -N zle-keymap-select

# Use the beam cursor for every new prompt.
precmd() {
  echo -ne "\e[5 q"
}

#
# Plugins and miscellaneous
#

# zsh autosuggestions

[ -f ${HOME}/.local/share/zsh/autosuggestions/zsh-autosuggestions.zsh ] &&
  . ${HOME}/.local/share/zsh/autosuggestions/zsh-autosuggestions.zsh

# zsh syntax highlighting

[ -f ${HOME}/.local/share/zsh/syntax-highlighting/zsh-syntax-highlighting.zsh ] &&
  . ${HOME}/.local/share/zsh/syntax-highlighting/zsh-syntax-highlighting.zsh


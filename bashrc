# Omarchy environment (OMARCHY_PATH + PATH), needed even for non-interactive shells
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap

# If not running interactively, don't do anything else (leave this above the rc source)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source "$OMARCHY_PATH/default/bash/rc"
# Private keys live outside the repo
[[ -f ~/.secrets ]] && source ~/.secrets

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'

alias gp='glow -p'
alias .='source ~/.config/bashrc'

alias hk='omarchy menu keybindings --print'
alias lg='lazygit'
alias ag='alias | grep'
alias w='which'
alias e='nvim'
fgit() {
    git -C "${1:-.}" log --reverse --format=%ai "${2:-HEAD}" | head -1
}

# Overrides Omarchy's default g='git' alias.
alias g='glow'

export PATH="$HOME/bin:$PATH"

# Rakudo Star (Raku), built from ~/git/rakudo---star via rstar
export PATH="$HOME/git/rakudo---star/bin:$HOME/git/rakudo---star/share/perl6/site/bin:$PATH"

# Syntax-highlight file contents in less via bat, keeping less's own
# navigation/search. -R lets ANSI color codes (from bat, or from
# `grep --color=always | less`) through instead of showing raw escapes.
export LESS='-R'
export LESSOPEN='|bat --color=always --style=plain %s'

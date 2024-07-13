###
### ZSH initialization script & configuration file
###
### Copyright (C) 2024 Kian Kasad <kian@kasad.com>
### MIT License. See LICENSE file for details.
###


##
## SHELL OPTIONS & PARAMETERS
##

# Changing directories
setopt AUTO_CD           # Change directories by just typing the name of the directory as if it's a command.
setopt AUTO_PUSHD        # Automatically push directories onto the directory stack.
setopt CHASE_LINKS       # Follow symlinks when changing directories.
setopt PUSHD_TO_HOME     # `pushd` with no arguments acts like `pushd $HOME`.
setopt PUSHD_IGNORE_DUPS # Don't push duplicates onto the directory stack.

# Command history
setopt APPEND_HISTORY         # Append history entries rather than replacing. Allows multiple concurrent ZSH instances to all save shell history.
setopt EXTENDED_HISTORY       # Save timestamp and duration of command in history.
setopt HIST_IGNORE_DUPS       # Collapse contiguous duplicate history entries.
setopt HIST_REDUCE_BLANKS     # Remove extra whitespace from history entries.
setopt HIST_IGNORE_SPACE      # Don't save commands that start with a space in history.
HISTFILE="$HOME/.zsh_history" # Where to save history.
HISTSIZE=10000                # Number of history entries to store in memory.
SAVEHIST=10000                # Number of history entries to save in the file.

# Globbing/expansion
setopt EXTENDED_GLOB # Treat #, ~, and ^ as part of patterns for filename generation.
setopt NOMATCH       # Error if a pattern doesn't match any files instead of treating the pattern as an argument.

# Input/Output
setopt NO_CLOBBER           # Don't overwrite files using '>'. Requires '>|' or '>!' to force overwriting.
setopt CLOBBER_EMPTY        # Allow overwriting empty files using '>'.
setopt CORRECT              # Try to correct misspelled commands.
setopt INTERACTIVE_COMMENTS # Allow comments in interactive mode. Useful for copy/pasting scripts.
setopt RM_STAR_SILENT       # Don't prompt when running `rm *`. Should be used in conjunction with rm's `-I` flag.

# Job control
setopt AUTO_CONTINUE # Automatically continue stopped jobs when disowning.
setopt CHECK_JOBS    # Check background jobs before exiting.

# Completion
setopt MENU_COMPLETE  # If no unambiguous completion exists, go straight to menu.
setopt LIST_AMBIGUOUS # Show completion list if there are multiple completions.

MAILCHECK=0 # Don't check for mail


##
## ENVIRONMENT
##

# Use zoxide instead of cd if it exists
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init --cmd=cd --hook=pwd zsh)"
fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Fix pinentry
export GPG_TTY=$(tty)


##
## BEGIN INTERACTIVE-ONLY SETTINGS
##
case $- in
    *i*) ;;
      *) return;;
esac


##
## INTEGRATIONS
##

# iTerm2 shell integration
if [ -r "${HOME}/.iterm2_shell_integration.zsh" ]; then
    source "${HOME}/.iterm2_shell_integration.zsh"
fi

# Fzf integration
if command -v fzf &>/dev/null; then
    eval "$(fzf --zsh)"
fi


##
## COMPLETIONS
##

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' format '' # Don't print any message when completing
zstyle ':completion:*' group-name '%d' # Don't print group names when completing
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt ''
zstyle ':completion:*' select-prompt ''
zstyle ':completion:*' menu select
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' verbose true
zstyle :compinstall filename "$HOME/.zshrc"

# Load Homebrew-installed completions
if [ -d "$HOMEBREW_PREFIX/share/zsh-completions" ]
then
    fpath+="$HOMEBREW_PREFIX/share/zsh/site-functions"
fi

# Load extra completions from zsh-completions
if [ -d "$HOMEBREW_PREFIX/share/zsh-completions" ]
then
    fpath+="$HOMEBREW_PREFIX/share/zsh-completions"
fi

zmodload zsh/complist # Load menu selection module
autoload -Uz compinit # Load compinit
compinit              # Initialize completions


##
## KEY BINDINGS
##

bindkey -- '^R' history-incremental-search-backward # reverse history search

# Function to add vim keybindings to completion menu
function add_menu_keybindings() {
    bindkey -M menuselect 'h' vi-backward-char
    bindkey -M menuselect 'j' vi-down-line-or-history
    bindkey -M menuselect 'k' vi-up-line-or-history
    bindkey -M menuselect 'l' vi-forward-char
    bindkey -M menuselect '^d' vi-forward-word
    bindkey -M menuselect '^u' vi-backward-word
    bindkey -M menuselect 'w' vi-forward-blank-word
    bindkey -M menuselect 'b' vi-backward-blank-word
    bindkey -M menuselect '0' vi-beginning-of-line
    bindkey -M menuselect '$' vi-end-of-line
    bindkey -M menuselect '^[' undo
}

# Check if zsh-vi-mode is installed. On MacOS, install using "brew install zsh-vi-mode"
if
    [ -n "$HOMEBREW_PREFIX" ] &&
    [ -f "$HOMEBREW_PREFIX/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh" ]
then # If zsh-vi-mode is installed, use it
    # Add vi mode keybindings to the completion menu, both after initialization
    # and again after lazy-loading keybindings
    zvm_after_init_commands+=(add_menu_keybindings)
    zvm_after_lazy_keybindings_commands+=(add_menu_keybindings)

    # Load zsh-vi-mode
    source "$HOMEBREW_PREFIX/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
else # If zsh-vi-mode is not installed, use the built-in vi mode
    printf '\x1b[1;33mWarning:\x1b[m zsh-vi-mode is not installed. Using built-in vi mode.\n'
    bindkey -v
    add_menu_keybindings # Add completion menu keybindings
fi


##
## PROMPT
##

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    alacritty|*linux|screen|xterm|xterm-color|*-256color) color_prompt=yes;;
esac

# Use starship if it's installed, otherwise use custom prompt
if [ "$color_prompt" = yes ] && command -V starship >/dev/null 2>&1
then
    eval "$(starship init zsh)"
else
    # uncomment for a colored prompt, if the terminal has the capability; turned
    # off by default to not distract the user: the focus in a terminal window
    # should be on the output of commands, not on the prompt
    #force_color_prompt=yes

    if [ -n "$force_color_prompt" ]; then
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
            # We have color support; assume it's compliant with Ecma-48
            # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
            # a case would tend to support setf rather than setaf.)
            color_prompt=yes
        else
            color_prompt=
        fi
    fi

    case "$TERM" in
        linux) PECHAR='$' ;;
        *) PECHAR='»' ;;
    esac
    if [ "$color_prompt" = yes ]; then
        if [ -z "$SSH_CLIENT" ]; then
            PROMPT="%B%F{blue}%(5~|%-1~/.../%3~|%~)%(?..%b%f : %B%F{red}%?)%f%B %(!.#.$PECHAR)%b%f "
        else
            PROMPT="%B%F{yellow}(%n@%m) %B%F{blue}%(5~|%-1~/.../%3~|%~)%(?..%b%f : %B%F{red}%?)%f%B %(!.#.$PECHAR)%b%f "
        fi
        clear_rprompt() {
            unset RPROMPT
        }
        precmd_git_info() {
            if ! git rev-parse --is-inside-work-tree 2>/dev/null | grep true >/dev/null; then
                return
            fi
            __git_info_branch="$(git branch --show-current)"
            if git name-rev --name-only --undefined '@{upstream}' >/dev/null 2>&1; then
                __git_current_upstream="$(git name-rev --name-only '@{upstream}')"
                __git_info_state="$(printf '↓%d ↑%d' "$(git rev-list --count --left-only "${__git_current_upstream}"...HEAD)" "$(git rev-list --count --right-only "${__git_current_upstream}"...HEAD)" | sed 's/\s*[↓↑]0\s*//g; s/↓/%B%F{red}&/; s/↑/%B%F{green}&/')"
            fi
            RPROMPT+="%B%F{magenta} ${__git_info_branch}${__git_info_state:+ }${__git_info_state}"
        }
        precmd_functions=( clear_rprompt precmd_git_info )
    else
        if [ -z "$SSH_CLIENT" ]; then
            PROMPT="%(5~|%-1~/.../%3~|%~)%(?.. : %?) %(!.#.$PECHAR) "
        else
            PROMPT="(%n@%m) %(5~|%-1~/.../%3~|%~)%(?.. : %?) %(!.#.$PECHAR) "
        fi
    fi

    # If Python virtual environment is activated, prepend "(venv)" to the prompt
    if [ -n "${VIRTUAL_ENV:-}" ]; then
        PROMPT="%b%f(venv) $PROMPT"
    fi

    unset color_prompt force_color_prompt

    # Print time for commands running >=10 seconds. We set this here because
    # Starship provides the same functionality.
    REPORTTIME=10
fi


##
## COLORS
##

# enable color support of ls and also add handy aliases
if command -v dircolors >/dev/null ; then
    test -r "$HOME"/.dircolors && eval "$(dircolors -b "$HOME"/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias tree='tree -C'
    #alias -g dir='dir --color=auto'
    #alias -g vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias 'sudo grep'='sudo grep --color=auto'
    alias 'sudo fgrep'='sudo fgrep --color=auto'
    alias 'sudo egrep'='sudo egrep --color=auto'
    alias 'sudo diff'='sudo diff --color=auto'
fi

# set colors for linux vconsole
[ "$TERM" = "linux" ] && {
    printf "\x1b]P0000000"
    printf "\x1b]P1FD6883"
    printf "\x1b]P2ADDA78"
    printf "\x1b]P3F9CC6C"
    printf "\x1b]P47A9ED7"
    printf "\x1b]P5A8A9EB"
    printf "\x1b]P685DACC"
    printf "\x1b]P7FFF1F3"
    printf "\x1b]P85E4F4F"
    printf "\x1b]P9FD6883"
    printf "\x1b]PAADDA78"
    printf "\x1b]PBF9CC6C"
    printf "\x1b]PC7A9ED7"
    printf "\x1b]PDA8A9EB"
    printf "\x1b]PE85DACC"
    printf "\x1b]PFFFF1F3"
}


##
## SHORTCUTS & ALIASES
##

# Load aliases from ~/.config/aliases
if [ -r "$HOME/.config/aliases" ]
then
    . "$HOME/.config/aliases"
fi

# Load shortcuts from ~/.config/shortcuts
if [ -r "$HOME/.config/shortcuts" ]
then
    awk '
    /^f / {
        printf("alias %s=\"$EDITOR \\\"%s\\\"\"\n", $2, $3)
    }
    /^d / {
        printf("alias %s=\"cd \\\"%s\\\" && ls -A\"\n", $2, $3)
    }' "$HOME/.config/shortcuts"
fi

##
## MISCELLANEOUS
##

# Run pfetch if in a tty
if [ -c "$(tty)" ]; then
    pfetch
fi

# Load syntax highlighting
sh_prefixes=(
    /usr/share/zsh/plugins
    /usr/local/share
    ${HOMEBREW_PREFIX:+"$HOMEBREW_PREFIX/share"}
)
zsh_syntax_highlighting_found=false
for prefix in $sh_prefixes
do
    if [ -r "$prefix/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
        source "$prefix/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
        zsh_syntax_highlighting_found=true
        break
    fi
done
if [ "$zsh_syntax_highlighting_found" = false ]
then
    printf '\x1b[1;33mWarning:\x1b[m zsh-syntax-highlighting not found.\n'
fi

# vim: ft=zsh sw=4 ts=4 et

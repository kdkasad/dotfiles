HISTFILE="$HOME"/.cache/zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt APPEND_HISTORY
setopt histignorespace
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS

# reverse history search
bindkey '^R' history-incremental-search-backward

setopt autocd
setopt extendedglob

zstyle :compinstall filename "$XDG_CONFIG_HOME/zsh/.zshrc"

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

MAILCHECK=0

# Enable vim mode
bindkey -v
export KEYTIMEOUT=1
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILE="$HOME"/.local/share/shell_history
HISTSIZE=1000
HISTFILESIZE=2000

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${arch_chroot:-}" ] && [ -r /etc/arch_chroot ]; then
    arch_chroot=$(cat /etc/arch_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    alacritty|*linux|screen|xterm|xterm-color|*-256color) color_prompt=yes;;
esac

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
		PROMPT="%B%F{blue}%~%(?..%b%f : %B%F{red}%?)%f%B %(!.#.$PECHAR)%b%f "
	else
		PROMPT="%B%F{yellow}(%n@%m) %B%F{blue}%~%(?..%b%f : %B%F{red}%?)%f%B %(!.#.$PECHAR)%b%f "
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
		PROMPT="%~%(?.. : %?) %(!.#.$PECHAR) "
	else
		PROMPT="(%n@%m) %~%(?.. : %?) %(!.#.$PECHAR) "
	fi
fi

# If Python virtual environment is activated, prepend "(venv)" to the prompt
if [ -n "${VIRTUAL_ENV:-}" ]; then
	PROMPT="%b%f(venv) $PROMPT"
fi

unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r "$HOME"/.dircolors && eval "$(dircolors -b "$HOME"/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
	alias -g tree='tree -C'
    #alias -g dir='dir --color=auto'
    #alias -g vdir='vdir --color=auto'

    alias -g grep='grep --color=auto'
    alias -g fgrep='fgrep --color=auto'
    alias -g egrep='egrep --color=auto'
	alias -g diff='diff --color=auto'
fi

# set colors for linux vconsole
[ "$TERM" = "linux" ] && {
	echo -en "\e]P0000000"
	echo -en "\e]P1FD6883"
	echo -en "\e]P2ADDA78"
	echo -en "\e]P3F9CC6C"
	echo -en "\e]P47A9ED7"
	echo -en "\e]P5A8A9EB"
	echo -en "\e]P685DACC"
	echo -en "\e]P7FFF1F3"
	echo -en "\e]P85E4F4F"
	echo -en "\e]P9FD6883"
	echo -en "\e]PAADDA78"
	echo -en "\e]PBF9CC6C"
	echo -en "\e]PC7A9ED7"
	echo -en "\e]PDA8A9EB"
	echo -en "\e]PE85DACC"
	echo -en "\e]PFFFF1F3"
}

# Alias definitions.
alias_file="$HOME"/.config/aliases
[ -f $alias_file ] && . $alias_file

# Fix pinentry
export GPG_TTY=$(tty)

# Shortcuts
shortcutsdir="$HOME"/.config/zsh/shortcuts
tmpfile=$(mktemp)
# directories
grep -v '#' $shortcutsdir/dirs | awk '{print "alias "$1"=\"cd "$2" && la\""}' > $tmpfile
#files
grep -v '#' $shortcutsdir/files | awk '{print "alias "$1"=\"vim "$2"\""}' >> $tmpfile
. $tmpfile
\rm -f $tmpfile

# Command not found helper
[ -r /usr/share/doc/pkgfile/command-not-found.zsh ] && \
	source /usr/share/doc/pkgfile/command-not-found.zsh

# spawn pfetch if in a tty
if [ -c "$(tty)" ]; then
	pfetch
fi

# syntax highlighting
if [ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -r /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
	source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

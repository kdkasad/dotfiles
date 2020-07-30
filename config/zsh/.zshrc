HISTFILE=~/.cache/zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt APPEND_HISTORY
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
HISTFILE=~/.local/share/shell_history
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

if [ "$color_prompt" = yes ]; then
	if [ -z "$SSH_CLIENT" ]; then
		PROMPT="%B%F{blue}%~%(?..%b%f : %B%F{red}%?)%f%B %(!.#.$)%b%f "
	else
		PROMPT="%B%F{yellow}(%n) %B%F{blue}%~%(?..%b%f : %B%F{red}%?)%f%B %(!.#.$)%b%f "
	fi
	precmd_git_info() {
		if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
			unset RPROMPT
			return
		fi
		__git_info_branch="$(git branch --show-current)"
		__git_info_state="$(git status -sb | grep -o '\[.*\]' | sed 's/\[\|\]//g' | awk '{if($1=="ahead")ahead=$2;if($1=="behind")behind=$2;if($3=="ahead")ahead=$4;if($3==behind)behind=$4;printf "%B ↑%d ↓%d%b", ahead, behind}' | sed 's/ [↑↓]0//g; s/↑[0-9]\+/%F{green}&/; s/↓[0-9]\+/%F{red}&/')"
		RPROMPT="%B%F{magenta} ${__git_info_branch}${__git_info_state}"
	}
	precmd_functions=( precmd_git_info )
else
	if [ -z "$SSH_CLIENT" ]; then
		PROMPT="%~%(?.. : %?) %(!.#.$) "
	else
		PROMPT="(%n) %~%(?.. : %?) %(!.#.$) "
	fi
fi

unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias -g ls='ls --color=auto'
	alias -g tree='tree -C'
    alias -g less='less -r'
    #alias -g dir='dir --color=auto'
    #alias -g vdir='vdir --color=auto'

    alias -g grep='grep --color=auto'
    alias -g fgrep='fgrep --color=auto'
    alias -g egrep='egrep --color=auto'
	alias -g diff='diff --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
alias_file=~/.config/aliases
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
source /usr/share/doc/pkgfile/command-not-found.zsh

if [ -c "$(tty)" ]; then
	pfetch
fi

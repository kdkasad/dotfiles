###
### Login shell initialization script
###
### Copyright (C) 2024 Kian Kasad <kian@kasad.com>
### MIT License. See LICENSE file for details.
###


# Mimic Linux path variables
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# Set some variables
export EDITOR=nvim
export PAGER=less

# Homebrew environment setup
export HOMEBREW_EVAL_ALL=true
if [ -x /opt/homebrew/bin/brew ]
then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set default less(1) options
export LESS='-SRi'

# Set default make(1) options
export MAKEFLAGS='-j'

# Set default cc(1) options
if command -v gcc-14 &>/dev/null
then
    export CC=gcc-14
fi

# Include Homebrew-installed libraries in C compiler paths
[ -d /opt/homebrew/include ] && export CPATH=/opt/homebrew/include
[ -d /opt/homebrew/lib ] && export LIBRARY_PATH=/opt/homebrew/lib

# Rustup/Cargo environment setup
if [ -r "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi

# Include user bin directory in path
if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

# Add Bun to path
export BUN_INSTALL="$HOME/.bun"
if [ -d "$BUN_INSTALL" ]
then
    PATH="$BUN_INSTALL/bin:$PATH"
fi

# Mask many MacOS utils with better ones
PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/gawk/libexec/gnubin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/gsed/libexec/gnubin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/make/libexec/gnubin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/sqlite3/bin:$PATH"

# Include ~/opt in paths
if [ -d "$HOME/opt" ]
then
    export PATH="$HOME/opt/bin:$PATH"
    export MANPATH="$HOME/opt/share/man:$MANPATH"
    export LD_LIBRARY_PATH="$HOME/opt/lib:$LD_LIBRARY_PATH"
    export CPPFLAGS="$CPPFLAGS -I$HOME/opt/include"
    export LDFLAGS="$LDFLAGS -L$HOME/opt/lib"

    # Load distcc(1) compiler aliases
    if [ -d "$HOME/opt/lib/distcc" ]
        export DISTCC_PATH="$HOME/opt/lib/distcc:$PATH"
    then
    fi

fi


export PATH

umask 007

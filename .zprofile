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

# Include ~/opt and ~/share/opt in paths
for opt in "$HOME/opt" "$HOME/share/opt"
do
    if [ -d "$opt" ]
    then
        export PATH="$opt/bin:$PATH"
        export MANPATH="$opt/share/man:$MANPATH"
        export LD_LIBRARY_PATH="$opt/lib:$LD_LIBRARY_PATH"
        export CPPFLAGS="$CPPFLAGS -I$opt/include"
        export LDFLAGS="$LDFLAGS -L$opt/lib"

        # Load distcc(1) compiler aliases
        if [ -d "$opt/lib/distcc" ]
        then
            export DISTCC_PATH="$opt/lib/distcc:$PATH"
        fi

        for dir in "$opt"/opt/*/bin(N)
        do
            if [ -d "$dir" ]
            then
                export PATH="$dir:$PATH"
            fi
        done
    fi
done

# Include Mason-installed executables in path
if [ -d "$HOME/.local/share/nvim/mason/bin" ]
then
    export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
fi

# Load rustup and/or cargo
if [ "${HOST#*.}" = "cs.purdue.edu" ]
then
    export RUSTUP_IO_THREADS=10
    export RUSTUP_HOME="$HOME/scratch/rustup"
    export CARGO_HOME="$HOME/scratch/cargo"
    if [ -r "$HOME/scratch/cargo/env" ]
    then
        . "$HOME/scratch/cargo/env"
    fi
fi

# Include macOS developer tools
if command -V xcode-select >/dev/null 2>&1
then
    export PATH="$PATH:$(xcode-select -p)/usr/bin"
fi

export PATH

umask 027

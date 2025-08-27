###
### ZSH environment file
###
### This is sourced every time ZSH starts.
###
### Copyright (C) 2024 Kian Kasad <kian@kasad.com>
### MIT License. See LICENSE file for details.
###

# Change Go installation directory
export GOPATH="$HOME/.go"

# Change Homebrew self-update frequency
export HOMEBREW_AUTO_UPDATE_SECS=86400  # 24 hours

# Where n(1) should live
export N_PREFIX="$HOME/.n"
export PATH="$N_PREFIX/bin:$PATH"

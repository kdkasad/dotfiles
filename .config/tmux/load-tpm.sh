#!/bin/sh

set -e

TMUX_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/tmux"
TPM_REPO="https://github.com/tmux-plugins/tpm"

if ! [ -d "$TMUX_DIR/plugins/tpm" ]
then
    echo 'TPM is not found.'
    echo 'Installing from' "$TPM_REPO"

    git clone --depth=1 --filter=blob:none "$TPM_REPO" "$TMUX_DIR/plugins/tpm"
fi

exec "$TMUX_DIR/plugins/tpm/tpm"

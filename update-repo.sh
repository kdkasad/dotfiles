#!/bin/sh

find . -not -path '*/.git*' -type f -print0 | sed -z 's|^\./||' | grep -zvF -e 'LICENSE' -e 'update-repo.sh' | xargs -r0I%p ln -fv "$HOME/.%p" "./%p"

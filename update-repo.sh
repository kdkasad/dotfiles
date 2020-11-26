#!/bin/sh

find . -not \( -name '.git*' -prune -o -name 'update-repo.sh' -o -name 'install.sh' -o -name 'LICENSE' \) -type f -print0 \
	| sed -z 's|^\./||' \
	| xargs -r0I%p ln -fv "$HOME/.%p" "./%p"

#!/bin/sh

find . -not -path '*/.git*' -not -name 'update-repo.sh' -not -name 'LICENSE' -type f -print0 \
	| sed -z 's|^\./||' \
	| xargs -r0I%p ln -fv "$HOME/.%p" "./%p"

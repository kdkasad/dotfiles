#!/bin/sh

echo creating directories... >&2
find -not \( -name '.git*' -prune \) -type d | sed 's/^\.\///' | xargs -rI%p mkdir -vp "$HOME/.%p"

echo linking files... >&2
find -not \( -name '.git*' -prune -o -name 'LICENSE' -o -name 'install.sh' -o -name 'update-repo.sh' \) -type f | sed 's/^\.\///' | xargs -rI%p ln -v ./%p "$HOME/.%p"

echo 'Done!' >&2

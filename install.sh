#!/bin/sh

echo creating directories... >&2
find -not -path '*/.git*' -type d | sed 's/^\.\///' | xargs -rI%p mkdir -p "$HOME/.%p"

echo linking files... >&2
find -not -path '*/.git*' -type f | sed 's/^\.\///' | xargs -rI%p ln ./%p "$HOME/.%p"

echo 'Done!' >&2

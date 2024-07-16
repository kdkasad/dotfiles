#!/bin/bash

##
## Dotfiles install script
##

exclude_files=(
    .gitignore
    README.md
    LICENSE
    install.sh
)

dotdir="$(realpath "$(dirname "$0")")"

unset force
if [ "$1" = '-f' ]
then
    force=1
fi

git ls-files | while IFS='' read -r file
do
    exclude=0
    for cur_excluded in "${exclude_files[@]}"
    do
        if [ "$file" = "$cur_excluded" ]
        then
            exclude=1
        fi
    done
    if [ "$exclude" = 0 ]
    then
        dir="$(dirname "$file")"
        mkdir -p "$HOME/$dir"
        ln -vs ${force:+-f} "$dotdir/$file" "$HOME/$file"
    fi
done

# vim: ts=4 sw=4 et

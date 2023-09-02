#!/bin/sh

# exit on error
set -e

print_help() {
	cat >&2 << eof
Usage:
	$0 [options]

Options:
	-h, --help
		Print this help message

	-v, --verbose
		Increase verbosity. This prints each file/directory as it is
		installed.

	-f, --force
		Overwrite existing files. Use with extreme caution.

Environment variables:
	PREFIX
		Destination to install files to. Defaults to the user's home
		directory.
		For example, if PREFIX=/tmp/fakehome then config/env will be
		installed to /tmp/fakehome/.config/env

Exit code:
	0  - Successful operation
	1  - User error, e.g. invalid invocation of script
	>1 - Unknown error
eof
}

# install to home directory if $PREFIX is not set
PREFIX="${PREFIX:-$HOME}"

# parse command-line options
for arg in "$@" ; do
	case "$arg" in
		-h|--help) print_help ; exit 0 ;;
		-v|--verbose) verbose='-v' ;;
		-f|--force) force='-f' ;;
		*) printf 'unknown option: %s\n' "$arg" ; exit 1 ;;
	esac
done

# print initial information
printf 'installing files to %s\n' "$PREFIX"
if [ -z "$force" ]; then
	echo 'this process will not overwrite any existing files'
fi

# create directories
echo creating directories... >&2
find -not \( -name '.git*' -prune \) -type d | sed 's/^\.\///' | xargs -rI%p mkdir $force $verbose -p "$PREFIX/.%p"

# install files
echo linking files... >&2
find -not \( -name '.git*' -prune -o -name 'LICENSE' -o -name 'install.sh' -o -name 'update-repo.sh' \) -type f | sed 's/^\.\///' | xargs -rI%p ln $force $verbose ./%p "$PREFIX/.%p"

echo 'Done!' >&2

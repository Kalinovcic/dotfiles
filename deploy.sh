#!/usr/bin/bash

usage() {
  echo "Usage: $0 [-f|--force]"
  exit
}

force=f

while test $# != 0
do
    case "$1" in
    -h|--help) usage ;;
    -f|--force) force=t ;;
    --) shift; break;;
    *)  usage ;;
    esac
    shift
done

install_dotfile() {
  link_path="$HOME/$1"
  link_directory_path=$(dirname "$link_path")
  target_path=$(realpath "$1")

  [ -e "$link_path" ] && [ "$force" = t ] && rm "$link_path"
  [ -e "$link_path" ] && echo "WARN: skipping $link_path, exists" && return

  mkdir -p "$link_directory_path"
  ln -s "$target_path" "$link_path"
  echo "INFO: $link_path -> $target_path"
}

install_dotfile ".bashrc"
install_dotfile ".profile"

shopt -s globstar
for bla in .config/**; do
  [ ! -f "$bla" ] && continue
  install_dotfile "$bla"
done
for bla in .local/**; do
  [ ! -f "$bla" ] && continue
  install_dotfile "$bla"
done

# https://git-scm.com/docs/git-credential-store
# ```
#   --file=<path>
#
#     Use <path> to lookup and store credentials. The file will have its
#     filesystem permissions set to prevent other users on the system from
#     reading it, but it will not be encrypted or otherwise protected. If not
#     specified, credentials will be searched for from ~/.git-credentials and
#     $XDG_CONFIG_HOME/git/credentials, and credentials will be written to
#     ~/.git-credentials if it exists, or $XDG_CONFIG_HOME/git/credentials if it
#     exists and the former does not.
# ```
#
# The `--file` flag isn't set in `.config/git/config` because it would require
# specifying the aboslute path, and therefore specifying the username. So we
# want the XDG file to exist if it doesn't, and move the `.git-credentials` from
# home there if it already exists.
[ -f ~/.git-credentials ] &&
  mv ~/.git-credentials .config/git/credentials
touch .config/git/credentials

echo "NOTE: the 'etc' directory is not deployed by this script!"

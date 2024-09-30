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

  [ -e "$link_path" ] && [ "$force" = t ] && echo "WARN: removing old $link_path" && rm "$link_path"
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

echo "NOTE: the 'etc' directory is not deployed by this script!"

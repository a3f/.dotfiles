#!/usr/bin/env bash
set -eu
tmp=`mktemp` _trap="rm -r "$tmp"; ${_trap:-}" && trap "$_trap" EXIT
svn diff "$@" > "$tmp"
# svn diff "$@" | iconv -f utf-8 -t utf-8 -c > "$tmp"   # skip malformed UTF-8 characters
svn commit "$@" "--editor-cmd=svn-editor.sh $(printf %q "$tmp")"

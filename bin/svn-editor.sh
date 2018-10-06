#!/usr/bin/env bash
set -eu
diff_f=$1
commit_msg_f=$2
# dos2unix "$diff_f"   # if svn repo has files with different line-ending styles
# dos2unix -f "$diff_f"   # to make it always treat diff output as text
echo >> "$commit_msg_f"

cat "$diff_f" >> "$commit_msg_f"
"$EDITOR" "$commit_msg_f"

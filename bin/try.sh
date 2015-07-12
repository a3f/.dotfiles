#!/bin/bash
cd=${PWD##*/}
cd /tmp

case $1 in "cc"|"gcc"|"c++"|"g++"|"clang++"|"clang"|"icc"|"i++"|"c99") 
#./a.out
args=( "$@" )
echo ${args//^aa$/ewq}
args=$(sed -e's/\([^-].*\)/~\1~/g' <<< $@)
#set -- "${args[@]}"
echo "${args[@]}"   # $* ==> foo BAR baz
;;
*)
echo "nope"
esac


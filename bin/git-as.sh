#!/bin/bash
SSH_KEYFILE=$1 GIT_SSH=${BASH_SOURCE%/*}/ssh-as.sh exec git "${@:2}"

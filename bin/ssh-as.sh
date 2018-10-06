#!/bin/bash
exec ssh ${SSH_KEYFILE+-i "$SSH_KEYFILE"} "$@"

# to be sourced in .bashrc or similar
# ssh-reagent finds a working ssh-agent socket
# and sets your environment for using it
# Also you can choose to use other-users-sockets,
#  if you have the write access for them

ssh-reagent () {
    debug(){ [ "$DEBUG" = ${FUNCNAME[1]} ] && "$@" >&2; }

    debug set -x

    userid=${1-`id -u`}
    sockets=$(find /tmp -user $userid -ipath '*ssh*agent*' -print 2>/dev/null)
    # Maybe a search on egrep SSH_AUTH_SOCK /proc/*/environ would be faster

    for sock in $sockets; do
        export SSH_AUTH_SOCK=$sock
        if ssh-add -l 2>&1 > /dev/null; then
            : Found working SSH Agent:
            debug ssh-add -l
            debug set +x
            return 0
        fi
    done

    : Cannot find ssh agent - maybe you should reconnect and forward it?
    debug set +x
    return 1
}

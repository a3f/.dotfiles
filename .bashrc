# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=100000

shopt -s checkwinsize

#[ -z "$PS1" ] && return;
#PS1="\[\e[38;5;3m\][\u@\h \w]\\$\[\]\[\e[0m\] \`if [ \$? = 0 ]; then echo -e '\[\e[01;32m\]\n✔'; else echo -e '\[\e[01;31m\]\n✘'; fi\` \[\e[01;34m\]\[\e[00m"
export PROMPT_COMMAND=__prompt_command

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

function __prompt_command() {
    local EXIT="$?"

    PS1="${debian_chroot:+($debian_chroot)}"
    PS1+="\[\e[38;5;3m\][\u@\h \w]"
    PS1+="\[\033[32m\]\$(parse_git_branch)\[\033[00m\]"
    PS1+="\\$\[$(tput sgr0)\]\[\e[0m\]"
    if [ $EXIT -eq 0 ]; then
        PS1+="\[\e[01;32m\]\n0 ";
    elif [ $EXIT -lt 128 ]; then
        PS1+="\[\e[01;31m\]\nx ";
    else
        PS1+="\[\e[01;33m\]\n! ";
    fi
    PS1+="\[\e[01;34m\]\[\e[00m"
}

export CCACHE_DIR=~/.ccache
PATH="~/perl5/bin:$PATH"
PATH="/usr/local/opt/ccache/libexec:$PATH"
PATH="~/bin:~/doc:~/symlinks:$PATH"
PATH="~/.local/bin:/opt/bin:$PATH"

export EDITOR=vi
#set -o vi


# enables usage of ^Q in vim
stty -ixon > /dev/null 2>/dev/null

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export MANPATH="$HOME/man:$MANPATH"

[ -f ~/perl5/perlbrew/etc/bashrc ] && source ~/perl5/perlbrew/etc/bashrc
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"
command -v teamocil &>/dev/null && complete -W "$(teamocil --list)" teamocil

[ -d ~/.bashrc.d ] && for file in ~/.bashrc.d/*.bashrc;
do
    source $file
done


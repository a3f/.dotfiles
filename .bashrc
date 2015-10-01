#[ -z "$PS1" ] && return;
PS1="\[\e[38;5;3m\][\u@\h \w]\\$\[$(tput sgr0)\]\[\e[0m\] \`if [ \$? = 0 ]; then echo -e '\[\e[01;32m\]\n\xE2\x98\xBA'; else echo -e '\[\e[01;31m\]\n\xE2\x98\xB9'; fi\` \[\e[01;34m\]\[\e[00m"
#PS1='[\033[01m][ [\033[01;34m]\u@\h [\033[00m][\033[01m]] [\033[01;32m]\w[\033[00m]\n[\033[01;34m]$[\033[00m]>'
color()(set -o pipefail;"$@" 2>&1>&3|sed $'s,.*,\e[31m&\e[m,'>&2)3>&1

HIGHLIGHT=`echo -e '\033[41m\033[37m'`
NORMAL=`echo -e '\033[0m'`

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
cal () {
	$(which cal) $@ | sed -e "s/\(`date +%e`\)/$HIGHLIGHT\1$NORMAL/"
}
cd! () {
	mkdir -v -p $@;
	cd $@;
}

alias ll='ls -lhA'
alias ls='ls -GF'
alias make='make -j4'
alias make!='make clean; make -j4'
alias a='./a.out'
alias dudir="find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn"
alias lsnet='sudo arp-scan --localnet --interface '
alias lshot='grep ip_address /private/var/db/dhcpd_leases | cut -d= -f2 | nmap -iL - -sn | tail -n +2 | sed -n "s/^Nmap scan report for \(.*\)\$/\1/p"'
alias man='MANWIDTH=$(($COLUMNS-12)) man'
alias back='cd $OLDPWD'
alias valgrind='valgrind --dsymutil=yes'
alias manman='cat ~/txt/sections.txt'
alias ..='cd ..'
alias ...='cd ../..'
alias gcc='gcc-5'
alias vi='nvim -u ~/.vimrc.minimal'
alias unq='xattr -d com.apple.quarantine'
alias gdb='gdb -q'
alias bc='bc -lq'
W='-Wall -Wextra -pedantic'

PATH=~/bin:~/doc:$PATH
PATH=/usr/local/carlson-minot/crosscompilers/bin/:$PATH

export EDITOR=vim
set -o vi

# MacPorts Installer addition on 2015-05-22_at_16:29:47: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.
source /opt/local/etc/bash_completion.d/*.bash
source /opt/local/etc/bash_completion.d/*.sh

# enables usage of ^Q in vim
stty -ixon > /dev/null 2>/dev/null


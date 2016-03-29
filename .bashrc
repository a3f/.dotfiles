#[ -z "$PS1" ] && return;
PS1="\[\e[38;5;3m\][\u@\h \w]\\$\[$(tput sgr0)\]\[\e[0m\] \`if [ \$? = 0 ]; then echo -e '\[\e[01;32m\]\n\xE2\x98\xBA'; else echo -e '\[\e[01;31m\]\n\xE2\x98\xB9'; fi\` \[\e[01;34m\]\[\e[00m"
#PS1='[\033[01m][ [\033[01;34m]\u@\h [\033[00m][\033[01m]] [\033[01;32m]\w[\033[00m]\n[\033[01;34m]$[\033[00m]>'
color() {
	if [ $# = 0 ]; then
		sed $'s,.*,\e[31m&\e[m,' ;
	else
		(set -o pipefail;"$@" 2>&1>&3|sed $'s,.*,\e[31m&\e[m,'>&2)3>&1;
	fi
		
}

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
if [[ $OSTYPE == darwin* ]]; then
alias tac='tail -r'
alias unq='xattr -d com.apple.quarantine'
alias ldd='otool -L'
fi
alias ll='ls -hkAl'
alias ls='ls -GF'
alias make='make -j4'
alias make!='make clean; make -j4'
alias a='./a.out'
alias size='size --format=SysV'
alias dudir="find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn"
alias lsnet='sudo arp-scan --localnet --interface '
alias lshot='grep ip_address /private/var/db/dhcpd_leases | cut -d= -f2 | nmap -iL - -sn | tail -n +2 | sed -n "s/^Nmap scan report for \(.*\)\$/\1/p"'
alias man='MANWIDTH=$(($COLUMNS-12)) man'
alias back='cd $OLDPWD'
alias valgrind='valgrind --dsymutil=yes'
alias manman='cat ~/txt/sections.txt'
alias ..='cd ..'
alias ...='cd ../..'
alias vi='nvim -u ~/.vimrc.minimal'
alias ed='ed -p:'
alias gdb='gdb -q'
alias bc='bc -lq'

# by brian d foy
alias d2h="perl -e 'printf qq|%X\n|, int( shift )'"
alias d2o="perl -e 'printf qq|%o\n|, int( shift )'"
alias d2b="perl -e 'printf qq|%b\n|, int( shift )'"
alias h2d="perl -e 'printf qq|%d\n|, hex( shift )'"
alias h2o="perl -e 'printf qq|%o\n|, hex( shift )'"
alias h2b="perl -e 'printf qq|%b\n|, hex( shift )'"
alias o2h="perl -e 'printf qq|%X\n|, oct( shift )'"
alias o2d="perl -e 'printf qq|%d\n|, oct( shift )'"
alias o2b="perl -e 'printf qq|%b\n|, oct( shift )'"

W='-Wall -Wextra -pedantic'
lallegro=`pkg-config --cflags --libs allegro-5 allegro_acodec-5 allegro_audio-5 allegro_font-5 allegro_image-5 allegro_main-5 allegro_dialog-5 allegro_primitives-5 allegro_ttf-5`

PATH=~/bin:~/doc:$PATH
PATH=/usr/local/carlson-minot/crosscompilers/bin/:$PATH
PATH=/Users/a3f/arm-cs-tools/bin:$PATH

export EDITOR=vim
#set -o vi

# MacPorts Installer addition on 2015-05-22_at_16:29:47: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.
source /opt/local/etc/bash_completion.d/*.bash
source /opt/local/etc/bash_completion.d/*.sh

# enables usage of ^Q in vim
stty -ixon > /dev/null 2>/dev/null

cd()
{
	builtin cd "$@" && eval "`ondir \"$OLDPWD\" \"$PWD\"`"
}

pushd()
{
	builtin pushd "$@" && eval "`ondir \"$OLDPWD\" \"$PWD\"`"
}

popd()
{
	builtin popd "$@" && eval "`ondir \"$OLDPWD\" \"$PWD\"`"
}              

# Run ondir on login
eval "`ondir /`"

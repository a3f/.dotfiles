HIGHLIGHT=`echo -e '\033[41m\033[37m'`
NORMAL=`echo -e '\033[0m'`

color() {
	if [ $# = 0 ]; then
		sed $'s,.*,\e[31m&\e[m,' ;
	else
		(set -o pipefail;"$@" 2>&1>&3|sed $'s,.*,\e[31m&\e[m,'>&2)3>&1;
	fi
		
}

W='-Wall -Wextra -pedantic'
lallegro='pkg-config --cflags --libs allegro-5 allegro_acodec-5 allegro_audio-5 allegro_font-5 allegro_image-5 allegro_main-5 allegro_dialog-5 allegro_primitives-5 allegro_ttf-5'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'


cal () {
    $(which cal) $@ | sed -e "s/\([\n ]\)\(`date +%e`\)\([\n ]\)/\1$HIGHLIGHT\2$NORMAL\3/"
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
alias ping='ping -a'
alias size='gsize --format=SysV'
alias dudir="find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn"
alias lsnet='sudo arp-scan --localnet --interface '
alias lshot='grep ip_address /private/var/db/dhcpd_leases | cut -d= -f2 | nmap -iL - -sn | tail -n +2 | sed -n "s/^Nmap scan report for \(.*\)\$/\1/p"'
man () {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    MANWIDTH=$(($COLUMNS-12)) \
    man "$@"
}
alias back='cd $OLDPWD'
alias valgrind='valgrind --dsymutil=yes'
alias manman='cat ~/txt/sections.txt'
alias ..='cd ..'
alias ...='cd ../..'
alias ed='ed -p:'
alias gdb='gdb -q'
alias bc='bc -lq'
alias vim='nvim'
alias vi='nvim -u ~/.vimrc.minimal'

alias 2b='2base 2'
alias 2o='2base 8'
alias 2d='2base 10'
alias 2h='2base 16'
alias 2x='2base 16'

alias .='source'
source()
{
    builtin source "${@:-$HOME/.bashrc}"
}

psignal()
{
    command psignal "${@:-$?}"
}

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

alias c4ev3="github-dl c4ev3"


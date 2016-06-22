W='-Wall -Wextra -pedantic'
lallegro=`pkg-config --cflags --libs allegro-5 allegro_acodec-5 allegro_audio-5 allegro_font-5 allegro_image-5 allegro_main-5 allegro_dialog-5 allegro_primitives-5 allegro_ttf-5`

alias vim='nvim'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

HIGHLIGHT=`echo -e '\033[41m\033[37m'`
NORMAL=`echo -e '\033[0m'`

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
alias ping='ping -a'
alias size='size --format=SysV'
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
alias vi='nvim -u ~/.vimrc.minimal'
alias ed='ed -p:'
alias gdb='gdb -q'
alias bc='bc -lq'

# originally by brian d foy
2h () {
    if [[ $# -ne 0 ]]
    then echo $1 |
        perl -ne 'printf qq|%x\n|, (/^0/ ? oct( $_ ) : $_)'
    else
        perl -ne 'printf qq|%x\n|, (/^0/ ? oct( $_ ) : $_)'
    fi
}
2base () {
    if [[ $# -ne 0 ]]
    then echo $1 |
        perl -ne 'printf qq|%o\n|, (/^0/ ? oct( $_ ) : $_)'
    else
        perl -ne 'printf qq|%o\n|, (/^0/ ? oct( $_ ) : $_)'
    fi
}
2o () {
    if [[ $# -ne 0 ]]
    then echo $1 |
        perl -ne 'printf qq|%o\n|, (/^0/ ? oct( $_ ) : $_)'
    else
        perl -ne 'printf qq|%o\n|, (/^0/ ? oct( $_ ) : $_)'
    fi
}
2b () {
    if [[ $# -ne 0 ]]
    then echo $1 |
        perl -ne 'printf qq|%b\n|, (/^0/ ? oct( $_ ) : $_)'
    else
        perl -ne 'printf qq|%b\n|, (/^0/ ? oct( $_ ) : $_)'
    fi
}
2d () {
    if [[ $# -ne 0 ]]
    then echo $1 |
        perl -ne 'printf qq|%d\n|, (/^0/ ? oct( $_ ) : $_)'
    else
        perl -ne 'printf qq|%d\n|, (/^0/ ? oct( $_ ) : $_)'
    fi
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


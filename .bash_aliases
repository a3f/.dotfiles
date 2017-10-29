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
pushd! () {
	mkdir -v -p $@;
	pushd $@;
}
if [[ $OSTYPE == darwin* ]]; then
alias tac='tail -r'
alias unq='xattr -d com.apple.quarantine'
alias ldd='otool -L'
alias fastbrew='HOMEBREW_NO_AUTO_UPDATE=1 brew'
fi
alias print='echo'
alias ll='ls -hkAl'
alias ls='ls -GF'
alias make='make -j4'
alias make!='make clean; make -j4'
alias a='./a.out'
alias ping='ping -a'
alias size='gsize --format=SysV'
alias dudir="find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn | perl -MNumber::Bytes::Human=format_bytes -ne '/^(.*)\t(.*)$/; print format_bytes(1000*$ 1), qq(\t), $ 2, qq(\n)'"
alias lsnet='sudo arp-scan --localnet --interface '
alias lshot='grep ip_address /private/var/db/dhcpd_leases | cut -d= -f2 | nmap -iL - -sn | tail -n +2 | sed -n "s/^Nmap scan report for \(.*\)\$/\1/p"'
alias lman="man -M$HOME/linux-man"
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

ar-repack () {
    (
        archive=$(realpath "$@")
        cd $(mktemp -d) || return 1
        ar -x $archive || rm -rf $(pwd); cd -; return 1
        llvm-ar crv $archive *.o
        rm -rf $(pwd)
    )
}

hangman()
{
    W=$(shuf -n1 /usr/share/dict/words) perl -pe '$_=$s=$ENV{W}=~s/[^.$_$s]/_/gri."\n?"'
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
alias mypi="smbutil lookup mypi | perl -077 -pe 's/.*mypi: (.*)/\1/gs'"

export CHAR_MIN=-128
export CHAR_MAX=127
export UCHAR_MIN=0
export UCHAR_MAX=255

export SHRT_MIN=-32768
export SHRT_MAX=32767
export USHRT_MIN=0
export USHRT_MAX=65535

export INT_MIN=-2147483648
export INT_MAX=2147483647
export UINT_MIN=0
export UINT_MAX=4294967295

export LONG_MIN=9223372036854775807
export LONG_MAX=-9223372036854775808
export ULONG_MIN=0
export ULONG_MAX=18446744073709551615

alias 2b='2base -d 2'
alias 2o='2base -d 8'
alias 2d='2base -d 10'
alias 2h='2base -d 16'
alias 2x='2base -d 16'
alias 2a='2u'
# paged ack
alias pgack='ack --pager="less -R"'
alias dziltest='dzil run --nobuild prove-5.24 -lv'
xdd()
{
    xml sel -N \
        x="http://www.ethernet-powerlink.org" \
        xsi="http://www.w3.org/2001/XMLSchema-instance" \
        -t -m "$2" -c . -n "$1"
}

alias .='source'
source()
{
    builtin source "${@:-$HOME/.bashrc}"
}

psignal()
{
    command psignal "${@:-$?}"
}

settitle() {
    printf "\033k$1\033\\"
}

alias c4ev3="github-dl c4ev3"


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

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias grep='grep --color=auto'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias diff='diff --color=auto'
fi


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
cpan-version () {
    perl -M$1 -e "print $ $1::VERSION, qq(\n)";
}
ackvi () {
    ack -l $@ | xargs -o vi "+/$1"
}
ackvim () {
    ack -l $@ | xargs -o vim "+/$1"
}

if [[ $OSTYPE == darwin* ]]; then
alias tac='tail -r'
alias unq='xattr -d com.apple.quarantine'
alias ldd='otool -L'
alias fastbrew='HOMEBREW_NO_AUTO_UPDATE=1 brew'
fi
alias print='echo'
alias rm='rm -d'
alias ll='ls -hkAl'
alias ls='ls -GF'
alias make='make -j4'
alias make!='make clean; make -j4'
alias a='./a.out'
alias ping='ping -a'
alias size='size --format=SysV'
alias dudir="find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -n | perl -MNumber::Bytes::Human=format_bytes -ne '/^(.*)\t(.*)$/; print format_bytes(1000*$ 1), qq(\t), $ 2, qq(\n)'"
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
alias mypi="smbutil lookup mypi | perl -077 -pe 's/.*mypi: (.*)/\1/gs'"

alias 2b='2base -d 2'
alias 2o='2base -d 8'
alias 2d='2base -d 10'
alias 2c='perl -pe "while (<>) { $_ - 0xFFFFFFFF }"'
alias 2h='2base -d 16'
alias 2x='2base -d 16'
alias 2a='2u'
alias c='microcom -p'

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

#alias .='source'
#source()
#{
#    builtin source "${@:-$HOME/.bashrc}"
#}

psignal()
{
    command psignal "${@:-$?}"
}

settitle() {
    printf "\033k$1\033\\"
}

alias c4ev3="github-dl c4ev3"

function suptime() {
    local addr=${1:?Specify the remote IPv4 address}
    local port=${2:?Specify the remote port number}
    # convert the provided address to hex format
    local hex_addr=$(python -c "import socket, struct; print(hex(struct.unpack('<L', socket.inet_aton('$addr'))[0])[2:10].upper().zfill(8))")
    local hex_port=$(python -c "print(hex($port)[2:].upper().zfill(4))")
    # get the PID of the owner process
    local pid=$(netstat -ntp 2>/dev/null | awk '$6 == "ESTABLISHED" && $5 == "'$addr:$port'"{sub("/.*", "", $7); print $7}')
    [ -z "$pid" ] && { echo 'Address does not match' 2>&1; return 1; }
    # get the inode of the socket
    local inode=$(awk '$4 == "01" && $3 == "'$hex_addr:$hex_port'" {print $10}' /proc/net/tcp)
    [ -z "$inode" ] && { echo 'Cannot lookup the socket' 2>&1; return 1; }
    # query the inode status change time
    local timestamp=$(find /proc/$pid/fd -lname "socket:\[$inode\]" -printf %T@)
    [ -z "$timestamp" ] && { echo 'Cannot fetch the timestamp' 2>&1; return 1; }
    # compute the time difference
    LANG=C printf '%s (%.2fs ago)\n' "$(date -d @$timestamp)" $(bc <<<"$(date +%s.%N) - $timestamp")
}

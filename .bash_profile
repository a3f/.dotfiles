PS1='\[\e[38;5;3m\][\u@\h \W]\$\[\e[0m\] '
function ev 
{
  echo $@ | ghci
}

function rpipe
{
  $1 | $2
}
color()(set -o pipefail;"$@" 2>&1>&3|sed $'s,.*,\e[31m&\e[m,'>&2)3>&1
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias ll='ls -lhA'
alias lsn='sudo arp-scan --localnet --interface '


PATH=~/bin:$PATH
PATH=~/doc:$PATH
export EDITOR=vim
set -o vi
set editing-mode vi
set keymap vi


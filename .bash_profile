PS1='\[\e[38;5;3m\][\u@\h \W]\$\[\e[0m\] '
function ev 
{
  echo $@ | ghci
}

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias ll='ls -lhA'

PATH=~/bin:$PATH


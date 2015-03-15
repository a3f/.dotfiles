PS1='\[\e[38;5;3m\][\u@\h \W]\$\[\e[0m\] '
function ev 
{
  echo $@ | ghci
}
PATH=~/bin:$PATH


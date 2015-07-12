#[ -z "$PS1" ] && return;
PS1="\[\e[38;5;3m\][\u@\h \w]\\$\[$(tput sgr0)\]\[\e[0m\] \`if [ \$? = 0 ]; then echo -e '\[\e[01;32m\]\n\xE2\x98\xBA'; else echo -e '\[\e[01;31m\]\n\xE2\x98\xB9'; fi\` \[\e[01;34m\]\[\e[00m"
#PS1='[\033[01m][ [\033[01;34m]\u@\h [\033[00m][\033[01m]] [\033[01;32m]\w[\033[00m]\n[\033[01;34m]$[\033[00m]>'
color()(set -o pipefail;"$@" 2>&1>&3|sed $'s,.*,\e[31m&\e[m,'>&2)3>&1
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias ll='ls -lhA'
alias ls='ls -GF'
alias lsn='sudo arp-scan --localnet --interface '


PATH=~/bin:$PATH
PATH=~/doc:$PATH
PATH=~/doc:$PATH
PATH=/usr/local/carlson-minot/crosscompilers/bin/:$PATH

export EDITOR=vim

##
# Your previous /Users/a3f/.bash_profile file was backed up as /Users/a3f/.bash_profile.macports-saved_2015-05-22_at_16:22:38
##

# MacPorts Installer addition on 2015-05-22_at_16:22:38: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


##
# Your previous /Users/a3f/.bash_profile file was backed up as /Users/a3f/.bash_profile.macports-saved_2015-05-22_at_16:29:47
##

# MacPorts Installer addition on 2015-05-22_at_16:29:47: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.
source /opt/local/etc/bash_completion.d/*.bash
source /opt/local/etc/bash_completion.d/*.sh


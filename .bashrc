#[ -z "$PS1" ] && return;
PS1="\[\e[38;5;3m\][\u@\h \w]\\$\[$(tput sgr0)\]\[\e[0m\] \`if [ \$? = 0 ]; then echo -e '\[\e[01;32m\]\n✔'; else echo -e '\[\e[01;31m\]\n✘'; fi\` \[\e[01;34m\]\[\e[00m"
#PS1="\[\e[38;5;3m\][\u@\h \w]\\$\[$(tput sgr0)\]\[\e[0m\] \`if [ \$? = 0 ]; then echo -e '\[\e[01;32m\]\n✓'; else echo -e '\[\e[01;31m\]\n𐄂'; fi\` \[\e[01;34m\]\[\e[00m"
#PS1='[\033[01m][ [\033[01;34m]\u@\h [\033[00m][\033[01m]] [\033[01;32m]\w[\033[00m]\n[\033[01;34m]$[\033[00m]>'
color() {
	if [ $# = 0 ]; then
		sed $'s,.*,\e[31m&\e[m,' ;
	else
		(set -o pipefail;"$@" 2>&1>&3|sed $'s,.*,\e[31m&\e[m,'>&2)3>&1;
	fi
		
}

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


# Run ondir on login
eval "`ondir /`"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

source ~/.bash_aliases


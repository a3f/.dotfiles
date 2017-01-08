#[ -z "$PS1" ] && return;
#PS1="\[\e[38;5;3m\][\u@\h \w]\\$\[\]\[\e[0m\] \`if [ \$? = 0 ]; then echo -e '\[\e[01;32m\]\n✔'; else echo -e '\[\e[01;31m\]\n✘'; fi\` \[\e[01;34m\]\[\e[00m"
export PROMPT_COMMAND=__prompt_command

function __prompt_command() {
    local EXIT="$?"

    PS1="\[\e[38;5;3m\][\u@\h \w]\\$\[$(tput sgr0)\]\[\e[0m\]"
    if [ $EXIT -eq 0 ]; then
        PS1+='\[\e[01;32m\]\n✔ ';
    elif [ $EXIT -lt 128 ]; then
        PS1+='\[\e[01;31m\]\n✘ ';
    else
        PS1+='\[\e[01;33m\]\n⚡ ';
    fi
    PS1+='\[\e[01;34m\]\[\e[00m'
}

PATH=~/bin:~/doc:~/symlinks:$PATH
PATH=/usr/local/carlson-minot/crosscompilers/bin/:$PATH
PATH=/Users/a3f/arm-cs-tools/bin:$PATH

export EDITOR=vim
#set -o vi


# enables usage of ^Q in vim
stty -ixon > /dev/null 2>/dev/null



if [[ "$OSTYPE" == "darwin"* ]]; then
	# MacPorts Installer addition on 2015-05-22_at_16:29:47: adding an appropriate PATH variable for use with MacPorts.
	export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
	# Finished adapting your PATH environment variable for use with MacPorts.
	source /opt/local/etc/bash_completion.d/*.bash
	source /opt/local/etc/bash_completion.d/*.sh

	test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

	if [ -f $(brew --prefix)/etc/bash_completion ]; then
		. $(brew --prefix)/etc/bash_completion
	fi
fi

source ~/.bash_aliases


##
# Your previous /Users/a3f/.bash_profile file was backed up as /Users/a3f/.bash_profile.macports-saved_2016-07-17_at_08:41:56
##

# MacPorts Installer addition on 2016-07-17_at_08:41:56: adding an appropriate PATH variable for use with MacPorts.
export DYLD_FORCE_FLAT_NAMESPACE=1
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"
export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
export CPATH="/usr/local/include:$CPATH"

# MacPorts Installer addition on 2016-12-13_at_15:58:31: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:/usr/local/Cellar/qt5/5.7.1_1/bin/:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


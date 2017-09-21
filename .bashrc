#[ -z "$PS1" ] && return;
#PS1="\[\e[38;5;3m\][\u@\h \w]\\$\[\]\[\e[0m\] \`if [ \$? = 0 ]; then echo -e '\[\e[01;32m\]\n✔'; else echo -e '\[\e[01;31m\]\n✘'; fi\` \[\e[01;34m\]\[\e[00m"
export PROMPT_COMMAND=__prompt_command

function __prompt_command() {
    local EXIT="$?"

    PS1="\[\e[38;5;3m\][\u@\h \w]\\$\[$(tput sgr0)\]\[\e[0m\]"
    if [ $EXIT -eq 0 ]; then
        PS1+="\[\e[01;32m\]\n✔ ";
    elif [ $EXIT -lt 128 ]; then
        PS1+="\[\e[01;31m\]\n✘ ";
    else
        PS1+="\[\e[01;33m\]\n⚡ ";
    fi
    PS1+="\[\e[01;34m\]\[\e[00m"
}

export CCACHE_DIR=~/.ccache
PATH=/usr/local/opt/ccache/libexec:$PATH
PATH=~/bin:~/doc:~/symlinks:$PATH
PATH=/usr/local/carlson-minot/crosscompilers/bin:$PATH
PATH=/Users/a3f/arm-cs-tools/bin:$PATH

export EDITOR=vi
#set -o vi


# enables usage of ^Q in vim
stty -ixon > /dev/null 2>/dev/null



if [[ "$OSTYPE" == "darwin"* ]]; then
	# MacPorts Installer addition on 2015-05-22_at_16:29:47: adding an appropriate PATH variable for use with MacPorts.
	export PATH="$PATH:/usr/bin:/opt/local/bin:/opt/local/sbin"
    export PATH="/usr/local/Cellar/qt/5.9.1/bin:$PATH"
    export PATH="/usr/local/sbin:$PATH"
	# Finished adapting your PATH environment variable for use with MacPorts.
	source /opt/local/etc/bash_completion.d/*.bash
	source /opt/local/etc/bash_completion.d/*.sh

	test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

	if [ -f /usr/local/etc/bash_completion ]; then
		. /usr/local/etc/bash_completion
	fi
fi

export MANPATH="$HOME/man:$MANPATH"
#export DYLD_FORCE_FLAT_NAMESPACE=1
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig"
#export DYLD_INSERT_LIBRARIES='/System/Library/Frameworks/OpenGL.framework/Resources/GLEngine.bundle/GLEngine' 
 

source /opt/cross/setenv.sh
#source ~/perl5/perlbrew/etc/bashrc

if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"
complete -W "$(teamocil --list)" teamocil

# added by travis gem
[ -f /Users/a3f/.travis/travis.sh ] && source /Users/a3f/.travis/travis.sh

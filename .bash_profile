# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

export PATH=$HOME/.local/bin:$HOME/bin:$HOME/go/bin:$PATH

source $HOME/.nvm/nvm.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

alias g='cd $(ghq root)/$(ghq list | peco)'
alias b='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
alias v='code $(ghq root)/$(ghq list | peco)'

source ~/.git-completion.bash

# python
alias python=python3.8
alias pip=pip3.8

# .bashrc

# Source global definitions
 if [ -f /etc/bashrc ]; then
	. /etc/bashrc
 fi


# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# set vim bindings in terminal
set -o vi

export SLURM_ACCOUNT=def-oyilmaz
export SBATCH_ACCOUNT=$SLURM_ACCOUNT
export SALLOC_ACCOUNT=$SLURM_ACCOUNT

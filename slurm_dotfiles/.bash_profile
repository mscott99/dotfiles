# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

# User defined
cd /home/mscott99/projects/def-oyilmaz/mscott99

export TERM=xterm-256color

export SBATCH_ACCOUNT="def-oyilmaz"

export PYTHONPATH=$PYTHONPATH:/home/mscott99/projects/def-oyilmaz/mscott99/utils

alias lsp="/home/mscott99/projects/def-oyilmaz/mscott99/server_scripts/run_sparse_exp.sh"
alias goh="cd /home/mscott99/projects/def-oyilmaz/mscott99"
alias salloc_gpu="salloc --time=02:30:00 --cpus-per-task=8 --gpus=1 --mem=8G"
alias salloc_cpu="salloc --time=02:30:00 --cpus-per-task=8 --gpus=1 --mem=32G"

alias showj="squeue -u mscott99"

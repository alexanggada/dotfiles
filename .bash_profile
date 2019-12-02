# Setting PATH for Python 2.5
# The original version is saved in .bash_profile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
# export PATH
# export PATH="/usr/local/opt/python/libexec/bin:$PATH"

alias icloud='~/Library/Mobile\ Documents/com~apple~CloudDocs/'
# added by Anaconda3 2019.07 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/Users/alexanderanggada/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/Users/alexanderanggada/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/alexanderanggada/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/Users/alexanderanggada/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

# Remove "Warning: Failed to set locale..." errors
export LC_ALL=en_US.UTF-8

export PYTHONPATH="/Users/alexanderanggada/anaconda3/bin"
export PATH="/Users/alexanderanggada/anaconda3/bin:$PATH"

alias vim=nvim

# Make FZF search faster
if [[ "$0" == "bash" ]]; then
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
elif [[ "$0" == "zsh" ]]; then
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi
export FZF_DEFAULT_COMMAND="rg --files\
                            -g '*'\
                            -g '!*Applications/*'\
                            -g '!*Desktop/*'\
                            -g '!*Downloads/*'\
                            -g '!*Dropbox/*'\
                            -g '!*Library/*'\
                            -g '!*Movies/*'\
                            -g '!*Music/*'\
                            -g '!*Pictures/*'\
                            -g '!*Templates/*'\
                            -g '!*Videos/*'
                            "
export FZF_TMUX=1
export FZF_TMUX_HEIGHT=20

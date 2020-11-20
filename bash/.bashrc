alias vim=nvim
# alias tmux="TERM=screen-256color-bce tmux"
# export TERM="xterm-256color"

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

# Added by Anaconda3 2019.07 installer
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

# Added by GHCUP
source /Users/alexanderanggada/.ghcup/env

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

# Added by GHCUP
source /Users/alexanderanggada/.ghcup/env

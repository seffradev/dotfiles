# Move into tmux unless we already are there
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    exec tmux
fi

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"

CASE_SENSITIVE="false"
COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_TITLE="false"
DISABLE_LS_COLORS="false"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_UNTRACKED_FILES_DIRTY="false"
ENABLE_CORRECTION="true"
HIST_STAMPS="yyyy-mm-dd"
HYPHEN_INSENSITIVE="true"
ZSH_CUSTOM=$ZSH/custom
ZSH_THEME="robbyrussell"

zstyle ':omz:update' frequency 13
zstyle ':omz:update' mode reminder

plugins=(git fzf z)

export EDITOR='nvim'
export PAGER='less --use-color'
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target,venv,cache,.cache,Cache,cached,.local,.config,.cargo,.mozilla,.rustup,.npm,.vim,.oh-my-zsh
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $HOME/.config/op/plugins.sh
source $ZSH/oh-my-zsh.sh

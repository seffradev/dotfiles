# Move into tmux unless we are already there
if [ ! $(tty | grep tty) ] && command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    exec tmux new -As 0
fi

# Paths
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"
export MANWIDTH=72
export EDITOR='nvim'
export PAGER='bat'
export PAGER_OPTS='-p'
export MANPAGER='bat -p'
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target,venv,cache,.cache,Cache,cached,.local,.config,.cargo,.mozilla,.rustup,.npm,.vim,.oh-my-zsh
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

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

export PNPM_HOME="/home/ha/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

zstyle ':omz:update' frequency 13
zstyle ':omz:update' mode reminder

autoload zmv

plugins=(git fzf z mvn)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

OP=$HOME/.config/op/plugins.sh
if [[ -f $OP ]]; then
    export SSH_AUTH_SOCK=~/.1password/agent.sock
    source $OP
fi

OMZ=$ZSH/oh-my-zsh.sh
if [[ -f $OMZ ]]; then
    source $OMZ
else
    echo "WARNING: Oh My Zsh couldn't be sourced"
fi


bindkey -v

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

alias lg=lazygit

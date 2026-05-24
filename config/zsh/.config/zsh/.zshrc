local begin_time=$(date +%s%N)

# zsh option
HISTSIZE=10000
if [[ -d $XDG_DATA_HOME/zsh ]]; then else
    mkdir -p $XDG_DATA_HOME/zsh
fi
HISTFILE=$XDG_DATA_HOME/zsh/zsh_history
SAVEHIST=$HISTSIZE
HIST_STAMPS="yyyy.mm.dd"
HISTUP=erase
setopt SHARE_HISTORY        # share history in all running zsh session
setopt HIST_IGNORE_SPACE    # Do not record an event starting with a space.
setopt HIST_IGNORE_DUPS     # Do not record an duplicated event.
setopt AUTOCD

bindkey -e

# fzf 颜色主题
export FZF_DEFAULT_OPTS=" \
    --color=bg+:#1e1e2e,spinner:#585b70,hl:#eba0ac \
    --color=fg:#a6adc8,header:#cba6f7,info:#89b4fa,pointer:#a6e3a1 \
    --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
    --color=selected-bg:#11111B \
    --color=border:#9399b2,label:#cdd6f4
    --prompt=\"\$ \"
    --pointer=\"›\"
    --marker=\"✓\"
    --scrollbar=\"▐\"
    "

# terminal utilities
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

# aliases
alias ls='eza'
alias ll='eza -l'
alias tree='eza --tree'
alias docker='podman'
alias cat='bat --plain'

# proxy on by default
proxy on > /dev/null 2>&1

source "$ZDOTDIR/plugins.zsh" # plugins
source "$ZDOTDIR/scripts.zsh" # custom shell scripts

fpath=("$ZDOTDIR/completions" $fpath)

# completion
autoload -Uz compinit
compinit

# profile this configuration and `fastfetch`
local end_time=$(date +%s%N)
export STARTUPTIME=$((end_time - begin_time))
fastfetch
unset STARTUPTIME

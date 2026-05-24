# zsh config home
ZDOTDIR="$HOME/.config/zsh"

# xdg directories
if [[ -z "$XDG_CONFIG_HOME" ]]; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi

if [[ -z "$XDG_CACHE_HOME" ]]; then
    export XDG_CACHE_HOME="$HOME/.cache"
fi

if [[ -z "$XDG_DATA_HOME" ]]; then
    export XDG_DATA_HOME="$HOME/.local/share"
fi

if [[ -z "$XDG_STATE_HOME" ]]; then
    export XDG_STATE_HOME="$HOME/.local/state"
fi

# secrete keys
if [ -f "$ZDOTDIR/secret.zsh" ]; then
    source "$ZDOTDIR/secret.zsh" 
fi

# cargo
if [ -r "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
else
    print -P "cargo not installed"
fi

# local bin
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin":$PATH
fi

# golang
export GOPATH=$HOME/.go
export PATH="$GOPATH/bin":$PATH

# editor
export EDITOR="nvim"

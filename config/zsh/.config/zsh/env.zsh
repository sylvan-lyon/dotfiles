# secrete keys
if [[ -f "$ZDOTDIR/secret.zsh" ]]; then
    source "$ZDOTDIR/secret.zsh" 
fi

# cargo
if [[ -r "$HOME/.cargo/env" ]]; then
    . "$HOME/.cargo/env"
else
    print -P "cargo not installed"
fi

# golang
export GOPATH=$HOME/.go
export PATH="$GOPATH/bin":$PATH

# editor
export EDITOR=nvim

# fnm nodejs
FNM_PATH="$XDG_DATA_HOME/fnm"
if [ -d "$FNM_PATH" ]; then
    export PATH="$FNM_PATH:$PATH"
    eval "$(fnm env --shell zsh)"
fi

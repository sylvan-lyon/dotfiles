### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zicompinit
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

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

# 让 fzf-tab 也使用我定义的主题
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' switch-group '<' '>'

# yazi 集成
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

# 代理管理
function proxy() {
    case "$1" in
        on)
            url="${2:-http://localhost:7890}"
            export http_proxy="$url" https_proxy="$url" all_proxy="$url"
            export HTTP_PROXY="$url" HTTPS_PROXY="$url" ALL_PROXY="$url"
            export no_proxy="127.0.0.1,localhost,[::1],192.168.1.0/24"
            git config --global http.proxy "$url"
            git config --global https.proxy "$url"
            echo "Proxy enabled: $url"
            ;;
        off)
            unset http_proxy https_proxy all_proxy HTTP_PROXY HTTPS_PROXY ALL_PROXY
            git config --global --unset http.proxy 2>/dev/null
            git config --global --unset https.proxy 2>/dev/null
            echo "Proxy disabled"
            ;;
        status)
            env | grep -i '_proxy' || echo "No proxy env"
            ;;
        *)
            echo "Usage: proxy on [url] | off | status"
            ;;
    esac
}


# cargo
if [ -r "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
else
    print -P "cargo not installed"
fi

# local bin
if [ -f "$HOME/.local/env" ]; then
    . "$HOME/.local/bin/env"
fi

# golang
export GOPATH=$HOME/.go
export PATH="${GOPATH}/bin/":$PATH

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


# startup
proxy on > /dev/null 2>&1
fastfetch

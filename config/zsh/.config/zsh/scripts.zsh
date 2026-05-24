# yazi 集成
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

# path
function path() {
    echo -e ${PATH//:/\\n}
}

# fpath
function fpath() {
    echo -e ${FPATH//:/\\n}
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

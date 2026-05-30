$env.config.show_banner = false

# yazi 的 wrapper
def --env y [...args] {
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp)
    if $cwd != "" and $cwd != $env.PWD {
        cd $cwd
    }
    rm -fp $tmp
}

# 智能解压 / 智能压缩
use scripts/smart-commands.nu *

alias tree = eza --tree --icons=auto --color=auto
alias sudo = gsudo
alias "su root" = gsudo
alias nginx = nginx -p $env.NGINX_HOME
alias cat = bat --plain

# 创建硬链接
def --env ln [origin: string, target: string] {
    mklink "/H" $target $origin
}

# 创建符号链接
def --env "ln -s" [origin: string, target: string] {
    mklink "/J" $target $origin
}

# rust 配置
$env.PATH = ($env.PATH | append ~/.cargo/bin)
$env.HTTP_PROXY = "http://localhost:7890"
$env.HTTPS_PROXY = "http://localhost:7890"

$env.EDITOR = "nvim"

$env.FZF_DEFAULT_OPTS = "
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8
--color=selected-bg:#45475A
--color=border:#6C7086,label:#CDD6F4"

$env.FZF_DEFAULT_OPTS = "
    --color=bg+:#1e1e2e,spinner:#585b70,hl:#eba0ac
    --color=fg:#a6adc8,header:#cba6f7,info:#89b4fa,pointer:#a6e3a1
    --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
    --color=selected-bg:#11111B
    --color=border:#9399b2,label:#cdd6f4
    --prompt=\"\$ \"
    --pointer=\"›\"
    --marker=\"✓\"
    --scrollbar=\"▐\"
"

# eza
source $"($nu.default-config-dir)/scripts/completions/eza.nu"

# ^fastfetch

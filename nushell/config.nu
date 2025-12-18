# config.nu
#
# Installed by:
# version = "0.106.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desire.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R


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
$env.RUSTUP_DIST_SERVER = "https://rsproxy.cn"
$env.RUSTUP_UPDATE_ROOT = "https://rsproxy.cn/rustup"

$env.EDITOR = "nvim"

$env.FZF_DEFAULT_OPTS = "
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8
--color=selected-bg:#45475A
--color=border:#6C7086,label:#CDD6F4"

# eza
source $"($nu.default-config-dir)/scripts/completions/eza.nu"

^fastfetch

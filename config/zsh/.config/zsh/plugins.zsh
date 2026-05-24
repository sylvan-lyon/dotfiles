ZPLUGIN_DIR=$XDG_DATA_HOME/zsh/plugins

zplugin_load() {
    local plugin_path="${ZPLUGIN_DIR}/${1}/${2}"
    if [[ ! -d "${plugin_path}" ]]; then
        mkdir -p "${ZPLUGIN_DIR}/${1}"
        echo "Installing ${1}/${2} ..."
        git clone --depth=1 "https://github.com/${1}/${2}" "$plugin_path" \
            || { echo "failed to install ${2}" >&2; return 1; }
    fi

    source "${plugin_path}/${2}.plugin.zsh"
}

zplugin_update() {
    for author in $(ls $ZPLUGIN_DIR); do
        for plugin in "${ZPLUGIN_DIR}/${author}"/*; do
            echo "Updating ${plugin:t}..."
            git -C "$plugin" pull --ff-only
        done
    done
}

# plugin installation
zplugin_load Aloxaf fzf-tab
zplugin_load zsh-users zsh-autosuggestions
zplugin_load zdharma-continuum fast-syntax-highlighting
zplugin_load jeffreytse zsh-vi-mode

# 让 fzf-tab 也使用我定义的主题
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' switch-group '<' '>'

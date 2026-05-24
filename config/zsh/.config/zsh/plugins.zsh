ZPLUGIN_DIR=$XDG_DATA_HOME/zsh/plugins

zplugin_load() {
    local plugin_path="${ZPLUGIN_DIR}/${1}"
    if [[ ! -d $plugin_path ]]; then
        mkdir -p $plugin_path
        echo "Installing ${1} ..."
        git clone --depth=1 "https://github.com/${1}.git" "$plugin_path" \
            || { echo "failed to install ${1}" >&2; return 1; }
    fi

    source "${plugin_path}/${1:t}.plugin.zsh"
}

zplugin_update() {
    for plugin in "$ZPLUGIN_DIR"/*/*; do
        echo "Updating ${plugin:t2}..."
        git -C "$plugin" pull --ff-only
    done
}

# plugin installation
zplugin_load Aloxaf/fzf-tab
zplugin_load zsh-users/zsh-autosuggestions
zplugin_load zdharma-continuum/fast-syntax-highlighting
zplugin_load jeffreytse/zsh-vi-mode
zplugin_load zsh-users/zsh-completions

# fzf-tab configuration
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' switch-group '<' '>'

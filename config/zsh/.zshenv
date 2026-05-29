# xdg directories
[[ -z "$XDG_CONFIG_HOME" ]] && export XDG_CONFIG_HOME="$HOME/.config"
[[ -z "$XDG_CACHE_HOME" ]] && export XDG_CACHE_HOME="$HOME/.cache"
[[ -z "$XDG_DATA_HOME" ]] && export XDG_DATA_HOME="$HOME/.local/share"
[[ -z "$XDG_STATE_HOME" ]] && export XDG_STATE_HOME="$HOME/.local/state"

# zsh config home
ZDOTDIR="$HOME/.config/zsh"
export ZDOTDIR

# local bin
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin":$PATH

#
# ~/.zprofile — login shell setup
#

# --- XDG Base Directory Specification ---
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"

# --- Language Runtimes ---

# Go
export GOPATH="$XDG_DATA_HOME/go"

# Python
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export PYENV_ROOT="$HOME/.pyenv"
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh  # miniconda

# uv (pip replacement with hash verification + isolated envs)
export UV_CACHE_DIR="$XDG_CACHE_HOME/uv"
export UV_DATA_DIR="$XDG_DATA_HOME/uv"
export UV_TOOL_DIR="$XDG_DATA_HOME/uv/tools"
export UV_TOOL_BIN_DIR="$HOME/.local/bin"  # shims land here, already in PATH

# Node
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PNPM_HOME="$XDG_DATA_HOME/pnpm"

# Less
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
mkdir -p "$(dirname "$LESSHISTFILE")"

# --- Wayland / Sway ---
export MOZ_ENABLE_WAYLAND=1
export _JAVA_AWT_WM_NONREPARENTING=1
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland

# --- Environment ---
export EDITOR='vim'
export VISUAL='nvim'
export TERM='screen-256color'
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk"

# --- PATH ---
# System bins first: prevents a `pip install` or `npm install -g` binary from shadowing system tools.
# User-controlled bins (pipx, pyenv, go) come after — they're yours, not a package's.
path=(
    /usr/local/bin
    /usr/bin
    /bin
    /usr/local/sbin
    /usr/sbin
    /sbin
    $HOME/.local/bin        # pipx, uv tools, user installs
    $PNPM_HOME              # pnpm global bins
    $XDG_DATA_HOME/npm/bin  # npm global bins (locked prefix)
    $HOME/.scripts
    $GOPATH/bin
    $PYENV_ROOT/bin         # pyenv shims
    $path                   # preserve any inherited entries (e.g. from PAM/ly)
)
typeset -U path             # deduplicate
export PATH

# --- Session Logic ---

# Weekend Fun Script (login only, Thu–Sat)
case $(date +%u) in
    4|5|6)
        _FLAG="$XDG_STATE_HOME/zsh/weekend_fun_run"
        mkdir -p "$(dirname "$_FLAG")"
        if [[ ! -f "$_FLAG" ]]; then
            [[ -f "$HOME/.dotfiles/Scripts/.scripts/weekendFun.sh" ]] && \
                "$HOME/.dotfiles/Scripts/.scripts/weekendFun.sh" &
            touch "$_FLAG"
        fi
        unset _FLAG
        ;;
    *)
        rm -f "$XDG_STATE_HOME/zsh/weekend_fun_run"
        ;;
esac

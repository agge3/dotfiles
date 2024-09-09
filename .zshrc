## on user login...
# Launch Hyprland after logging into the first TTY
if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    dbus-run-session Hyprland
    #-- -keeptty -nolisten tcp > ~/.wayland.log 2>&1
fi

# Ensure XDG_RUNTIME_DIR is set
# gentoo wiki XDG_RUNTIME_DIR for hyprland/pipewire
if test -z "$XDG_RUNTIME_DIR"; then
    export XDG_RUNTIME_DIR=$(mktemp -d /tmp/$(id -u)-runtime-dir.XXX)
fi

# zsh envvar...
# history config
#export HISTFILE="$HOME/.zsh_history" # default location
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY_TIME

# envvar...
export GDK_BACKEND=wayland,x11
#export DISPLAY=${WAYLAND_DISPLAY}
export QT_QPA_PLATFORM=wayland,xcb
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_WAYLAND_DISABLE_WINDOWDECORATION=0
export QT_APA_PLATFORMTHEME=qt5ct
export SDL_VIDEODRIVER=wayland
export CLUTTER_BACKEND=wayland

export XDG_CURRENT_DESKTOP=Hyprland
export XDG_CURRENT_TYPE=wayland
export XDG_SESSION_DESKTOP=Hyprland

# Application Themes
export GTK_THEME=Adwaita
export QT_STYLE_OVERRIDE=adwaita

export XCURSOR_SIZE=24

export KITTY_ENABLE_WAYLAND=1

export MOZ_ENABLE_WAYLAND=1
export MOZ_WAYLAND_USE_VAAPI=1
export MOZ_DBUS_REMOTE=1

# fcitx IME JP envvar
export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx

# hypr ecosystem envvar
export HYPRCURSOR_THEME=rose-pine-hyprcursor
export HYPRCURSOR_SIZE=24
#export XCURSOR_THEME=rose-pine-xcursor
#export XCURSOR_SIZE=24
#gsettings set org.gnome.desktop.interface cursor-theme rose-pine-xcursor

export EDITOR=nvim

# gtk settings...
gsettings set org.gnome.desktop.interface gtk-theme adwaita
# END ##

## Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true" 2

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="%F{green}In progress...%f"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    dirhistory
    web-search
    sudo
    zsh-completions
    )

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enabling Portage completions and Gentoo prompt for zsh
autoload -U compinit promptinit
compinit
promptinit; prompt gentoo

zstyle ':completion::complete:*' use-cache 1

# change color of auto-suggestion suggestions - foreground color num
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=3'

# allow agge to use nix-daemon
export NIX_REMOTE=daemon

# Source aliases
if [ -f "$HOME/.config/scripts/alias.sh" ]; then
	source "$HOME/.config/scripts/alias.sh"
fi

# Amazon Q pre block. Keep at the top of this file.
# [[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Load local environment variables (not tracked in git)
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

source /usr/local/share/chruby/chruby.sh
alias air='$(go env GOPATH)/bin/air'
alias vim='nvim'

export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
bindkey -s '^F' "tmux-sessionizer\n"


# tmuxifier
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

# eval "$(fnm env)"

# Path to your oh-my-zsh installation.
export ZSH="/Users/michallester/.oh-my-zsh"
export PATH="$HOME/.zig:$PATH"

# Path to VSCode
# export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

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

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

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
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/michallester/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/michallester/mambaforge/etc/profile.d/conda.sh" ]; then
#         . "/Users/michallester/mambaforge/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/michallester/mambaforge/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

# . "$HOME/.asdf/asdf.sh"
# . "$HOME/.asdf/completions/asdf.bash"
# Commented out - this was causing duplicates
# echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
export PATH="$HOME/.zig-compiler:$PATH"

# zsh-vi-mode configuration (load at the end to avoid conflicts)
# Reduce key timeout for faster mode switching (default is 0.4)
ZVM_KEYTIMEOUT=0.1

# Cursor style configuration
ZVM_CURSOR_STYLE_ENABLED=true

# Optional: Use jk to escape insert mode (uncomment if desired)
# ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

# Load zsh-vi-mode plugin
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# Fix for fzf integration (must be after zsh-vi-mode)
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')

# Restore custom keybindings after zsh-vi-mode initialization
function zvm_after_init() {
  bindkey -s '^F' "tmux-sessionizer\n"
}
eval "$(~/.local/bin/mise activate zsh)"
# Killport alias

# Killport function
killport() {
  if [ -z "$1" ]; then
    echo "Usage: killport <port>"
    return 1
  fi
  
  local pid=$(lsof -ti :$1)
  
  if [ -z "$pid" ]; then
    echo "No process found on port $1"
    return 1
  fi
  
  kill -9 $pid && echo "Killed process $pid on port $1"
}

# zoxide - smarter cd command
eval "$(zoxide init zsh)"

# yazi wrapper - cd on exit
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# homebrew shell auto-completion
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/doobdoob/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="ys"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git osx golang python autojump docker docker-compose
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR=vim

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# style the zsh
export TERM="xterm-256color"

# sanity check before using `rm *`
setopt RM_STAR_WAIT

# allow typing bash style comments on cmd
setopt interactivecomments

# enable spelling corrector
setopt CORRECT

### Vim ###
# use vim from MacVim instead. Note we install MacVim through
# http://macvim-dev.github.io/macvim/ instead of HomeBrew, which
# asks us to install a >5 GB full XCode stuff. Meanwhile this also
# means we have to update the vim manually (I should write a script
# for this)
MACVIM_HOME="/Applications/MacVim.app/Contents/bin"
export PATH=$MACVIM_HOME:$PATH
# note the real vi is not able to copy stuff to clipboard; Thus we need to point it to
# vim which is capable doing so
alias vi=$MACVIM_HOME/vim

### Python ###
# python shell tab-completion, osx doesn't provide this for free
export PYTHONSTARTUP="$HOME/.pythonrc"
# shortcut to start python shell in pipenv
alias prp="pipenv run python"
# pipenv setup: create virtual env in the same directory as the project so that
# the cleanup of virtual env becomes very trivial(only need to remove the
# project directory)
export PIPENV_VENV_IN_PROJECT=true

### Java ###
# Java development setup. See
# https://www.mkyong.com/java/how-to-set-java_home-environment-variable-on-mac-os-x/
# This makes the path to JDK of desired version available in current shell session
export JAVA_HOME=$(/usr/libexec/java_home -v 12.0)

### NodeJS ###
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### CommonLisp ###
# shortcut to start Clozure CL
export PATH=$HOME/bin:$PATH
alias ccl=$HOME/bin/ccl64

### Golang ###
# GOPATH
export GOPATH=~/workspace/go/hack
# make go project executables easy to access
export PATH=$PATH:$GOPATH/bin

# rbenv to manage ruby
eval "$(rbenv init -)"


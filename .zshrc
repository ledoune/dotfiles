# zsh options directories
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus

# zsh options history
HISTFILE=/home/doune/.zsh_history
HISTSIZE=10000
SAVEHIST=5000
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history

# style for completion -- exerpt from oh-my-zsh
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

source $HOME/.zplug/init.zsh

# self-manage for zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# aliases you should use
zplug "MichaelAquilina/zsh-you-should-use"
# command suggestion
zplug "zsh-users/zsh-autosuggestions"
bindkey '^ ' autosuggest-accept

# fuzzy directory completion
zplug "changyuheng/fz", defer:1
zplug "rupa/z", use:z.sh

# automatic pairing for brackets and others
zplug "hlissner/zsh-autopair", defer:2
# syntax highlight
zplug "zdharma/fast-syntax-highlighting", defer:2

# command history
zplug "zsh-users/zsh-history-substring-search", defer:3
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi

zplug load

path+=("$HOME/bin")
export PATH

eval "$(starship init zsh)"

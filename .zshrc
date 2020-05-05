# zsh options directories
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus

# zsh options history
HISTFILE=/home/doune/.zsh_history
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history

# style for completion -- exerpt from oh-my-zsh
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# additionnal key bindings
# if [[ "${terminfo[khome]}" != "" ]]; then
  # bindkey "${terminfo[khome]}" beginning-of-line      # [Home] - Go to beginning of line
# fi
# if [[ "${terminfo[kend]}" != "" ]]; then
  # bindkey "${terminfo[kend]}"  end-of-line            # [End] - Go to end of line
# fi
# if [[ "${terminfo[kdch1]}" != "" ]]; then
  # bindkey "${terminfo[kdch1]}" delete-char            # [Delete] - delete forward
# fi

source $HOME/.zplug/init.zsh

# self-manage for zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# aliases you should use
zplug "MichaelAquilina/zsh-you-should-use"
# command suggestion
zplug "zsh-users/zsh-autosuggestions"
bindkey '^ ' autosuggest-accept

# interactive git plugin
zplug "wfxr/forgit"
# git add commit push all in one command
zplug "robertzk/send.zsh"

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

path+=/home/doune/bin
export PATH
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# alias
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'

alias md='mkdir -p'
alias rd='rmdir'

alias l='exa -la --git'
alias ll='exa -l --git'
alias lt='exa -laT --level=2 --git'
alias llt='exa -lT --level=2 --git'
alias ldir='exa -laD --git'
alias lnew='exa -lasnew --git'

alias _='sudo '

alias h='fc -RI'
alias updt='trizen -Syu --noconfirm --noedit'

eval "$(starship init zsh)"

# ssh authentification using gpg key
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

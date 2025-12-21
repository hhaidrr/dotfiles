export EDITOR=vim
export PATH=$PATH:/usr/local/go/bin
export PATH="$PATH:$HOME/.local/python-3.12/bin"
# Created by `pipx` on 2025-10-27 17:22:40
export PATH="$PATH:/home/hamzah/.local/bin"

# Homebrew
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"

# pyenv initialization
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(starship init zsh)"

# Zinit plugin manager https://github.com/zdharma-continuum/zinit?tab=readme-ov-file#introduction
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Zinit plugins
zinit ice lucid proto=ssh; zinit light zsh-users/zsh-syntax-highlighting
zinit ice lucid proto=ssh; zinit light zsh-users/zsh-completions
zinit ice lucid proto=ssh; zinit light zsh-users/zsh-autosuggestions

zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::plugins/direnv

zinit ice wait"0" lucid atload"zicompinit; zicdreplay"
zinit light lukechilds/zsh-nvm

zinit ice wait"0" lucid as"program" pick"bin/pyenv" atinit'eval "$(pyenv init - zsh)"'
zinit light pyenv/pyenv

# autoload completions with daily cache
autoload -Uz compinit
if [ $(date +%j) != $(stat -c %y ~/.zcompdump 2>/dev/null | date +%j) ]; then
  compinit
else
  compinit -C # -C skips the slow security/validity check
fi
autoload -U +X bashcompinit && bashcompinit
#
# Enable completion caching
zinit cdreplay -q

zinit ice proto=ssh; zinit light Aloxaf/fzf-tab

complete -o nospace -C /usr/bin/terraform terraform


eval "$(fzf --zsh)"


bindkey -v
export KEYTIMEOUT=1
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line
bindkey '^?' backward-delete-char
#
# --- History Search Bindings ---

# 1. INSERT MODE (Ctrl+k and Ctrl+j)
bindkey -M viins '^K' history-beginning-search-backward
bindkey -M viins '^J' history-beginning-search-forward

# 2. NORMAL MODE (Standard j and k)
bindkey -M vicmd 'k' history-beginning-search-backward
bindkey -M vicmd 'j' history-beginning-search-forward

# 1. Use TAB to accept the gray auto-suggestion
# If there's no suggestion, it will act as a normal TAB (indent/complete)

# 2. Use Shift-Tab to open the completion menu
# Note: In many terminals, Shift-Tab sends the code '^[[Z'
bindkey '^I' autosuggest-accept
# Partial accept: Accept the next word of the suggestion
bindkey '^F' forward-word  # Ctrl + Space
bindkey '^[[Z' fzf-completion

# aliases
# zsh
alias s='source'
## Git 
alias gs='git status'
alias gc='git commit'
alias gch='git checkout'
alias gp='git push'
alias gpl='git pull'
alias gl='git log'
alias ga='git add'
alias gd='git diff'
alias gt='git tag'
alias gr='git restore'
alias gm='git merge'
alias gb='git blame'
alias gf='git fetch'
## Docker
alias d='docker'             # Docker command
alias dc='docker-compose'    # Docker-compose command
## Neovim
alias vi='nvim'
## tmux
alias tx='tmux'
alias txa='tmux attach'
## terraform
alias tf='terraform'

# Poetry
alias activate='eval $(poetry env activate)'

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups




# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/hamzah/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/hamzah/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/hamzah/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/hamzah/Downloads/google-cloud-sdk/completion.zsh.inc'; fi


zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# eval "$(zoxide init --cmd cd zsh)"

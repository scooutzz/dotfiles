# Options
setopt auto_cd
setopt extended_glob
setopt notify
setopt interactive_comments
setopt complete_in_word
setopt always_to_end
setopt auto_menu

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt hist_ignore_space
setopt share_history

# Completions
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then compinit; else compinit -C; fi
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' expand prefix suffix

# Environment & Paths
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

export PATH="$PATH:$HOME/.local/bin:$HOME/.local/share/relaxou/bin/"
source ~/.zsh_profile

# Fast Node Manager (fnm)
eval "$(fnm env --use-on-cd --shell zsh)"

# Sesh & Zsh Vi-Mode
function sesh-sessions() {
  local session
  session=$(
    sesh list --icons | fzf \
      --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
      --header '  ^a all ^t tmux ^g configs ^x zoxide ^f find' \
      --bind 'tab:down,btab:up' \
      --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
      --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
      --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
      --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
      --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
      --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
      --preview-window 'right:55%' \
      --preview 'sesh preview {}'
  )
  [[ -z "$session" ]] && return
  BUFFER="sesh connect \"$session\""
  zle accept-line
}
zle -N sesh-sessions

function zvm_config() {
  ZVM_LAZY_KEYBINDINGS=false
  ZVM_INIT_MODE=sourcing
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
}

function zvm_after_init() {
  bindkey '^R' history-incremental-search-backward
  bindkey '^f' sesh-sessions

  # Arrow keys in Insert Mode
  bindkey '^[[A' history-beginning-search-backward
  bindkey '^[OA' history-beginning-search-backward
  bindkey '^[[B' history-beginning-search-forward
  bindkey '^[OB' history-beginning-search-forward

  # 'k' and 'j' keys filtering by prefix in Normal Mode
  bindkey -M vicmd 'k' history-beginning-search-backward
  bindkey -M vicmd 'j' history-beginning-search-forward
}

# Tools Init & Starship
eval "$(zoxide init zsh)"

export STARSHIP_CONFIG="$HOME/.config/starship/minimal.toml"
eval "$(starship init zsh)"

# Plugin Manager
eval "$(sheldon source)"

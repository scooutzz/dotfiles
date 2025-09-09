# Oh My ZSH
export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="robbyrussell"

plugins=(
    git
    sudo
    history
    encode64
    zoxide
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$nvm_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Path Configuration
export PATH="$PATH:$HOME/.local/bin"

source ~/.zsh_profile

# Starship
eval "$(starship init zsh)"
# Zoxide
eval "$(zoxide init zsh)"

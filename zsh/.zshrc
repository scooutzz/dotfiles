# Oh My ZSH
export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="robbyrussell"

plugins=(
	git
	sudo
	history
	encode64
	zoxide
	vi-mode
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Path Configuration
export PATH="$PATH:$HOME/.local/bin:$HOME/.local/share/relaxou/bin/"

source ~/.zsh_profile

# Starship
export STARSHIP_CONFIG="$HOME/.config/starship/minimal.toml"
eval "$(starship init zsh)"

# Define the transient behavior
function zle-line-finish() {
	# Change the prompt to a minimal version when Enter is pressed
	PROMPT=$(starship module character)
	zle .reset-prompt
}
zle -N zle-line-finish

# Reset to full Starship prompt for the next line
function precmd() {
	PROMPT='$(starship prompt)'
}

# Zoxide
eval "$(zoxide init zsh)"

# bun completions
[ -s "/home/relaxou/.bun/_bun" ] && source "/home/relaxou/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

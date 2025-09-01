# Oh My ZSH
export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="robbyrussell"

plugins=(
	git
	sudo
	history
	encode64
	z
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Environment Variables
export PROJECTS="$HOME/Documents/Projects"
export ANDROID_HOME="$HOME/Android/Sdk"
export AND_STUDIO="/usr/locals/android-studio/bin"
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64"
export APPS="~/AppImages"
export PATH="$HOME/.local/kitty.app/bin:$PATH"

# Path Configuration
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/flutter/bin"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

source ~/.zsh_profile

# Starship
eval "$(starship init zsh)"

# opencode
export PATH=/home/relaxou/.opencode/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"

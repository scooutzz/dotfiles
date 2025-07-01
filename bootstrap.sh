#!/usr/bin/env bash

# Install TPM if missing
if [ ! -d "$HOME/.tmux/plugins/tpm" || -z "$(ls -A $HOME/.tmux/plugins/tpm)" ]; then
  echo "Cloning tpm..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  echo "TPM already installed."
fi

# Install plugins
echo "Installing tmux plugins..."
~/.tmux/plugins/tpm/bin/install_plugins

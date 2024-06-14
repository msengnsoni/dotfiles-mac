#!/bin/bash

# Set SCRIPT_DIR
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install from .Brewfile
brew bundle --file "${SCRIPT_DIR}/.bin/.Brewfile"

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting


for dotfile in "${SCRIPT_DIR}"/.bin/.??* ; do
  [[ "$dotfile" == "${SCRIPT_DIR}/.git" ]] && continue
  [[ "$dotfile" == "${SCRIPT_DIR}/.github" ]] && continue
  [[ "$dotfile" == "${SCRIPT_DIR}/.DS_Store" ]] && continue
  [[ "$dotfile" == "${SCRIPT_DIR}/.bin/.init.vim" ]] && continue
  ln -fnsv "$dotfile" "$HOME"
done

# Check nvim 
if [ ! -d "$HOME"/.config/nvim ]; then
  # Create neovim synbolic link
  mkdir "$HOME"/.config/nvim
  ln -fnsv "$SCRIPT_DIR"/.bin/.init.vim "$HOME"/.config/nvim/init.vim
fi

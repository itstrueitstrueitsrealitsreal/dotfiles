# Dotfiles 

## Overview

this repository that contains all my configuration files, with symlinks pointing from their actual locations (like `~/.config/nvim` → `~/dotfiles/configs/nvim`) to the repository.

## Repository Structure

```shell
~/dotfiles/
├── .git/
├── .gitignore
├── README.md
├── link.sh               # Script to create symlinks
├── configs/              # Files that go in ~/.config/
│   ├── nvim/
│   ├── tmux/
│   ├── fish/
│   ├── yabai/
│   ├── skhd/
│   ├── clangd/
│   └── zathura/
└── home/                 # Files that go directly in ~/
    ├── .zshrc
    ├── .gitconfig
    ├── .bashrc
    └── spaceship.zsh
```

## Migration Steps

1. **Create new repository structure**

   - Initialize `~/dotfiles` as a git repository
   - Create `configs/` directory for `~/.config/` files
   - Create `home/` directory for home directory dotfiles
   - Move existing configs from `.config/ruy/` to `~/dotfiles/configs/`

2. **Set up symlinks**

   - For each directory in `configs/`: `ln -sfn ~/dotfiles/configs/nvim ~/.config/nvim`
   - For each file in `home/`: `ln -sfn ~/dotfiles/home/.zshrc ~/.zshrc`

3. **Update .gitignore**

   - Keep existing ignore patterns from current `.gitignore`


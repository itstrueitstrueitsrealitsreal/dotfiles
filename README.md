# dotfiles 

## overview 

this repository that contains all my configuration files, with symlinks pointing from their actual locations (like `~/.config/nvim` → `~/dotfiles/config/nvim`) to the repository.

## repo structure

```shell
~/dotfiles/
├── .git/
├── .gitignore
├── README.md
├── link.sh               # used to create symlinked
├── config/              # Files that go in ~/.config/
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

## quick start
   - simply run `./link.sh` to:
      - link each directory in `config/` to `~/.config/`
      - link each directory in `home/` to `~`



# chezmoi-dotfiles

My personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).  
This repo helps me quickly bootstrap any new Mac or Linux environment with my preferred settings, themes, and tools.

## ✨ What’s Included

- `.zshrc`, `.p10k.zsh`, `.zprofile` – Zsh config and prompt setup
- `.gitconfig`, `.gitignore_global` – Git settings
- `.bashrc`, `.bash_profile` – Bash shell configs (legacy support)
- `.tmux.conf` – tmux configuration
- `.taskrc` – taskwarrior config
- Neovim: `~/.config/nvim/` – My custom Neovim LazyVim setup
- `nnn`, `htop`, `btop`, `neofetch`, and more

## ⚙️ Requirements

- [chezmoi](https://www.chezmoi.io/)
- macOS with Homebrew or Arch Linux (via yay/pacman)
- SSH key added to GitHub for push access

## 🚀 Quick Setup

To bootstrap a fresh machine:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)"
chezmoi init michael-j-morgan --ssh
chezmoi apply

# machine-setup

Minimal server bootstrap for your tmux and Neovim setup.

## What it does

- installs `tmux` and `neovim`
- backs up any existing `~/.tmux.conf` and `~/.config/nvim/init.vim`
- symlinks this repo's config files into place

## Quick start

If Git is already installed:

```bash
git clone <repo-url> ~/machine-setup && ~/machine-setup/install.sh
```

## Files

- `install.sh` - package install + symlink setup
- `tmux/tmux.conf` - tmux keybindings and pane controls
- `nvim/init.vim` - minimal Neovim config with movement and editing basics
- `shell/aliases.sh` - shell aliases for `t` and `v`

## Neovim keys kept

- `jj` and `jk` exit insert mode
- `Ctrl-h/j/k/l` move between splits
- `Tab` and `Shift-Tab` switch buffers
- `,w` saves
- `,q` quits

## tmux keys kept

- prefix is `Ctrl-f`
- `t` splits horizontally
- `g` splits vertically
- `h/j/k/l` move between panes
- `H/J/K/L` resize panes
- `Alt-f` toggles pane zoom

## Shell aliases

- `t` runs `tmux`
- `v` runs `nvim`

The installer symlinks `shell/aliases.sh` to `~/.machine-setup-aliases.sh` and sources it from both `~/.bashrc` and `~/.zshrc`.

## Notes

- Linux is the primary target; macOS support is included for local reuse.
- This repo uses symlinks so changes stay git-synced.
- For a curl bootstrap later, host a tiny script that clones this repo and runs `install.sh`.

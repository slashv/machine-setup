#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_TARGET="$HOME/.config/nvim/init.vim"
TMUX_TARGET="$HOME/.tmux.conf"
ALIASES_TARGET="$HOME/.machine-setup-aliases.sh"

log() {
  printf '[machine-setup] %s\n' "$1"
}

have_cmd() {
  command -v "$1" >/dev/null 2>&1
}

run_privileged() {
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  elif have_cmd sudo; then
    sudo "$@"
  else
    "$@"
  fi
}

backup_existing() {
  local target="$1"

  if [ -L "$target" ]; then
    rm -f "$target"
    return
  fi

  if [ -e "$target" ]; then
    local backup
    backup="${target}.bak.$(date +%Y%m%d%H%M%S)"
    mv "$target" "$backup"
    log "Backed up $target to $backup"
  fi
}

link_file() {
  local source="$1"
  local target="$2"

  mkdir -p "$(dirname "$target")"
  backup_existing "$target"
  ln -s "$source" "$target"
  log "Linked $target -> $source"
}

ensure_line_in_file() {
  local file="$1"
  local line="$2"

  touch "$file"

  if ! grep -Fqx "$line" "$file"; then
    printf '\n%s\n' "$line" >> "$file"
    log "Updated $file"
  fi
}

install_aliases() {
  link_file "$REPO_DIR/shell/aliases.sh" "$ALIASES_TARGET"

  ensure_line_in_file "$HOME/.bashrc" '[ -f "$HOME/.machine-setup-aliases.sh" ] && . "$HOME/.machine-setup-aliases.sh"'
  ensure_line_in_file "$HOME/.zshrc" '[ -f "$HOME/.machine-setup-aliases.sh" ] && . "$HOME/.machine-setup-aliases.sh"'
}

install_with_apt() {
  run_privileged env DEBIAN_FRONTEND=noninteractive apt-get update
  run_privileged env DEBIAN_FRONTEND=noninteractive apt-get install -y tmux neovim curl xclip
}

install_with_dnf() {
  run_privileged dnf install -y tmux neovim xclip
}

install_with_yum() {
  run_privileged yum install -y tmux neovim xclip
}

install_with_pacman() {
  run_privileged pacman -Sy --noconfirm tmux neovim xclip
}

install_with_brew() {
  brew install tmux neovim
}

install_packages() {
  if have_cmd apt-get; then
    install_with_apt
  elif have_cmd dnf; then
    install_with_dnf
  elif have_cmd yum; then
    install_with_yum
  elif have_cmd pacman; then
    install_with_pacman
  elif have_cmd brew; then
    install_with_brew
  else
    log "Unsupported package manager. Install tmux and neovim manually."
    return 1
  fi
}

main() {
  log "Installing tmux and neovim"
  install_packages

  link_file "$REPO_DIR/nvim/init.vim" "$NVIM_TARGET"
  link_file "$REPO_DIR/tmux/tmux.conf" "$TMUX_TARGET"
  install_aliases

  log "Done. Restart tmux or run: tmux source-file ~/.tmux.conf"
  log "Open a new shell or run: . ~/.machine-setup-aliases.sh"
}

main "$@"

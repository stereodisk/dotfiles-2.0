#!/bin/bash
set -e




RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_step()   { echo -e "${BLUE}==>${NC} ${GREEN}$1${NC}"; }
print_warning(){ echo -e "${YELLOW}==> WARNING:${NC} $1"; }
print_error() { echo -e "${RED}==> ERROR:${NC} $1"; }

print_step "Actualizando el sistema..."
sudo pacman -Syu --noconfirm

if ! command -v yay &>/dev/null; then
    print_step "Instalando yay..."
    sudo pacman -S --needed --noconfirm git base-devel
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
else
    print_step "yay ya esta instalado ✓"
fi

print_step "Instalando drivers Intel y energia..."
sudo pacman -S --needed --noconfirm \
    intel-ucode \
    mesa \
    vulkan-intel \
    intel-media-driver \
    libva-intel-driver \
    sof-firmware \
    tlp

sudo systemctl enable --now tlp

print_step "Instalando fuentes..."
sudo pacman -S --needed --noconfirm \
    ttf-nerd-fonts-symbols \
    ttf-nerd-fonts-symbols-mono \
    ttf-liberation \
    noto-fonts \
    noto-fonts-cjk \
    noto-fonts-emoji

yay -S --needed --noconfirm ttf-geist-mono-nerd || \
    print_warning "Geist Mono no disponible"

print_step "Instalando runtimes..."
sudo pacman -S --needed --noconfirm \
    python python-pip \
    clang \
    rust cargo \
    lua luarocks \
    go \
    jdk-openjdk \
    nodejs npm

print_step "Instalando terminal y shell..."
sudo pacman -S --needed --noconfirm \
    foot \
    fish \
    starship

print_step "Instalando editores..."
sudo pacman -S --needed --noconfirm \
    neovim \
    tree-sitter \
    tree-sitter-cli \
    vim \
    nano

print_step "Instalando Sway y core Wayland..."
sudo pacman -S --needed --noconfirm \
    sway \
    swaybg \
    swayidle \
    swaylock \
    waybar \
    wofi \
    xorg-xwayland \
    wl-clipboard \
    mako \
    grim \
    slurp \
    swappy \
    thunar \
    polkit-gnome

print_step "Instalando componentes AUR..."
yay -S --needed --noconfirm wlogout

print_step "Instalando PipeWire..."
sudo pacman -S --needed --noconfirm --overwrite '*' \
    pipewire \
    pipewire-pulse \
    pipewire-alsa \
    pipewire-jack \
    wireplumber \
    pavucontrol

systemctl --user enable --now pipewire.socket
systemctl --user enable --now pipewire-pulse.socket
systemctl --user enable --now wireplumber.service

print_step "Instalando red..."
sudo pacman -S --needed --noconfirm \
    networkmanager \
    nm-connection-editor
sudo systemctl enable --now NetworkManager

print_step "Instalando Bluetooth..."
sudo pacman -S --needed --noconfirm \
    bluez \
    bluez-utils \
    blueman
sudo systemctl enable --now bluetooth

print_step "Instalando utilidades..."
sudo pacman -S --needed --noconfirm \
    brightnessctl \
    btop \
    fzf \
    fd \
    bat \
    ripgrep \
    wget \
    unzip \
    zip \
    p7zip

print_step "Instalando aplicaciones..."
sudo pacman -S --needed --noconfirm qutebrowser
yay -S --needed --noconfirm obsidian python-adblock

print_step "¡Instalacion completada correctamente!"

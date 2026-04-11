#!/bin/bash
set -e

# Colores para la salida
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_step()   { echo -e "${BLUE}==>${NC} ${GREEN}$1${NC}"; }
print_warning(){ echo -e "${YELLOW}==> ADVERTENCIA:${NC} $1"; }

print_step "Actualizando el sistema..."
sudo pacman -Syu --noconfirm

# @AUR Helper (yay)
if ! command -v yay &>/dev/null; then
    print_step "Instalando yay (AUR helper)..."
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    cd -
fi

# @Drivers y Hardware
print_step "Instalando Drivers y Gestión de Energía (Intel)..."
sudo pacman -S --needed --noconfirm \
    intel-ucode mesa vulkan-intel intel-media-driver libva-intel-driver \
    sof-firmware tlp
sudo systemctl enable --now tlp

# @Fuentes
print_step "Instalando Fuentes..."
sudo pacman -S --needed --noconfirm \
    ttf-ibm-plex \
    ttf-liberation \
    noto-fonts noto-fonts-cjk noto-fonts-emoji \
    ttf-nerd-fonts-symbols-mono

# @Lenguajes y Runtimes
print_step "Instalando Runtimes y Lenguajes..."
sudo pacman -S --needed --noconfirm \
    python python-pip \
    clang \
    rust cargo \
    lua luarocks \
    go \
    nodejs npm \
    jdk-openjdk

# @Entorno de Ventanas (Sway)
print_step "Instalando Sway y componentes de interfaz..."
sudo pacman -S --needed --noconfirm \
    sway swaybg swayidle waybar fuzzel mako \
    xorg-xwayland wl-clipboard polkit-gnome \
    grim slurp swappy \
    brightnessctl papirus-icon-theme

# @Audio y Red
print_step "Instalando Audio y Red..."
sudo pacman -S --needed --noconfirm \
    pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber pavucontrol \
    networkmanager nm-connection-editor bluez bluez-utils blueman
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth

# @Terminal y Shell
print_step "Instalando Terminal, Shell y utilidades CLI..."
sudo pacman -S --needed --noconfirm \
    foot fish eza fzf fd bat ripgrep zoxide btop \
    wget unzip zip p7zip fortune-mod

# @Editores y Aplicaciones
print_step "Instalando Editores y Apps principales..."
sudo pacman -S --needed --noconfirm \
    neovim vim nano tree-sitter tree-sitter-cli \
    nautilus gvfs gvfs-mtp \
    imv mpv zathura zathura-pdf-mupdf oculante

# @AUR Packages
print_step "Instalando paquetes desde AUR..."
yay -S --needed --noconfirm \
    zen-browser-bin \
    swaylock-effects-git \
    eww-wayland-git \
    phinger-cursors \
    gtk-engine-murrine \
    wlogout \
    obsidian

# Shell
print_step "Configurando Fish como shell predeterminada..."
if [ "$SHELL" != "/usr/bin/fish" ]; then
    chsh -s /usr/bin/fish
fi

print_step "Instalacion completa, reinicia para aplicar cambios"

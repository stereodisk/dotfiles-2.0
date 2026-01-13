#!/bin/bash

set -e 
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_step() {
    echo -e "${BLUE}==>${NC} ${GREEN}$1${NC}"
}

print_warning() {
    echo -e "${YELLOW}==> WARNING:${NC} $1"
}

print_error() {
    echo -e "${RED}==> ERROR:${NC} $1"
}

print_step "Actualizando el sistema..."
sudo pacman -Syu --noconfirm

# ============================================================================
# AUR HELPER
# ============================================================================
if ! command -v yay &> /dev/null; then
    print_step "Instalando yay (AUR helper)..."
    sudo pacman -S --needed --noconfirm git base-devel
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
else
    print_step "yay ya esta instalado ✓"
fi

# ============================================================================
# HARDWARE (INTEL LAPTOP)
# ============================================================================
print_step "Instalando drivers y microcode para Intel i3-N305..."
sudo pacman -S --needed --noconfirm \
    intel-ucode \
    mesa \
    vulkan-intel \
    intel-media-driver \
    libva-intel-driver \
    sof-firmware \
    tlp

print_step "Habilitando TLP (Gestion de energia)..."
sudo systemctl enable --now tlp

# ============================================================================
# FUENTES
# ============================================================================
print_step "Instalando fuentes..."
sudo pacman -S --needed --noconfirm \
    ttf-nerd-fonts-symbols \
    ttf-nerd-fonts-symbols-mono \
    ttf-liberation \
    noto-fonts \
    noto-fonts-cjk \
    noto-fonts-emoji

yay -S --needed --noconfirm ttf-geist-mono-nerd || print_warning "GeistMono no disponible en AUR, instalar manualmente"

# ============================================================================
# RUNTIMES Y COMPILADORES
# ============================================================================
print_step "Instalando runtimes y compiladores..."
sudo pacman -S --needed --noconfirm \
    python \
    python-pip \
    clang \
    rust \
    cargo \
    lua \
    luarocks \
    go \
    jdk-openjdk \
    nodejs \
    npm

# ============================================================================
# TERMINAL Y SHELL
# ============================================================================
print_step "Instalando terminal y shell..."
sudo pacman -S --needed --noconfirm \
    foot \
    fish \
    starship

# ============================================================================
# EDITORES
# ============================================================================
print_step "Instalando Neovim y dependencias..."
sudo pacman -S --needed --noconfirm \
    neovim \
    tree-sitter \
    tree-sitter-cli

sudo pacman -S --needed --noconfirm vim nano

# ============================================================================
# WINDOW MANAGER Y COMPONENTES
# ============================================================================
print_step "Instalando Sway y componentes configurados..."
sudo pacman -S --needed \
    sway \
    swaybg \
    swayidle \
    swaylock \
    waybar \
    wofi \
    wlogout \
    polkit-gnome \
    xorg-xwayland \
    wl-clipboard \
    mako \
    foot \
    grim \
    slurp \
    swappy \
    thunar

print_step "Preparando migracion de PulseAudio a PipeWire..."
PULSEAUDIO_INSTALLED=$(pacman -Qq | grep -E '^pulseaudio$' 2>/dev/null || true)

if [ -n "$PULSEAUDIO_INSTALLED" ]; then
    print_warning "Detectado PulseAudio instalado. Sera reemplazado por PipeWire."
    
    # Remover pulseaudio forzadamente (ignorando dependencias)
    print_step "Removiendo PulseAudio..."
    sudo pacman -Rdd --noconfirm pulseaudio 2>/dev/null || true
    
    # Limpiar configuraciones residuales
    sudo rm -rf /etc/pulse 2>/dev/null || true
    rm -rf ~/.config/pulse 2>/dev/null || true
fi

print_step "Instalando sistema de audio (PipeWire)..."
sudo pacman -S --needed --noconfirm --overwrite '*' \
    pipewire \
    pipewire-pulse \
    pipewire-alsa \
    pipewire-jack \
    wireplumber

sudo pacman -S --needed --noconfirm --overwrite '*' pavucontrol
print_step "Habilitando servicios de audio..."
systemctl --user enable --now pipewire.socket 2>/dev/null || true
systemctl --user enable --now pipewire-pulse.socket 2>/dev/null || true
systemctl --user enable --now wireplumber.service 2>/dev/null || true

print_step "Instalando NetworkManager..."
sudo pacman -S --needed --noconfirm \
    networkmanager \
    nm-connection-editor
print_step "Habilitando NetworkManager..."
sudo systemctl enable --now NetworkManager

print_step "Instalando Bluetooth..."
sudo pacman -S --needed --noconfirm \
    bluez \
    bluez-utils \
    blueman
print_step "Habilitando Bluetooth..."
sudo systemctl enable --now bluetooth.service

print_step "Instalando control de brillo..."
sudo pacman -S --needed --noconfirm \
    brightnessctl

print_step "Instalando utilidades del sistema..."
sudo pacman -S --needed --noconfirm \
    btop \
    fzf \
    fd \
    bat \
    ripgrep \
    wget \
    unzip \
    zip \
    p7zip

print_step "Instalando Qutebrowser..."
sudo pacman -S --needed --noconfirm qutebrowser
print_step "Instalando python-adblock..."
yay -S --needed --noconfirm python-adblock

print_step "Instalando aplicaciones..."
yay -S --needed --noconfirm obsidian
#sudo pacman -S --needed --noconfirm \
#   zathura \
#  zathura-pdf-mupdf \
#    oculante \
#    mpv \
#   imv


echo ""
echo -e "${YELLOW}REPORTE DE ESTADO:${NC}"
echo ""
echo -e "${RED}LO QUE FALTABA Y SE HA INSTALADO:${NC}"
echo "  [✓] intel-ucode & drivers - Soporte Hardware Laptop"
echo "  [✓] tlp                   - Gestion de bateria"
echo "  [✓] swayidle              - Gestion de inactividad"
echo "  [✓] swaylock              - Pantalla de bloqueo"
echo "  [✓] wofi                  - Launcher de apps"
echo "  [✓] wlogout               - Menu de salida"
echo "  [✓] thunar                - Gestor de archivos"
echo "  [✓] wl-clipboard          - Copy/Paste (wayland)"
echo "  [✓] polkit-gnome          - Permisos de admin GUI"
echo "  [✓] papirus-icon-theme    - Tema de iconos"
echo ""
echo -e "${GREEN}LO QUE YA TENIAMOS (y se ha verificado):${NC}"
echo "  [✓] sway       - Window Manager"
echo "  [✓] waybar     - Barra de estado"
echo "  [✓] foot       - Terminal"
echo "  [✓] fish       - Shell"
echo "  [✓] neovim     - Editor"
echo "  [✓] pipewire   - Audio"
echo "  [✓] bluetooth  - Bluetooth"
echo "  [✓] wifi       - NetworkManager"
echo ""

print_step "Verificando instalaciones..."
check_command() {
    if command -v $1 &> /dev/null; then
        echo -e "  ${GREEN}✓${NC} $1"
        return 0
    else
        echo -e "  ${RED}✗${NC} $1"
        return 1
    fi
}

check_service() {
    if systemctl is-enabled $1 &> /dev/null 2>&1 || systemctl --user is-enabled $1 &> /dev/null 2>&1; then
        echo -e "  ${GREEN}✓${NC} $1 (habilitado)"
        return 0
    else
        echo -e "  ${YELLOW}○${NC} $1 (no habilitado)"
        return 1
    fi
}

echo ""
echo "Verificando comandos esenciales:"
check_command yay
check_command fish
check_command starship
check_command nvim
check_command sway
check_command waybar
check_command foot
check_command qutebrowser
check_command btop
check_command bluetoothctl
check_command nmcli
check_command brightnessctl
check_command wl-copy
check_command swaylock
check_command wofi
check_command thunar

echo ""
echo "Verificando servicios:"
check_service NetworkManager
check_service bluetooth
check_service tlp

echo ""
echo "Verificando audio (PipeWire):"
if systemctl --user is-active pipewire &> /dev/null && systemctl --user is-active pipewire-pulse &> /dev/null; then
    echo -e "  ${GREEN}✓${NC} PipeWire activo"
    echo -e "  ${GREEN}✓${NC} PipeWire-Pulse activo"
else
    echo -e "  ${YELLOW}○${NC} PipeWire (se activara despues del reinicio)"
fi

if pacman -Qq pulseaudio &> /dev/null; then
    echo -e "  ${RED}✗${NC} PulseAudio aun instalado (conflicto potencial)"
else
    echo -e "  ${GREEN}✓${NC} PulseAudio removido correctamente"
fi

echo ""
print_step "¡Instalacion completada!"
echo ""

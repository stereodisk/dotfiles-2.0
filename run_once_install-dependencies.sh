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

if ! command -v yay &> /dev/null; then
    print_step "Instalando yay (AUR helper)..."
    sudo pacman -S --needed --noconfirm git base-devel
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
else
    print_step "yay ya está instalado ✓"
fi

print_step "Instalando fuentes..."
sudo pacman -S --needed --noconfirm \
    ttf-nerd-fonts-symbols \
    ttf-nerd-fonts-symbols-mono

yay -S --needed --noconfirm ttf-geist-mono-nerd || print_warning "GeistMono no disponible en AUR, instalar manualmente"

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

print_step "Instalando terminal y shell..."
sudo pacman -S --needed --noconfirm \
    foot \
    fish \
    starship

print_step "Instalando Neovim y dependencias..."
sudo pacman -S --needed --noconfirm \
    neovim \
    tree-sitter \
    tree-sitter-cli

sudo pacman -S --needed --noconfirm vim nano

print_step "Instalando Sway y componentes configurados..."
sudo pacman -S --needed --noconfirm \
    sway \
    swaybg \
    waybar \
    foot \
    grim \
    slurp \
    swappy

print_step "Instalando sistema de audio..."
sudo pacman -S --needed --noconfirm \
    pipewire \
    pipewire-pulse \
    pipewire-alsa \
    pipewire-jack \
    wireplumber \
    pulseaudio \
    pavucontrol

print_step "Habilitando servicios de audio..."
systemctl --user enable --now pipewire.socket
systemctl --user enable --now pipewire-pulse.socket
systemctl --user enable --now wireplumber.service

print_step "Instalando utilidades del sistema..."
sudo pacman -S --needed --noconfirm \
    networkmanager \
    brightnessctl \
    btop \
    fzf \
    fd \
    bat \
    ripgrep \
    wget \
    unzip \
    zip

print_step "Habilitando NetworkManager..."
sudo systemctl enable --now NetworkManager

print_step "Instalando Qutebrowser..."
sudo pacman -S --needed --noconfirm qutebrowser

print_step "Instalando python-adblock..."
yay -S --needed --noconfirm python-adblock

print_step "Instalando aplicaciones..."
yay -S --needed --noconfirm obsidian
sudo pacman -S --needed --noconfirm \
    zathura \
    zathura-pdf-mupdf \
    oculante \
    mpv

print_step "Las herramientas LSP y formatters se instalarán automáticamente via Mason en Neovim"
print_warning "Al abrir Neovim por primera vez, espera a que se instalen los plugins y LSPs"

print_warning "Los siguientes componentes NO están instalados porque requieren configuración:"
echo ""
echo -e "${YELLOW}COMPONENTES PENDIENTES:${NC}"
echo "  [ ] wofi       - App launcher (requiere config + theme)"
echo "  [ ] mako       - Notificaciones (requiere config + theme)"
echo "  [ ] swayidle   - Gestión de energía (requiere config)"
echo "  [ ] swaylock   - Lockscreen (requiere config + theme)"
echo "  [ ] wlogout    - Menu de apagado (requiere config + theme)"
echo "  [ ] GTK theme  - Tema GTK para aplicaciones"
echo "  [ ] Cursor     - Tema de cursor"
echo "  [ ] Icons      - Pack de iconos"
echo "  [ ] wluma      - Brillo adaptativo (opcional)"
echo "  [ ] File Mgr   - Dolphin u otro (opcional)"
echo ""
echo -e "${BLUE}NOTA:${NC} Estos componentes se instalarán en la siguiente fase junto con sus configuraciones"
echo ""

print_step "Verificando instalaciones..."

check_command() {
    if command -v $1 &> /dev/null; then
        echo -e "  ${GREEN}✓${NC} $1"
    else
        echo -e "  ${RED}✗${NC} $1"
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

echo ""
print_step "¡Instalación completada!"
echo ""
echo -e "${YELLOW}SIGUIENTE PASO:${NC}"
echo "  1. Usa chezmoi para aplicar los dotfiles de configuración"
echo "  2. Cierra sesión y vuelve a entrar para aplicar fish como shell"
echo "  3. Inicia Sway desde TTY con el comando: sway"
echo "  4. Abre Neovim y espera a que se instalen los plugins"
echo ""
echo -e "${YELLOW}CONFIGURACIÓN PENDIENTE:${NC}"
echo ""
echo -e "${RED}COMPONENTES SIN CONFIGURAR (requieren dotfiles/setup):${NC}"
echo "  [ ] wofi       - App launcher"
echo "  [ ] mako       - Sistema de notificaciones"
echo "  [ ] swayidle   - Gestión de energía e hibernación"
echo "  [ ] swaylock   - Pantalla de bloqueo"
echo "  [ ] wlogout    - Menú de apagado"
echo "  [ ] GTK        - Tema para aplicaciones GTK"
echo "  [ ] Cursors    - Tema de cursor"
echo "  [ ] Icons      - Pack de iconos"
echo "  [ ] wluma      - Ajuste automático de brillo (NO INSTALADO)"
echo ""
echo -e "${GREEN}LISTO PARA USAR (ya configurados en dotfiles):${NC}"
echo "  [✓] sway       - Window manager"
echo "  [✓] waybar     - Status bar"
echo "  [✓] foot       - Terminal"
echo "  [✓] fish       - Shell"
echo "  [✓] starship   - Prompt"
echo "  [✓] neovim     - Editor"
echo "  [✓] qutebrowser- Browser"
echo ""
echo -e "${BLUE}TAREAS MANUALES:${NC}"
echo "  1. Configurar wallpaper en ~/.config/sway/wallpaper/wallpaper.conf"
echo "  2. Aplicar dotfiles con chezmoi"
echo "  3. Primera ejecución de Neovim (instalará LSPs vía Mason)"
echo "  4. Configurar componentes marcados como [ ]"
echo ""

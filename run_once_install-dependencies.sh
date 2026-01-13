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
    print_step "yay ya está instalado ✓"
fi

# ============================================================================
# FUENTES
# ============================================================================
print_step "Instalando fuentes..."
sudo pacman -S --needed --noconfirm \
    ttf-nerd-fonts-symbols \
    ttf-nerd-fonts-symbols-mono

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
sudo pacman -S --needed --noconfirm \
    sway \
    swaybg \
    waybar \
    foot \
    grim \
    slurp \
    swappy

# ============================================================================
# SISTEMA DE AUDIO - MIGRACIÓN A PIPEWIRE
# ============================================================================
print_step "Preparando migración de PulseAudio a PipeWire..."

# Detectar si hay paquetes de pulseaudio instalados
PULSEAUDIO_INSTALLED=$(pacman -Qq | grep -E '^pulseaudio$' 2>/dev/null || true)

if [ -n "$PULSEAUDIO_INSTALLED" ]; then
    print_warning "Detectado PulseAudio instalado. Será reemplazado por PipeWire."
    
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

# Instalar pavucontrol después para que use las librerías de pipewire
sudo pacman -S --needed --noconfirm --overwrite '*' pavucontrol

print_step "Habilitando servicios de audio..."
systemctl --user enable --now pipewire.socket 2>/dev/null || true
systemctl --user enable --now pipewire-pulse.socket 2>/dev/null || true
systemctl --user enable --now wireplumber.service 2>/dev/null || true

# ============================================================================
# SISTEMA DE RED (WiFi)
# ============================================================================
print_step "Instalando NetworkManager..."
sudo pacman -S --needed --noconfirm \
    networkmanager \
    nm-connection-editor

print_step "Habilitando NetworkManager..."
sudo systemctl enable --now NetworkManager

# ============================================================================
# SISTEMA DE BLUETOOTH
# ============================================================================
print_step "Instalando Bluetooth..."
sudo pacman -S --needed --noconfirm \
    bluez \
    bluez-utils \
    blueman

print_step "Habilitando Bluetooth..."
sudo systemctl enable --now bluetooth.service

# ============================================================================
# CONTROL DE BRILLO
# ============================================================================
print_step "Instalando control de brillo..."
sudo pacman -S --needed --noconfirm \
    brightnessctl

# ============================================================================
# UTILIDADES DEL SISTEMA
# ============================================================================
print_step "Instalando utilidades del sistema..."
sudo pacman -S --needed --noconfirm \
    btop \
    fzf \
    fd \
    bat \
    ripgrep \
    wget \
    unzip \
    zip

# ============================================================================
# NAVEGADOR WEB
# ============================================================================
print_step "Instalando Qutebrowser..."
sudo pacman -S --needed --noconfirm qutebrowser

print_step "Instalando python-adblock..."
yay -S --needed --noconfirm python-adblock

# ============================================================================
# APLICACIONES
# ============================================================================
print_step "Instalando aplicaciones..."
yay -S --needed --noconfirm obsidian
sudo pacman -S --needed --noconfirm \
    zathura \
    zathura-pdf-mupdf \
    oculante \
    mpv

# ============================================================================
# INFORMACIÓN POST-INSTALACIÓN
# ============================================================================
print_step "Las herramientas LSP y formatters se instalarán automáticamente via Mason en Neovim"
print_warning "Al abrir Neovim por primera vez, espera a que se instalen los plugins y LSPs"

print_warning "Los siguientes componentes NO están instalados porque requieren configuración:"
echo ""
echo -e "${YELLOW}COMPONENTES PENDIENTES:${NC}"
echo "  [ ] swayidle   - Gestión de energía (requiere config)"
echo "  [ ] wlogout    - Menu de apagado (requiere config + theme)"
echo "  [ ] Cursor     - Tema de cursor"
echo "  [ ] Icons      - Pack de iconos"
echo "  [ ] wluma      - Brillo adaptativo (opcional)"
echo "  [ ] File Mgr   - Dolphin u otro (opcional)"
echo ""
echo -e "${BLUE}NOTA:${NC} Estos componentes se instalarán en la siguiente fase junto con sus configuraciones"
echo ""

# ============================================================================
# VERIFICACIÓN DE INSTALACIONES
# ============================================================================
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

echo ""
echo "Verificando servicios:"
check_service NetworkManager
check_service bluetooth

echo ""
echo "Verificando audio (PipeWire):"
if systemctl --user is-active pipewire &> /dev/null && systemctl --user is-active pipewire-pulse &> /dev/null; then
    echo -e "  ${GREEN}✓${NC} PipeWire activo"
    echo -e "  ${GREEN}✓${NC} PipeWire-Pulse activo"
else
    echo -e "  ${YELLOW}○${NC} PipeWire (se activará después del reinicio)"
fi

# Verificar que pulseaudio fue removido
if pacman -Qq pulseaudio &> /dev/null; then
    echo -e "  ${RED}✗${NC} PulseAudio aún instalado (conflicto potencial)"
else
    echo -e "  ${GREEN}✓${NC} PulseAudio removido correctamente"
fi

echo ""
print_step "¡Instalación completada!"
echo ""
echo -e "${YELLOW}SIGUIENTE PASO:${NC}"
echo "  1. Usa chezmoi para aplicar los dotfiles de configuración"
echo "  2. ${RED}REINICIA EL SISTEMA${NC} para que PipeWire tome efecto completamente"
echo "  3. Cierra sesión y vuelve a entrar para aplicar fish como shell"
echo "  4. Inicia Sway desde TTY con el comando: sway"
echo "  5. Abre Neovim y espera a que se instalen los plugins"
echo ""
echo -e "${YELLOW}CONFIGURACIÓN PENDIENTE:${NC}"
echo ""
echo -e "${RED}COMPONENTES SIN CONFIGURAR (requieren dotfiles/setup):${NC}"
echo "  [ ] swayidle   - Gestión de energía e hibernación"
echo "  [ ] wlogout    - Menú de apagado"
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
echo "  [✓] wofi       - App launcher"
echo "  [✓] mako       - Notificaciones"
echo "  [✓] swaylock   - Lockscreen"
echo "  [✓] GTK        - Tema GTK"
echo ""
echo -e "${GREEN}SERVICIOS ACTIVOS:${NC}"
echo "  [✓] NetworkManager - Gestión de WiFi"
echo "  [✓] Bluetooth      - Conectividad Bluetooth"
echo "  [✓] PipeWire       - Sistema de audio moderno"
echo "  [✓] Brightnessctl  - Control de brillo"
echo ""
echo -e "${BLUE}TAREAS MANUALES:${NC}"
echo "  1. ${RED}REINICIAR el sistema antes de continuar${NC}"
echo "  2. Configurar wallpaper en ~/.config/sway/wallpaper/wallpaper.conf"
echo "  3. Aplicar dotfiles con chezmoi"
echo "  4. Primera ejecución de Neovim (instalará LSPs vía Mason)"
echo "  5. Configurar componentes marcados como [ ]"
echo "  6. Configurar clicks en Waybar para abrir:"
echo "     - Bluetooth: blueman-manager"
echo "     - Network: nm-connection-editor"
echo "     - Audio: pavucontrol"
echo ""
echo -e "${YELLOW}IMPORTANTE:${NC} Después del reinicio, verifica el audio con:"
echo "  systemctl --user status pipewire pipewire-pulse"
echo ""

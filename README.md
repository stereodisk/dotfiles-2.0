# DOTFILES
configuracion ordenada, minimalista y low-cost-performance con chezmoi para administrar la configuracion

# Instalacion
## Sistema
- yay: AUR helper
- pipewire: Interfaz para audio
- NetworkManager: Interfaz para wifi
- brightnessctl: Control de brillo
- tlp: Gestion de energia (bateria)
- pavucontrol: Control de volumen GUI
- xorg-xwayland: Compatibilidad con apps X11
- polkit-gnome: Autenticacion GUI

## Hardware (Intel)
- intel-ucode: Microcode
- vulkan-intel: Drivers Vulkan
- intel-media-driver: Aceleracion de video

## Fonts
- Nerdfonts: Necesarias para Starship y otros elementos de los dotfiles
- Noto Fonts: Soporte general de texto y emojis

## Runtimes
- python
- clang
- rust
- lua/luarocks
- go
- pip

## Terminal
- foot: Terminal ligera nativa de Wayland (mas ligera que kitty)
- Fish: Shell con autocompletions, highlighting y suggestions builtin-in
- Starship: Theme de los prompts de la shell
- Fisher: Manager de plugins de fish
    - Plugins: jethrokuan/z y patrickf1/fzf.fish

## Editor
- Neovim: Text editor principal
- Vim & Nano: Text editors basicos alternativos
### Editor: Neovim Plugins
Neovim trae una serie de plugins preconfigurados para una mejor experiencia.

## WM (Sway)
- Sway: wm ligero
- swaybg: componente de sway para wallpaper
- swayidle: componente para inactividad/hibernacion
- swaylock: pantalla de bloqueo
- waybar: barra superior
- wofi: app launcher
- wlogout: menu para apagar
- mako: notificaciones
- wl-clipboard: portapapeles (wl-copy/wl-paste)
- gtk-engine-murrine: Motor para themes personalizados de gtk
- papirus-icon-theme: Iconos

## Browser
- Qutebrowser: Browser minimalista ligero para uso diario
    - python-adblock: Adblocker

## Apps
- obsidian: Notas
- Thunar: File manager ligero
- Zathura: Lector de PDF
- Oculante: Visor de imagenes
- mpv: Reproductor de video
- imv: Visor de imagenes alternativo

## Extras
- fzf
- zoxide (via fish plugin 'z')
- fd
- bat
- treesitter
- wget 
- rg 
- unzip 
- zip 
- p7zip
- grim (screenshots)
- slurp (seleccion area)
- swappy (edicion screenshots)
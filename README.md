# Dotfiles
Una configuración minimalista para Sway WM enfocada en la estética **Frutiger Aero / Aqua Crystal**, optimizada para un bajo consumo de recursos (600-700MB en reposo) y alto rendimiento.

## Componentes Principales
*   **WM:** Sway (Wayland)
*   **Barra:** Waybar (transparente con gradientes)
*   **Terminal:** Foot (IBM Plex Mono)
*   **Shell:** Fish (Eza, Zoxide, Fzf)
*   **Lanzador:** Fuzzel (minimalista)
*   **Navegador:** Zen Browser
*   **Explorador de Archivos:** Nautilus (GTK4)
*   **Notificaciones:** Mako
*   **Widgets:** Eww (cat, senna, fortune)

## Instalación
Se utiliza **chezmoi** para gestionar la configuración, para ello sigue estos pasos:

1.  **Instalar chezmoi:**
    ```bash
    sh -c "$(curl -fsLS get.chezmoi.io)"
    ```
2.  **Aplicar dotfiles:**
    ```bash
    chezmoi init --apply https://github.com/tu-usuario/dotfiles.git
    ```
3.  **Instalar dependencias:**
    El script se ejecutará automáticamente tras el primer `chezmoi apply`, o puedes lanzarlo manualmente:
    ```bash
    ~/.local/share/chezmoi/run_once_install-dependencies.sh
    ```

## Atajos Principales
Super = ⊞
*   `Super + T` -> Abrir Terminal (Foot)
*   `Super + F` -> Abrir Navegador (Zen)
*   `Super + D` -> Abrir Archivos (Nautilus)
*   `Super + A` -> Lanzador de Apps (Fuzzel)
*   `Super + Esc` -> Bloquear pantalla (Swaylock-effects)
*   `Super + Q` -> Cerrar ventana activa
*   `Super + Shift + C` -> Recargar Sway
*   `Print` -> Captura de pantalla completa
*   `Super + Shift + S` -> Captura de área (slurp)

## Temas
*   **GTK:** Windows Longhorn Plex
*   **Iconos:** Adwaita / Papirus
*   **Cursores:** Phinger Cursors Dark
*   **Fuentes:** IBM Plex Mono / IBM Plex Sans

# to reload config -> source .config/fish/config.fish

# greetings
set -U fish_greeting

# PATH VARIABLES
set -Ux EDITOR nvim

# ALIASES
abbr q 'exit'
abbr n 'nvim'
abbr c 'clear'
abbr cdd 'cd ..'
abbr u 'sudo pacman -Syu'
abbr nvimconfig 'cd ~/.config/nvim'
abbr swayconfig 'cd ~/.config/sway'
abbr fishconfig 'cd ~/.config/foot'
abbr fishconfig 'nvim ~/.config/fish/config.fish'

# STARSHIP @Terminal Theme
starship init fish | source

# @Plugins
set -U fish_autosuggestion_strategy history
set -U fzf_complete 1
set -U fzf_preview_dir_cmd 'ls -la'

# WAYLAND & SWAY VARIABLES
set -Ux XDG_CURRENT_DESKTOP sway
set -Ux XDG_SESSION_DESKTOP sway
set -Ux XDG_SESSION_TYPE wayland
set -Ux GDK_BACKEND wayland,x11
#set -Ux QT_QPA_PLATFORM wayland;xcb
set -Ux SDL_VIDEODRIVER wayland
set -Ux CLUTTER_BACKEND wayland
set -Ux MOZ_ENABLE_WAYLAND 1
set -Ux _JAVA_AWT_WM_NONREPARENTING 1

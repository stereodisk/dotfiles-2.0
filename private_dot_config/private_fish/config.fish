if status is-login
  if test (tty) = /dev/tty1
    exec sway
  end
end

# @Greetings
set -U fish_greeting

# @Alias 
alias ls 'eza -l --icons'

# @Abbreviatures
abbr q 'exit'
abbr n 'nvim'
abbr c 'clear'
abbr cdd 'cd ..'
abbr u 'sudo pacman -Syu'
abbr nvimconfig 'cd ~/.config/nvim'
abbr swayconfig 'cd ~/.config/sway'
abbr waybarconfig 'cd ~/.config/waybar/'
abbr fuzzelconfig 'cd ~/.config/fuzzel/'
abbr makoconfig 'nvim ~/.config/mako/config'
abbr footconfig 'nvim ~/.config/foot/foot.ini'
abbr fishconfig 'nvim ~/.config/fish/config.fish'

# @Plugins
set -U fish_autosuggestion_strategy history
set -U fzf_complete 1
set -U fzf_preview_dir_cmd 'ls -la'

set -Ux EDITOR nvim
set -Ux TERMINAL foot
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1

# @WAYLAND & SWAY VARIABLES
set -Ux XDG_CURRENT_DESKTOP sway
set -Ux XDG_SESSION_DESKTOP sway
set -Ux XDG_SESSION_TYPE wayland
set -Ux GDK_BACKEND wayland,x11
set -Ux CLUTTER_BACKEND wayland
set -Ux MOZ_ENABLE_WAYLAND 1
set -Ux LIBVA_DRIVER_NAME iHD
set -Ux GST_VAAPI_ALL_DRIVERS 1
set -Ux NODE_OPTIONS "--no-warnings"
set -Ux PREFER_LOW_POWER 1
set -Ux QT_QPA_PLATFORM "wayland;xcb"
set -Ux _JAVA_AWT_WM_NONREPARENTING 1
set -Ux GRIM_DISABLE_DMABUF 1
set -Ux SDL_VIDEODRIVER wayland

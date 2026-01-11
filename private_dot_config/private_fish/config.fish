# to reload config -> source .config/fish/config.fish

# greetings
set -U fish_greeting

# PATH VARIABLES
set -Ux EDITOR nvim

# ALIASES
abbr q 'exit'
abbr c 'clear'
abbr u 'sudo pacman -Syu'
abbr cdd 'cd ..'
abbr nvimconfig 'cd ~/.config/nvim'
abbr fishconfig 'nvim ~/.config/fish/config.fish'

# STARSHIP @Terminal Theme
starship init fish | source

#######################################################
#   ____  _____ ____  
#  |  _ \| ____| __ )  Autor: 
#  | |_) |  _| |  _ \  Patricio Echagüe Ballesteros
#  |  __/| |___| |_) | Descripción:
#  |_|   |_____|____/  ~/.config/fish/config.fish
#
#######################################################

# Solo ejecutar en sesiones interactivas
if status is-interactive

    set -g fish_greeting
    
    #######################################################
    # Variables de entorno
    #######################################################
    
    # Detectar el ID del usuario actual
    set -gx USER_ID (id -u)

    # Configurar el entorno para Wayland/KDE
    set -gx XDG_RUNTIME_DIR "/run/user/$USER_ID"
    set -gx DBUS_SESSION_BUS_ADDRESS "unix:path=$XDG_RUNTIME_DIR/bus"
    
    # Añadir al PATH
    fish_add_path /home/patricioeb/.local/bin

    # Configuración de Ruby / Gemas para Jekyll
    if type -q gem
        set -l gem_user_bin (gem env user_gemhome)/bin
        if not contains $gem_user_bin $PATH
            set -gx PATH $gem_user_bin $PATH
        end
    end
    
    set -gx EDITOR fresh
    set -gx TERMINAL kitty
    set -gx BROWSER zen-browser
    
    #######################################################
    # Configuración FZF
    #######################################################
    if type -q fzf
        set -gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS \
          --info=inline-right \
          --ansi \
          --layout=reverse \
          --border=rounded \
          --color=border:#27a1b9 \
          --color=fg:#c0caf5 \
          --color=gutter:#16161e \
          --color=header:#ff9e64 \
          --color=hl+:#2ac3de \
          --color=hl:#2ac3de \
          --color=info:#545c7e \
          --color=marker:#ff007c \
          --color=pointer:#ff007c \
          --color=prompt:#2ac3de \
          --color=query:#c0caf5:regular \
          --color=scrollbar:#27a1b9 \
          --color=separator:#ff9e64 \
          --color=spinner:#ff007c"
          
        # Habilitar bindings nativos de FZF para Fish
        fzf --fish | source
    end

    #######################################################
    # Abbreviations
    #######################################################
    abbr -a ed $EDITOR
    abbr -a tg topgrade -y
    abbr -a st speedtest++
    abbr -a ff fastfetch
    abbr -a bt btop
    abbr -a red nmtui

    #######################################################
    # Aliases
    #######################################################
    alias cls='clear'
    alias le='eza -aF --icons --sort=ext --grid --width=80 --group-directories-first'
    alias lz='eza -lahF --git --icons --sort=ext'
    alias grep='grep --color=auto'
    alias gitout='/home/patricioeb/.local/bin/gitout.sh'
    alias iploc="ip -br -c a"
    alias ippub="curl -s ifconfig.me && echo"

end

#######################################################
# Función Yazi (Traducida a la sintaxis de Fish)
#######################################################
function yz
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if test -f "$tmp"
        set cwd (cat -- "$tmp")
        if test -n "$cwd"; and test "$cwd" != "$PWD"
            cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end
end

#######################################################
# Función zoxide
#######################################################
zoxide init fish | source
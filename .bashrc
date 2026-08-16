#######################################################
#   ____  _____ ____  
#  |  _ \| ____| __ )  Autor: 
#  | |_) |  _| |  _ \  Patricio Echagüe Ballesteros
#  |  __/| |___| |_) | Descripción:
#  |_|   |_____|____/  ~/.bashrc
#
#######################################################

# ble.sh (auto completion)
[[ $- == *i* ]] && source -- ~/.local/share/blesh/ble.sh --attach=none

export EDITOR='nano'

# Exportar el bus de datos de la sesión del usuario actual
# Detectar el ID del usuario actual
USER_ID=$(id -u)

# Configurar el entorno para Wayland/KDE
export XDG_RUNTIME_DIR="/run/user/$USER_ID"
export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
export PATH="$PATH:/home/patricioeb/.local/bin"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias cls='clear'
alias tg='topgrade -y'
alias st='speedtest'
alias ff='fastfetch'
alias bt='btop'
alias ls='eza -aF --icons --sort=ext --grid --width=80 --group-directories-first'
alias lz='eza -lahF --git --icons --sort=ext'
alias ..='cd ..'
alias red='nmtui'

alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

# Oh-My-Posh Config
eval "$(oh-my-posh init bash --config $HOME/.config/ohmyposh/xero.omp.json)"

# Importa los módulos de integración de fzf (con -d para cargarlos en segundo plano)
ble-import -d integration/fzf-completion
ble-import -d integration/fzf-key-bindings

# ble.sh
[[ ${BLE_VERSION-} ]] && ble-attach

# fzf
# eval "$(fzf --bash)"

#Yazi
function yz() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Fastfetch on terminal start
# clear && fastfetch


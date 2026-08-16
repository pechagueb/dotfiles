#######################################################
#   ____  _____ ____  
#  |  _ \| ____| __ )  Autor: 
#  | |_) |  _| |  _ \  Patricio Echagüe Ballesteros
#  |  __/| |___| |_) | Descripción:
#  |_|   |_____|____/  ~/.zshrc
#
#######################################################

#######################################################
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#######################################################
# Variables de entorno
#######################################################

# Detectar el ID del usuario actual
USER_ID=$(id -u)

# Configurar el entorno para Wayland/KDE
export XDG_RUNTIME_DIR="/run/user/$USER_ID"
export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
export PATH="$PATH:/home/patricioeb/.local/bin"

export EDITOR=nano
export TERMINAL=kitty
export BROWSER=zen-browser

export ZSH="$HOME/.oh-my-zsh"

# Configuración FZF
if [[ -x "$(command -v fzf)" ]]; then
	export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
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
	  --color=spinner:#ff007c \
	"
fi

#######################################################
# Tema Oh My Zsh 
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

#######################################################
# Aliases
#######################################################

alias cls='clear'
alias tg='topgrade -y'
alias st='speedtest'
alias ff='fastfetch'
alias bt='btop'
alias le='eza -aF --icons --sort=ext --grid --width=80 --group-directories-first'
alias lz='eza -lahF --git --icons --sort=ext'
alias red='nmtui'
alias grep='grep --color=auto'
alias gitout='/home/patricioeb/.local/bin/gitout.sh' # Actualiza local a github

alias iploc="ip -br -c a" # IP local
alias ippub="curl -s ifconfig.me && echo" # IP pública


#######################################################
# Inicializar el sistema de autocompletado nativo de ZSH
autoload -Uz compinit
compinit -i  # Añadimos -i para ignorar directorios inseguros y que no se bloquee

# Menú visual con selección de flechas
zstyle ':completion:*' menu select

#######################################################
# Yazi
function yz() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

#######################################################
# Opciones básicas ZSH (https://github.com/CodeOpsHQ/dotfiles/blob/main/.zshrc)
#######################################################

setopt autocd              # change directory just by typing its name
setopt correct             # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

#######################################################
# Mapeo de teclas específico para la terminal Kitty/Zsh
bindkey '^[[H'      beginning-of-line  # Tecla Inicio
bindkey '^[[F'      end-of-line        # Tecla Fin
bindkey '^[[3~'     delete-char        # Tecla Suprimir

# Atajos adicionales muy útiles en Kitty/Zsh
bindkey '^[[1;5D'   backward-word      # Ctrl + Flecha Izquierda (Saltar palabra atrás)
bindkey '^[[1;5C'   forward-word       # Ctrl + Flecha Derecha (Saltar palabra adelante)

#######################################################
# Configuración del Historial de Comandos
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Opciones extra para un historial inteligente (opcional pero muy recomendado)
setopt APPEND_HISTORY          # Añade comandos al historial en lugar de sobrescribir el archivo
setopt SHARE_HISTORY           # Comparte el historial entre todas las pestañas de Kitty en tiempo real
setopt HIST_IGNORE_ALL_DUPS    # Si repites un comando, borra el duplicado anterior para no llenar el historial
setopt HIST_REDUCE_BLANKS      # Elimina espacios en blanco innecesarios en los comandos guardados


#######################################################
# oh-my-zsh
plugins=(git)

source $ZSH/oh-my-zsh.sh

#######################################################
# zsh-autosuggestions plugin
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'

#######################################################
# zsh-syntax-highlighting plugin
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#######################################################
# Integración nativa de fzf en Zsh (ACTIVADA)
source <(fzf --zsh)

#######################################################
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

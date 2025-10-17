#!/usr/bin/env bash
# Omarchy menu (Rofi) — foco no menu "Install" com main menu e navegação de volta

set -euo pipefail

# Opcional: manter compat com seus binários omarchy
export PATH="$HOME/.local/share/omarchy/bin:$PATH"

# Tema do Rofi
THEME="${HOME}/.config/rofi/applets/menu.rasi"

# Se já existe um Rofi aberto, fecha (mesmo padrão do seu cliphist)
if pidof rofi >/dev/null; then
	pkill rofi
fi

# Quando invocado direto num submenu, cancelar sai do script (em vez de voltar)
BACK_TO_EXIT=false

# -------------------- Helpers de UI --------------------

# menu(prompt, options, [extra], [preselect])
# - options: string com \n entre itens (pode incluir glifos Nerd Font)
# - extra: suporta "-w N" (largura) e será mapeado via -theme-str
# - preselect: texto de uma linha para pré-selecionar
# Retorno:
# - ecoa a linha escolhida
# - se cancelar: ecoa "CNCLD" e retorna 1
# - se Alt+Left: ecoa "BACK" e retorna 10
menu() {
	local prompt="$1"
	local options="$2"
	local extra="${3:-}"
	local preselect="${4:-}"

	local -a args=(-i -dmenu -p "$prompt" -theme "$THEME" -kb-custom-1 "Alt-Left")

	# Suporte simples a largura (-w N)
	if [[ "$extra" =~ -w[[:space:]]+([0-9]+) ]]; then
		local w="${BASH_REMATCH[1]}"
		args+=(-theme-str "window { width: ${w}px; }")
	fi

	# Pré-seleção 1-based -> 0-based
	if [[ -n "$preselect" ]]; then
		local idx
		idx=$(printf "%b" "$options" | grep -nxF "$preselect" | cut -d: -f1 || true)
		if [[ -n "${idx:-}" ]]; then
			args+=(-selected-row "$(( idx - 1 ))")
		fi
	fi

	local selection
	selection="$(printf "%b" "$options" | rofi "${args[@]}")"
	local code=$?

	case "$code" in
		0)  printf '%s' "$selection"; return 0 ;;
		1)  printf '%s' "CNCLD"; return 1 ;;
		10) printf '%s' "BACK";  return 10 ;;
		*)  printf '%s' "CNCLD"; return "$code" ;;
	esac
}

# -------------------- Helpers de execução --------------------

terminal() {
	# Ajuste seu terminal preferido se necessário
	# alacritty --class=Omarchy -e "$@"
	kitty -e --class=relaxou "$@"
}

present_terminal() {
	# Mantém compat com seu script original
	launch-floating-terminal-with-presentation "$1"
}

open_in_editor() {
	notify-send "Editing config file" "$1"
	omarchy-launch-editor "$1"
}

install() {
	present_terminal "echo 'Installing $1...'; sudo pacman -S --noconfirm $2"
}

install_and_launch() {
	present_terminal "echo 'Installing $1...'; sudo pacman -S --noconfirm $2 && setsid gtk-launch $3"
}

install_font() {
	present_terminal "echo 'Installing $1...'; sudo pacman -S --noconfirm --needed $2 && sleep 2 && omarchy-font-set '$3'"
}

install_terminal() {
	present_terminal "omarchy-install-terminal $1"
}

aur_install() {
	present_terminal "echo 'Installing $1 from AUR...'; yay -S --noconfirm $2"
}

aur_install_and_launch() {
	present_terminal "echo 'Installing $1 from AUR...'; yay -S --noconfirm $2 && setsid gtk-launch $3"
}

# -------------------- Navegação (voltar) --------------------

back_to() {
	local parent_menu="${1:-}"
	if [[ "$BACK_TO_EXIT" == "true" ]]; then
		exit 0
	elif [[ -n "$parent_menu" ]]; then
		"$parent_menu"
	else
		show_main_menu
	fi
}

# -------------------- Menus --------------------

show_main_menu() {
	local sel
	sel="$(menu "Go" $'󰉉 Install\n󰭌  Remove\n  About')" || true

	case "${sel,,}" in
		*install*) show_install_menu ;;
		*remove*) show_remove_menu ;;
		*about*) launch-about ;;
		cncld|back|"")
			# Esc/Alt+Left no main encerra
			exit 0
			;;
		*)
			show_main_menu
			;;
	esac
}

show_install_menu() {
	local sel
	sel="$(menu "Install" $'󰣇  Package\n󰣇  AUR\n  Web App\n  TUI\n  Style')" || true

	case "$sel" in
		*Package*)     terminal pkg-install ;;
		*AUR*)         terminal pkg-aur-install ;;
		*Web*)         present_terminal webapp-install ;;
		*TUI*)         present_terminal tui-install ;;
		*Style*)       show_install_style_menu ;;
		CNCLD|BACK|"") back_to show_main_menu ;;
		*)             show_install_menu ;;
	esac
}

show_remove_menu() {
	local sel
	sel=$(menu "Remove" "󰣇  Package\n  Web App\n  TUI")

	case "$sel" in
		*Package*) terminal pkg-remove ;;
		*Web*) present_terminal webapp-remove ;;
		*TUI*) present_terminal tui-remove ;;
		*) show_main_menu ;;
	esac
}

show_install_style_menu() {
	local sel
	sel="$(menu "Install" $'󰸌  Theme\n  Background\n  Font')" || true

	case "$sel" in
		*Theme*)      present_terminal omarchy-theme-install ;;
		*Background*) nautilus ~/.config/omarchy/current/theme/backgrounds ;;
		*Font*)       show_install_font_menu ;;
		CNCLD|BACK|"") show_install_menu ;;
		*)            show_install_style_menu ;;
	esac
}

# -------------------- Router --------------------

go_to_menu() {
	case "${1,,}" in
		*install*) show_install_menu ;;
		*remove*) show_remove_menu ;;
		# Demais entradas ainda não migradas; pode expandir aqui
		*apps*|*learn*|*trigger*|*style*|*setup*|*update*|*about*|*system*)
		show_main_menu
		;;
	*) show_main_menu ;;
esac
}

# -------------------- Entry point --------------------

if [[ -n "${1:-}" ]]; then
	BACK_TO_EXIT=true
	go_to_menu "$1"
else
	show_main_menu
fi

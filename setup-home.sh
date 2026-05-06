#! /bin/zsh
set -euo pipefail

echo "Starting Zsh prompt setup: going to install oh-my-zsh and Powerlevel10k and other necessary pieces\n"

font_home=${HOME}/.local/share/fonts
omz_home=${HOME}/.oh-my-zsh
omz_plugins=$omz_home/custom/plugins
omz_themes=$omz_home/custom/themes

fonts_added=0

if [[ -e $font_home/MesloLGS_NF_Regular.ttf && -e $font_home/MesloLGS_NF_Bold.ttf && -e $font_home/MesloLGS_NF_Italic.ttf && -e $font_home/MesloLGS_NF_Bold_Italic.ttf ]]; then
    echo "Found the patched MesloLGS NF fonts in $font_home"
else
    echo "Downloading Powerlevel10k patched MesloLGS NF fonts..."
    mkdir -p $font_home
    curl -fLo $font_home/MesloLGS_NF_Regular.ttf    https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
    curl -fLo $font_home/MesloLGS_NF_Bold.ttf        https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
    curl -fLo $font_home/MesloLGS_NF_Italic.ttf      https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
    curl -fLo $font_home/MesloLGS_NF_Bold_Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
    fonts_added=1
fi

echo ""

# Noto Sans Symbols 2 covers Unicode Miscellaneous Technical (U+2300-U+23FF),
# filling gaps in MesloLGS NF — e.g. U+23F5 used by the Claude Code TUI.
if [[ -e $font_home/NotoSansSymbols2-Regular.ttf ]]; then
    echo "Found NotoSansSymbols2 in $font_home"
else
    echo "Downloading Noto Sans Symbols 2..."
    mkdir -p $font_home
    curl -fLo $font_home/NotoSansSymbols2-Regular.ttf \
        https://github.com/googlefonts/noto-fonts/raw/main/hinted/ttf/NotoSansSymbols2/NotoSansSymbols2-Regular.ttf
    fonts_added=1
fi

if (( fonts_added )); then
    echo "\nRebuilding font cache..."
    fc-cache -f
fi

echo ""

if [[ ! -d $omz_home ]]; then
    echo "Going to install oh-my-zsh..."
    git clone https://github.com/ohmyzsh/ohmyzsh.git $omz_home
else
    echo "Found oh-my-zsh installation at $omz_home"
fi

echo ""


if [[ ! -d "$omz_plugins/zsh-completions" ]]; then
    echo "Going to install zsh-completions..."
    git clone https://github.com/zsh-users/zsh-completions "$omz_plugins/zsh-completions"
else
    echo "Found zsh-completions at $omz_plugins/zsh-completions"
fi

echo ""

if [[ ! -d "$omz_themes/powerlevel10k" ]]; then
    echo "Going to install Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$omz_themes/powerlevel10k"
else
    echo "Found Powerleve10k installation at $omz_themes/powerlevel10k"
fi

echo ""

DOTFILES=$(cd "$(dirname "$0")" && pwd)

echo "Linking config files..."

ln -sf "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf"
echo "  ~/.tmux.conf"

mkdir -p "$HOME/.config/nvim"
ln -sf "$DOTFILES/.config/nvim/init.lua" "$HOME/.config/nvim/init.lua"
echo "  ~/.config/nvim/init.lua"

echo ""
echo "Done"

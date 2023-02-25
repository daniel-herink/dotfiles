#! /bin/zsh

echo "Starting Zsh prompt setup: going to install oh-my-zsh and Powerlevel10k and other necessary pieces\n"

local font_home=${HOME}/.local/share/fonts
local omz_home=${HOME}/.oh-my-zsh
local zsh_256color_home=$omz_home/custom/plugins/zsh-256color
local p10k_home=$omz_home/custom/themes/powerlevel10k

if [[ -e $font_home/MesloLGS_NF_Regular.ttf && -e $font_home/MesloLGS_NF_Bold.ttf && -e $font_home/MesloLGS_NF_Regular.ttf && -e $font_home/MesloLGS_NF_Bold_Italic.ttf ]]; then
    echo "Found the patched MesloLGS NF fonts in $font_home"
else
    echo "Downloading Powerlevel10k patched MesloLGS NF fonts..."
    mkdir -p $font_home
    curl -o $font_home/MesloLGS_NF_Regular.ttf -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
    curl -o $font_home/MesloLGS_NF_Bold.ttf -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
    curl -o $font_home/MesloLGS_NF_Italic.ttf -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
    curl -o $font_home/MesloLGS_NF_Bold_Italic.ttf -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
    echo "\nRebuilding fonts..."
    fc-cache -f -v
fi

echo ""

if [[ ! -d $omz_home ]]; then
    echo "Going to install oh-my-zsh..."
    git clone https://github.com/ohmyzsh/ohmyzsh.git $omz_home
else
    echo "Found oh-my-zsh installation at $omz_home"
fi

echo ""

if [[ ! -d $zsh_256color_home ]]; then
    echo "Going to install zsh-256color..."
    git clone https://github.com/chrissicool/zsh-256color $zsh_256color_home
else
    echo "Found zsh-256color installation at $zsh_256color_home"
fi

echo ""

if [[ ! -d $p10k_home ]]; then
    echo "Going to install Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $p10k_home
else
    echo "Found Powerleve10k installation at $p10k_home"
fi

echo "\nCleaning up the unneeded Git files"
rm -rf LICENSE .git/
echo "Done"

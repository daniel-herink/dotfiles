#! /bin/zsh

echo "Starting Zsh prompt setup: going to install oh-my-zsh and Powerlevel10k"

local omz_home=${HOME}/.oh-my-zsh
local zsh_256color_home=$omz_home/custom/plugins/zsh-256color
local p10k_home=$omz_home/custom/themes/powerlevel10k

if [[ ! -d $omz_home ]]; then
    echo "Going to install oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Found oh-my-zsh installation at $omz_home"
fi

if [[ ! -d $zsh_256color_home ]]; then
    echo "Going to install zsh-256color..."
    git clone https://github.com/chrissicool/zsh-256color $zsh_256color_home
else
    echo "Found zsh-256color installation at $zsh_256color_home"
fi

if [[ ! -d $p10k_home ]]; then
    echo "Going to install Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $p10k_home
else
    echo "Found Powerleve10k installation at $p10k_home"
fi

echo "Cleaning up the unneeded Git files"
rm -rf LICENSE .git/
echo "Done"

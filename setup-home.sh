#! /bin/zsh

echo "Starting Zsh prompt setup: going to install oh-my-zsh and Powerlevel10k and other necessary pieces\n"

font_home=${HOME}/.local/share/fonts
omz_home=${HOME}/.oh-my-zsh
omz_plugins=$omz_home/custom/plugins
omz_themes=$omz_home/custom/themes

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

if [[ ! -d "$omz_plugins/zsh-256color" ]]; then
    echo "Going to install zsh-256color..."
    git clone https://github.com/chrissicool/zsh-256color "$omz_plugins/zsh-256color"
else
    echo "Found zsh-256color installation at $omz_plugins/zsh-256color"
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
echo "Done"

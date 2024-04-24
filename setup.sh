cp -r zsh/.zsh ~
cat zsh/.zshrc > ~/.zshrc

# install

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# zsh
sudo apt install zsh
chsh -s $(which zsh)

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# Neovim
brew install neovim

git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim

# Windows WSL
if command -v powershell.exe &> /dev/null; then
  cat wsl.ps1 | powershell.exe -Command -
fi

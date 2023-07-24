Install HomeBrew (brew.sh)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

Install oh-my-zsh and cobalt2 theme
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -o ~/.oh-my-zsh/themes/cobalt2.zsh-theme /https://raw.githubusercontent.com/wesbos/Cobalt2-iterm/b3a40ad59f907c9d290aba8d7c7d18434aa9d662/cobalt2.zsh-theme

Install and configure yadm
brew install yadm
yadm clone https://github.com/etherwrangler/dotfiles.git

Install packages and configure shell
brew bundle
source ~/.zshrc

Setup SSH Keys for GitHub
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_github -C "your@email.here"
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519 #on macos
pbcopy < ~/.ssh/id_ed25519_github.pub #on macos
cat ~/.ssh/id_ed25519_github.pub #on wsl2 / linux

Change yadm to use SSH instead of https
yadm remote set-url origin git@github.com:etherwrangler/dotfiles.git
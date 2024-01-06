
EtherWrangler's dotfiles
========================
Here you can find my dotfiles.  Feel free to fork and change all you'd like.  If you use this without forking, keep in mind whenever you ```yadm pull``` that your .gitconfig file might/will end up with my name in it depending on how you handle that.

Setup for MacOS (Might be incomplete)
-------------------------------------
Install HomeBrew (brew.sh)
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install oh-my-zsh, cobalt2 theme, yadm, and software
```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -o ~/.oh-my-zsh/themes/cobalt2.zsh-theme /https://raw.githubusercontent.com/wesbos/Cobalt2-iterm/b3a40ad59f907c9d290aba8d7c7d18434aa9d662/cobalt2.zsh-theme

brew install yadm
yadm clone https://github.com/etherwrangler/dotfiles.git
# might need a _yadm restore ._ here

brew bundle
source ~/.zshrc
```

Setup SSH Keys for GitHub
```shell
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_github -C "your@email.here"
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519 #on macos
pbcopy < ~/.ssh/id_ed25519_github.pub #on macos
cat ~/.ssh/id_ed25519_github.pub #on wsl2 / linux
```

Change yadm to use SSH instead of https
```yadm remote set-url origin git@github.com:etherwrangler/dotfiles.git```


Setup for WSL2 on Windows
-------------------------
Install WSL and run through it's initial config
```powershell
#In an administrator powershell prompt
wsl --install
```
Update Ubuntu and install zsh, oh-my-zsh, yadm, and download dotfiles
```shell
sudo apt update && sudo apt dist-upgrade -y

sudo apt install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

curl -o ~/.oh-my-zsh/custom/themes/cobalt2.zsh-theme https://raw.githubusercontent.com/wesbos/Cobalt2-iterm/b3a40ad59f907c9d290aba8d7c7d18434aa9d662/cobalt2.zsh-theme

sudo apt install yadm -y
yadm clone https://github.com/etherwrangler/dotfiles.git
yadm restore .
```

Download and install Hyper Terminal from the website https://hyper.is/.

Download and install MesloLG font from https://www.nerdfonts.com/.  From the zip file install "MesloLGLNerdFontMono-Regular.ttf"

Open Hyper Terminal and from the Hamburger Menu go to Edit > Preference (or ```ctrl + comma```).  Paste over the contents with the config from this [Gist](https://gist.githubusercontent.com/etherwrangler/f815b4729349ac3ed114d34cd456911a/raw/f110bca06e1fc0c1404316f6887bb81e72d6939b/.hyper.js "Hyper Terminal Config")

Generate ssh key for github (make sure you don't already have one).  If you put a password on it you'll have to type it in when you use it (when you commit).

[How to create a GitHub SSH Key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

```shell
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_github-C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519_github
```
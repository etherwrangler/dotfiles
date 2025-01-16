# Setup for MacOS

Install chezmoi (via homebrew)
```shell
brew install chezmoi
```
more stuff soon

# Setup for Windows

Set ExecutionPolicy to RemoteSigned so that scripts can run
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Install chezmoi (via winget)
```powershell
winget install chezmoi
```

Add dotfiles and apply settings
```powershell
chezmoi init etherwrangler
```
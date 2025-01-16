# Setup for MacOS

Install chezmoi (via homebrew)
```shell
brew install chezmoi
```
more stuff soon

# Setup for Windows

Set ExecutionPolicy to RemoteSigned so that scripts can run, install chezmoi, init the repo and apply changes
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
winget install chezmoi
chezmoi init etherwrangler
```
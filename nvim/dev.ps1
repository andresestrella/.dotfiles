# this script removes the ~/.config/nvim dir where nvim would normally look for configs and creates a sym link to wherever this dir is.
Remove-Item -Path $HOME\AppData\Local\nvim -Recurse -Force
New-Item -ItemType SymbolicLink -Path $HOME\AppData\Local\nvim -Value (Get-Location)

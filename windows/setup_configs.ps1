# copy the Microsoft.PowerShell_profile.ps1 file to the $env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
# Remove-Item -Path $HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 -Recurse -Force
New-Item -ItemType SymbolicLink -Path $HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 -Value (Get-Location)\Microsoft.PowerShell_profile.ps1

# this script removes the ~/.config/nvim dir where nvim would normally look for configs and creates a sym link to wherever this dir is.
Remove-Item -Path $HOME\AppData\Local\nvim -Recurse -Force
New-Item -ItemType SymbolicLink -Path $HOME\AppData\Local\nvim -Value (Get-Location)

# copy the glazeWM.yaml file to the $env:USERPROFILE\.glaze-wm\config.yaml
Remove-Item -Path $HOME\.glaze-wm\config.yaml -Recurse -Force
New-Item -ItemType SymbolicLink -Path $HOME\.glaze-wm\config.yaml -Value (Get-Location)\glazeWM.yaml

#copy the WindowsTerminalSetting.json file to the $env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
Remove-Item -Path $HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -Recurse -Force
New-Item -ItemType SymbolicLink -Path $HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -Value (Get-Location)\WindowsTerminalSettings.json

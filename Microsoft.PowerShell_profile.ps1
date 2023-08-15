# run oh-my-posh and set theme
#oh-my-posh init pwsh | Invoke-Expression
#oh-my-posh --init --shell pwsh --config ~/jandedobbeleer.omp.json | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/multiverse-neon.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/negligible.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/slim.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/tiwahu.omp.json" | Invoke-Expression
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/di4am0nd.omp.json" | Invoke-Expression
Import-Module -Name Terminal-Icons


#path aliases
# $desk = "C:\Users\User\Desktop"

#starship prompt configuration
#$ENV:STARSHIP_CONFIG="D:\WorkSpaces\.dotfiles\starship.toml"
#Invoke-Expression (&starship init powershell)

# uses PSReadLine for better command history navigation. when I press the up arrow it will show me history based on what I've typed so far.
$versionMinimum = [Version] '7.1.999'
if (($host.Name -eq 'ConsoleHost') -and ($PSVersionTable.PSVersion -ge $versionMinimum)) {
  Set-PSReadLineOption -PredictionSource HistoryAndPlugin
}
else
{
  Set-PSReadLineOption -PredictionSource History
}

# PSReadLine keybindings
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineKeyHandler -Chord "Ctrl+n" -Function HistorySearchForward
Set-PSReadLineKeyHandler -Chord "Ctrl+p" -Function HistorySearchBackward

# replace 'Ctrl+t' and 'Ctrl+r' with your preferred bindings:
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
# Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
# Set-PsFzfOption -TabExpansion

# bashlike functions for powershell
function unzip ($file){
  echo("Extracting", $file, "to", $pwd)
  $fullFile = Get-ChildItem -Path $pwd -Filter .\cove.zip | ForEach-Object{$_.FullName}
  Expand-Archive -Path $fullFile -DestinationPath $pwd
}

function touch($file){
  "" | Out-File $file
}

function pkill($name){
  ps $name -ErrorAction SilentlyContinue | kill
}

function which ($name){
  Get-Command $name | Select-Object -ExpandProperty Definition
}

function df {
  get-volume
}

function export ($name, $value){
  set-item -force -path "env:$name" - value:$value;
}

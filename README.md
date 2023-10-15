# .dotfiles
*THIS README IS UNFINISHED*  
WINDOWS 10X DEV WORKFLOW CONFIG FILES 


# Setting everything up
First we need to install all the packages and programming languages. For this I use [WingetUI]() an amazing GUI for finding and managing packages from all sorts of windows package managers.
Edit `WingetUI-Packages.json` as you see fit, import it into WingetUI and install all the packages.

Second, `powershell_installs.ps1` script that install a couple of powershell modules that enhance the experience of using the command line. Here I install:
- [Z location](https://github.com/vors/ZLocation): for accessing your most used directories fast
- Terminal Icons
- [PSFzf](https://github.com/kelleyma49/PSFzf): powershell wrapper for fzf, for fuzzy finding files and directories
- [PSReadLine](https://github.com/PowerShell/PSReadLine): much better autocompletion and many other features.

Run `setup_configs.ps1` script that removes the configs found in the default config directories  of all the tools and replaces them with a hyperlink to the configs found in this repo.
The idea is that you have all your configs in a centralized repo where you can edit them in one place.
I shouldn't mention you should back things up if you have configs of your own in those dirs before running this.

That's it! Let's talk about the configs.

# Configs
## PowerShell
`Microsoft.PowerShell_profile.ps1` is the config file for PowerShell and does the following:
- inits oh-my-posh and sets a  prompt theme
- Imports the terminal icons module
- imports z location module
- sets up PSReadLine and PsFzf with keybindings
- maps bash command names to powershell equivalents. For example it maps the `which` bash command keyword to `Get-Command $name | Select-Object -ExpandProperty Definition`
This last one a work in progress and I still need to lookup if there are any projects that do this already.

## nvim
`nvim\` this is my personal neovim config folder. Honestly there is way too much to unpack here and my config is highly personalized. I would suggest to start getting into vim/nvim first try out popular vim keybinding plugins available for your favorite code editor and get used to those first.
Then if you want to dive deeper into the power of neovim, try out popular configs like LazyVim, LunarVim, NvChad... Taking neovim from a mere text editor to a full featured 'IDE' with features like intellisense, debugging, testing, etc... on your own takes quite a bit of work and configuration.
However, I don't regret having configured neovim on my own, for one, all the keybindings (which there are MANY to learn) have sticked in my brain fairly quickly since I was the one setting them and writing each one of them down.
And second it has given me a deep confidence and understanding of dev tooling. 
Before taking on the task of having a neovim config I am happy with, some features inside editors/IDEs (and even of tooling outside of that) felt misterious to me and/or I had no knowledge of. After, I am confident and feel like I know every knook and cranny inside a code editor and have gained massive knowledge about how dev tooling works.
Having said all this, for most people the tradeoff frankly isn't worth it and an editor like VSCode is more than good enough and is so easy to set up and forget about it.
If you take anything out of this section is at least learn and use vim keybindings, you won't regret it. 

## Window Manager
If you aren't familiar with tiling window managers like i3 from the Linux world, they basically organize your screen into non-overlapping frames. 
and of course, everything is controlled with key bindings.
instead of letting windows float and stack on top of each other, like we are all used to
if you have a lot of windows open Shift+Tabbing through them can get tidious.
PowerToys has a feature for better but I haven't tried it
### Running window manager at startup


## Browser 
plugins
# Misc
`change_background.bat` script that changes the desktop background to a randomly chosen image from a specified directory. 

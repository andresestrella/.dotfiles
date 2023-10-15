# .dotfiles
*THIS README IS UNFINISHED AND MESSY*  
WINDOWS 10X DEV WORKFLOW CONFIG FILES 


If you plan on being a software developer for a long time, chances are you will spend a lot of your life using a computer. So why not learn to use a computer as efficiently as possible and hopefully get more done in less time.  

On most tasks, using a mouse is slower than if you were to use a keyboard shortcut. First you have to move your hand off the keyboard onto your mouse, move around and click the UI to complete your task.  

By going mouseless, you subscribe to the idea that the effort of learning a bunch of shortcuts and configuring your system (which could take a lot of time depending on how deep you get into it) is worth it for the small amount of time you save everytime you use a keyboard shortcut and that this small amount of time saved turns into a significant amount in the span of years. In my non scientific personal experience I would say pressing a shortcut saves me about ~2 seconds on average.  

Going mouseless makes writing code more fun. At first, it makes coding feel like a puzzle game where you are trying to find the quickest way to write and edit your code and once the shortcuts are in your muscle memory you'll be using your computer at speeds never imagined before and you'll feel like a [wizard](https://www.youtube.com/shorts/cOgw1qFuJAA). Which leads to the last reason and truly the end goal: 

makes you superior to others.
[![r/vim - WHAT GIVES PEOPLE FEELINGS OF POWER MONEY STATUS USING VIM](https://preview.redd.it/sqipd5d2jc461.png?width=960&crop=smart&auto=webp&s=bb4c0d55da5f62003c589aed724d4cc70f491a33)](https://i.redd.it/sqipd5d2jc461.png)

Why Windows?  
If you start getting deep into developer experience, you would know that the best place to be is Linux, so why do I stay over at Windows? 
The reason for me is native support for productive software (mainly Ableton) and games (although I don't play as much nowdays). I know I could dual boot operating systems or run compatability layers like Wine. But I haven't gone through the trouble of researching how to set everything up and I have a good enough computer to not care about all the resources Windows hogs up. 

# Setting everything up
First we need to install all the packages and programming languages. For this I use [WingetUI]() an amazing GUI for finding and managing packages from all sorts of windows package managers.  

why use package managers? 
specially on Windows the usual steps for installing anything is something like: looking up what you want to install > hope you find the official site and not some malicious source > navigate the site to find the download link > unzip what you downloaded or run an installer > Most installers let you select a directory to install to > done

Uninstalling goes like this: 
go to Apps and Features > browse and uninstall program
Sometimes programs don't get listed here and you are left to remembering where the program was installed or maybe you have a shortcut in your Start Menu that can lead you to the install folder. In this folder you may or may not find an uninstall executable, if not, you just delete the entire folder and hope there aren't any dangling temp or logs folders left somewhere in your system.

Package managers take all this headache away, installing and uninstalling programs is as simple as opening a terminal and running a single command.


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

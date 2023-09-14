@echo off
setlocal enabledelayedexpansion

:: Path to your image folder
set "ImageFolder=D:\Pictures_Videos\backgrounds"

:: Get a random image file from the folder
for %%f in ("%ImageFolder%\*.*") do (
    set "Images[!random!]=%%~f"
)

:: Retrieve a random image
for /f "tokens=2 delims==" %%r in ('set Images[') do (
    set "RandomImage=%%r"
    goto ChangeBackground
)

:ChangeBackground
:: Change the desktop background
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "%RandomImage%" /f
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

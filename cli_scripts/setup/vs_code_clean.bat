REM Script for uninstalling all current Visual Studio Code extensions
@echo off
for /f "tokens=*" %%A in ('code --list-extensions') do (
    code --uninstall-extension %%A
)
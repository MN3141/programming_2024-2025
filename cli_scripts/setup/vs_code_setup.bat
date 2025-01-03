REM Script for installing Visual Studio Code extensions
@echo off
::Delayed Expansion
setlocal enabledelayedexpansion

set "file=vs_code_extensions.txt"

for /f "tokens=* delims=" %%A in (%file%) do (
    code --install-extension %%A
)

endlocal

REM Script for assembling 8086 code on DOSBOX with TASM

set project_name=%1

tasm.exe /zi/la %project_name%\%project_name%.asm

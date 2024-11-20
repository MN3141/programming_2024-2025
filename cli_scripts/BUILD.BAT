REM Script for assembling,linking and debugging 8086 code on DOSBOX with TASM

set project_name=%1

tasm.exe /zi/la %project_name%\%project_name%.asm
tlink /v %project_name%\%project_name%.obj
td.exe %project_name%\%project_name%.exe

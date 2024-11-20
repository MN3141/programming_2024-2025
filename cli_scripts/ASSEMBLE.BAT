REM Script for assembling 8086 code on DOSBOX with TASM

set project_name=%1
cd %project_name%
..\tasm.exe /zi/la %project_name%.asm
cd ..
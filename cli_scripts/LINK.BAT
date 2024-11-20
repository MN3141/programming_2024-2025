REM Script for linking 8086 code on DOSBOX with TASM

set project_name=%1
cd %project_name%
..\tlink.exe /v %project_name%.obj
cd ..
REM Script for debugging 8086 code on DOSBOX with TASM

set project_name=%1
cd %project_name%
..\td.exe %project_name%.exe
cd ..
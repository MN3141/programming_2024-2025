REM Script linking 8086 code on DOSBOX with TASM

set project_name=%1

tlink.exe /v %project_name%\%project_name%.obj

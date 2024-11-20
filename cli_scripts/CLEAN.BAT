REM Script for cleaning 8086 project

set project_name=%1
cd %project_name%
del *.exe
del *.lst
del *.map
cd ..
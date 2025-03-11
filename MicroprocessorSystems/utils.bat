@echo off

set mips_simulator_dir=C:\tools\MIPS_Simulator
set mips_simulator=%mips_simulator_dir%\SPIMSAL.EXE
set source_file=%mips_simulator_dir%\code.s
set script_dir=%cd%

cd /d %mips_simulator_dir%
copy %1 %source_file%
%mips_simulator% %source_file%
cd /d %script_dir%
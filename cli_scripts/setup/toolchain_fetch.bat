REM Script for fetching software development tools for Windows 64-bit machines
::Note: Due to most installers having different flags (or none at all)
::      this script shall only fetch them, not run them afterwards

@echo off
:: Delayed Expansion
setlocal enabledelayedexpansion

echo Please run this script as administrator before proceeding further...
echo Available partitions are C, D, E, F

set partition=
set tools_dir=
set input_file=tools_links.txt
:: Check file type
set git_repo_suffix=.git
set zip_suffix=.zip
set exe_suffix=.exe
set msi_suffix=.msi

:: Parse input partition
for %%A in (%*) do (
    if "%%A"=="C" set partition=C:\
    if "%%A"=="D" set partition=D:\
    if "%%A"=="E" set partition=E:\
    if "%%A"=="F" set partition=F:\
)

:: Check if partition exists
IF NOT EXIST "!partition!" (
    echo ERROR: Partition does not exist
    :: Error exit code
    exit /b 1
)

set tools_dir=!partition!\tools

IF NOT EXIST "!tools_dir!" (
    echo Creating tools directory...
    mkdir "!tools_dir!"
)

:: Loop through each line in the text file
for /f "usebackq tokens=*" %%A in ("%input_file%") do (
    :: Get the current line
    set line=%%A

    :: The delimiter shall be ',' character
    for /f "tokens=1,2 delims=," %%B in ("!line!") do (
        :: Get tokens
        set name=%%B
        set link=%%C

        :: Check file type
        if /i "!link:~-4!"=="!git_repo_suffix!" (
            :: Git repository
            git clone "!link!" "!tools_dir!\!name!"
        ) else (
            echo Fetching !name!...
            set fetched_tool_dir=!tools_dir!\!name!
            set fetched_file=

            mkdir "!fetched_tool_dir!"

            if /i "!link:~-4!"=="!zip_suffix!" (
                :: Zip archive
                set fetched_file=!name!_setup.zip
            ) else if /i "!link:~-4!"=="!exe_suffix!" (
                :: EXE file
                set fetched_file=!name!_setup.exe
            ) else if /i "!link:~-4!"=="!msi_suffix!" (
                :: MSI file
                set fetched_file=!name!_setup.msi
            ) else (
                set fetched_file=!name!_setup.exe
            )

            if defined fetched_file (
                curl -L "!link!" --ssl-revoke-best-effort --output "!fetched_tool_dir!\!fetched_file!"
            )
        )
    )
)

:: End delayed expansion
endlocal

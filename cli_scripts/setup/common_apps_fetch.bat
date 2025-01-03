REM Script for fetching commonly used apps for Windows 64-bit machines

@echo off
:: Delayed Expansion
setlocal enabledelayedexpansion

echo Please run this script as administrator before proceeding further...
echo Available partitions are C, D, E, F

set partition=
set app_downloads_dir=
set input_file=common_apps_links.txt
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

set app_downloads_dir=!partition!\app_downloads\

IF NOT EXIST "!app_downloads_dir!" (
    echo Creating temporary directory for downloads...
    mkdir "!app_downloads_dir!"
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
            git clone "!link!" "!app_downloads_dir!\!name!"
        ) else (
            echo Fetching !name!...
            set fetched_app_dir=!app_downloads_dir!\!name!
            set fetched_file=

            mkdir "!fetched_app_dir!"

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
                curl -L "!link!" --ssl-revoke-best-effort --output "!fetched_app_dir!\!fetched_file!"
            )
        )
    )
)

:: End delayed expansion
endlocal

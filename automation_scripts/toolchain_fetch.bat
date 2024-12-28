:: Script for fetching needed tools for software development
:: For the moment, the script is written with Windows OS in mind

@echo off

:: The tools path shall be changed according to local computer partitions
:: Winrar is needed to be added as a path variable in order for this script to work

echo "Please run this script in administrator before proceeding further..."

set TOOLS_DIR=C:\tools

:: Check if the Tools directory already exists
IF NOT EXIST %TOOLS_DIR% (
  mkdir %TOOLS_DIR%
)

:: Fetch Notepad++ 8.6.8
echo "Fetching  Notepad++ 8.6.8..."
set NPP_DIR=%TOOLS_DIR%\Notepad++
mkdir %NPP_DIR%

::curl -L https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.8/npp.8.6.8.portable.x64.zip --ssl-revoke-best-effort --output %NPP_DIR%\npp.zip
::sometimes only the above version works

curl https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.8/npp.8.6.8.portable.x64.zip --output %NPP_DIR%\npp.zip
::winrar x -df %NPP_DIR%\npp.zip %NPP_DIR%

:: Fetch hex reader
echo "Fetching Hex reader..."
::https://mh-nexus.de/downloads/HxDPortableSetup.zip

:: Fetch documentation generator 
echo "Fetching Doxygen..."
::https://www.doxygen.nl/files/doxygen-1.12.0-setup.exe

:: Fetch Git versioning system
echo "Fetching Git..."
:: Fetch Java JDK

:: Fetch Cygwin terminal for running BASH scripts on Windows
echo "Fetching Cygwin..."
::https://www.cygwin.com/setup-x86_64.exe

echo "Fetching Java JDK..."
::https://corretto.aws/downloads/latest/amazon-corretto-17-x64-windows-jdk.msi

:: Fetch Python
echo "Fetching Python"
::https://www.python.org/ftp/python/3.12.7/python-3.12.7-amd64.exe

:: Fetch MSYS2 for installing GCC/G++ and GNU tools
echo "Fetching MSYS2..."
::https://github.com/msys2/msys2-installer/releases/download/2024-07-27/msys2-x86_64-20240727.exe

:: Fetch new PowerShell version for a better Windows Terminal experience
::This step may be optional
echo "Fetching PowerShell..."
::https://github.com/PowerShell/PowerShell/releases/download/v7.4.5/PowerShell-7.4.5-win-x64.zip

:: Fetch PlantUML for drawing different types of diagrams
echo "Fetching PlantUML..."
::https://github.com/plantuml/plantuml/releases/download/v1.2024.7/plantuml-1.2024.7.jar

:: Fetch C unit testing framework
echo "Fetching Unity framework..."
::git clone https://github.com/ThrowTheSwitch/Unity.git


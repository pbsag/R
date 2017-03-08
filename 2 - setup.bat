@echo off

rem this file must be run with admin rights

rem set the r installation folder name
set r_dir="R-3.3.2"

rem install R to the current directory
echo Installing R...
set errorlevel=
R-3.3.2-win.exe /SILENT /DIR=%cd%\%r_dir%
if %errorlevel% EQU 0 (
  echo R installation complete
) else (
  echo R installation failed
  pause
  exit
)

rem run the packages.R script
echo Installing packages...
set errorlevel=
R-3.3.2\bin\Rscript.exe packages.R %r_dir%
if %errorlevel% EQU 0 (
  echo Package installation complete
) else (
  echo Package installation failed
  pause
  exit
)

pause
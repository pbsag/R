@echo off

rem this file must be run with admin rights

rem set the r version number
set r_ver="R-3.3.3"

rem install R to the current directory
echo Installing R...
set errorlevel=
%r_ver%-win.exe /SILENT /DIR=%cd%\%r_ver%
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
%r_ver%\bin\Rscript.exe packages.R %r_ver%
if %errorlevel% EQU 0 (
  echo.
  echo Package installation complete
) else (
  echo.
  echo Package installation failed
  pause
  exit
)

pause
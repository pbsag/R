@echo off

rem this file must be run with admin rights

rem set the r installation folder name
set r_dir="R-3.3.2"

rem install R to the current directory
echo Installing R...
R-3.3.2-win.exe /SILENT /DIR=%cd%\%r_dir%

rem run the packages.R script
R-3.3.2\bin\Rscript.exe packages.R %r_dir%

pause
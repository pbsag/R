rem this file must be run with admin rights

rem install R to the current directory
R-3.3.2-win.exe /SILENT /DIR=%cd%\R-3.3.2

rem run the packages.R script
R-3.3.2\bin\Rscript.exe packages.R

pause
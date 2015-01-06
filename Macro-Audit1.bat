@@echo off
:: REQUIREMENTS
:: mdaudit.bat must be run in your root directory of your repository
:: output files will be written to C:\ETL\
:: 		macronames.txt - a stripped list of macros from the macrodef.xml file
:: 		MacroDefAudit.txt -- a list of macros and the files that contain them
@echo Auditing macrodef.xml file...
@echo MACRODEF.XML AUDIT: %DATE% %TIME% > c:\ETL\MacroDefAudit.txt
:: Get stripped list of macro names from macrodef.xml
grep -Po name=\".*?(?=\".*) macrodef.xml | cut -c 7-100 > c:\ETL\macronames.txt

:: Loop through the list and find all files with an occurrance of each macro
for /f "tokens=1 delims=" %%i in (c:\ETL\macronames.txt) do call :searchpart %%i
goto :fin1
:searchpart
:: Monitor the progress
echo %1
:: Write out the macro name and the files containing it
echo %1********************************************************* >> c:\ETL\MacroDefAudit.txt
grep -rl --exclude=*svn* --exclude=*macrodef.xml --exclude=*.rifl %1 .  >> c:\ETL\MacroDefAudit.txt

:fin1
:: View output in notepad++ (note that viewing it in notepad doesn't format correctly) 
:: "C:\Program Files (x86)\Notepad++\notepad++.exe" c:\ETL\MacroDefAudit.txt

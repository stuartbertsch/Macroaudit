@@echo off
:: REQUIREMENTS
:: Macro-Audit-Full.bat must be run in your root directory of your repository
:: output files will be written to C:\ETL\
:: 		macronames.txt - a stripped list of macros from the macrodef.xml file
:: 		MacroDefAudit.txt -- a list of macros and the files that contain them
::		CODEmacros.txt -- list of macros pulled from code files
:: 		MacroDefAudit.txt -- List of macro files FROM the code MISSING in macrodef.xml file
@echo Auditing MACRO definitions...
@echo MACRODEF.XML AUDIT: %DATE% %TIME% > c:\ETL\MacroDefAudit.txt
:: Get stripped list of macro names from macrodef.xml
grep -Po name=\".*?(?=\".*) macrodef.xml | cut -c 7-100 > c:\ETL\macronames.txt

:: Loop through the list and find all files with an occurrance of each macro
for /f "tokens=1 delims=" %%i in (c:\ETL\macronames.txt) do call :searchpart1 %%i
goto :fin1
:searchpart1
:: Monitor the progress
echo %1
:: Write out the macro name and the files containing it
echo %1********************************************************* >> c:\ETL\MacroDefAudit.txt
grep -rl --exclude=*svn* --exclude=*macrodef.xml --exclude=*.rifl %1 .  >> c:\ETL\MacroDefAudit.txt
EXIT /B


:fin1
@echo Auditing MACRO definitions...
@echo CODE MACRO AUDIT: %DATE% %TIME% > c:\ETL\MacroCODEAudit.txt
:: Scrape all macros from code in repository
grep -rPo --no-filename --exclude=*svn* --exclude=*macrodef.xml --exclude=*.rifl MacroValue\(\".*?(?=\".*) . | cut -c 13-100 > c:\ETL\CODEmacros.txt
:: Loop through the list and look for an occurrance of each in the macrodef.xml list
for /f "tokens=1 delims=" %%i in (c:\ETL\CODEmacros.txt) do call :searchpart2 %%i
goto :fin2

:searchpart2
:: Monitor the progress
echo %1
:: Write out the macro name and the files containing it
grep -q %1 c:\etl\macronames.txt
IF "%errorlevel%" == "1" (
echo %1 NOT FOUND in Macrodef.xml >> c:\ETL\MacroCODEAudit.txt
grep -rPl --no-filename --exclude=*svn* --exclude=*macrodef.xml --exclude=*.rifl --exclude=macro-audit2.bat %1 . >> c:\ETL\MacroCODEAudit.txt
)
EXIT /B

:fin2
:: View output in notepad++ (note that viewing it in notepad doesn't format correctly) 
Start "" "C:\Program Files (x86)\Notepad++\notepad++.exe" c:\ETL\MacroDefAudit.txt c:\ETL\MacroCODEAudit.txt

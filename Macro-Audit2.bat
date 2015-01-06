@@echo off
@echo Auditing macros in code against macrodef.xml file...
@echo MACRO CODE AUDIT: %DATE% %TIME% > c:\ETL\MacroCODEAudit.txt
:: Get stripped list of macro names from macrodef.xml
grep -Po name=\".*?(?=\".*) macrodef.xml | cut -c 7-100 > c:\ETL\macronames.txt

:: Scrape all macros from code in repository
grep -rPo --no-filename --exclude=*svn* --exclude=*macrodef.xml --exclude=*.rifl MacroValue\(\".*?(?=\".*) . | cut -c 13-100 > c:\ETL\CODEmacros.txt

:: Loop through the list and look for an occurrance of each in the macrodef.xml list
for /f "tokens=1 delims=" %%i in (c:\ETL\CODEmacros.txt) do call :searchpart %%i
goto :fin1


:searchpart
:: Monitor the progress
echo %1
:: Write out the macro name and the files containing it
grep -q %1 c:\etl\macronames.txt
IF "%errorlevel%" == "1" (
echo %1 NOT FOUND in Macrodef.xml >> c:\ETL\MacroCODEAudit.txt
grep -rPl --no-filename --exclude=*svn* --exclude=*macrodef.xml --exclude=*.rifl --exclude=macro-audit2.bat %1 . >> c:\ETL\MacroCODEAudit.txt
)
:fin1
:: View output in notepad++ (note that viewing it in notepad doesn't format correctly) 
:: "C:\Program Files (x86)\Notepad++\notepad++.exe" c:\ETL\MacroCODEAudit.txt

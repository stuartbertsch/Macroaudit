@@echo off
::INSTALL THE FILES
::   Copy ./UnixTools/* to the WindowsPowerShell directory to get them in your PATH
::   Copy ./*.bat to the C:\ETL directory to make them available for use
::
echo INATLL PATH is %~dp0
copy %~dp0\*.bat c:\ETL
		IF "%errorlevel%" == "1" (
		echo errorlevel = %errorlevel% 
		echo Problem copying files...
		pause > nul
		goto :end
		)

IF EXIST C:\Windows\System32\WindowsPowerShell\v1.0 GOTO :install
@echo C:\Windows\System32\WindowsPowerShell\v1.0 directory does not exist
@echo Find somewhere in your PATH to copy the UnixTools files manually
goto :end

:install
    echo Checking permissions...
    SET adminRights=0
    FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
        IF "%%i"=="SeTakeOwnershipPrivilege" SET adminRights=1
    )
    IF %adminRights% == 1 (
        echo Admin permissions confirmed.
		copy %~dp0\UnixTools\*.* C:\Windows\System32\WindowsPowerShell\v1.0
		IF "%errorlevel%" == "1" (
		echo Problem copying files...
		pause > nul
		goto :end
		)
		@echo To test if the UnixUtils are in your PATH just open a command window
		@echo and run a tool name, like grep to see if it works.
		@echo Done!
		pause >nul
goto :end 
    ) ELSE (
        echo Admin permissions absent.
        echo.
        echo This file needs to be run as an Administrator.
        echo.
        echo Close this window, right-click on the file and click "Run as Administrator".
        echo   OR
        echo Log on to an Administrator account and run this file normally.

        pause >nul
    )

:end
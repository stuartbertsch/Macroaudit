Macroaudit
==========

UnixTools code to audit macro usage in Pervasive projects


*********************************************************************************************************************
INSTALL
*********************************************************************************************************************
UNZIP the files
Run the INSTALL.BAT file

This will copy the UnixTools files to your c:\windows\system32\powershell\v1.0 directory which should be in your PATH
It will also copy the batch files to your C:\ETL directory so they can easily be copied to your project root directories and run

*********************************************************************************************************************
USING THE PROGRAM
*********************************************************************************************************************

Copy a	 	MACRO-AUDIT1.BAT, 
			MACRO-AUDIT2.BAT, or
			MACRO-AUDIT-FULL.BAT file to the ROOT directory of the project you want to audit

Run the desired batch file in a DOS(COMMAND) window or double-click in Windows Explorer

MACRO-AUDIT1.BAT - find macros in your macrodef.xml file that are not being used in your code
MACRO-AUDIT2.BAT - find macors in your code that are missing from your macrodef.xml
MACRO-AUDIT-FULL.BAT - one file that does both MACRO-AUDIT1 and MACRO-AUDIT2

*********************************************************************************************************************
OUTPUT
*********************************************************************************************************************
Four files get created in C:\ETL\

Macros in macrodef.xml and occurrances (or lack of) in the code base
----------------------------------------------------------------------------
Macronames.txt ñ A stripped list of all macronames in your macrodef.xml file
MacroDefAudit.txt ñ The audit file of macros and files containing them

Macros in the code base that are missing from macrodef.xml (and how many times they occur in the code)
---------------------------------------------------------------------------------------------------------
CODEmacros.txt - The scraped macro names in code files in the project
MacroCODEAudit.txt - The list of macros in code that are not in macrodef.xml (Each listed with the file in which they occured.)

*********************************************************************************************************************
OTHER NOTES
*********************************************************************************************************************
SVN exclude the batch file from your repo if you intend to keep them there for awhile or
just delete the batch files and copy them again when needed.

Remember when auditing multiple projects, the output files will get overwritten

In the MacroDefAudit.txt file look for MACRO names that don't have any files listed.  
They can be deleted from you macrodef.xml since they are not used.  Don't use this as gospal though and be thoughtful
about deleting macros -- always check and think if they are needed elsewhere, by the client, or will
be needed later.

The MacroCODEAudit.txt file will list macros found in code (and the files they are in) that are NOT found in macrodef.xml

**********************************************************************************************************************
IMPROVEMENTS NEEDED
*********************************************************************************************************************
1. Make output more readable




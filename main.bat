:: This program/script was made by apollo-jhn(Ponteras, John Apollo S.)
:: Student from Dr. Filemon C. Aguilar Memorial College - IT Campus
:: Program: Bachelor of Science in Computer Engineering - 2nd Year

:: PROGRAM DETAILS
:: This Program is licensed Under : MIT
:: ABOUT :>
:: This script is to create a source file containing JDK 8 for creating Java Applet Programs in an instant.
:: Just run it, specify the location, wait the process to be finished and ready to go.
:: this script provide the source file as starter with a "compile and run" script to compile and run the applet
:: program.

@echo off

:: Intro
call:title

:: Ask for File path directory
echo:
call:prompt_filepath

:: Ask Source Code Name
echo:
call:prompt_projectname

:: Refresh
cls
call:title
echo:

:: Creating a Directory on the selected path
mkdir %FILEPATH%\%PROJECTNAME%

:: Removing Quotes for the following process and 
set PROJECTNAME=%PROJECTNAME:"=%
set FILEPATH=%FILEPATH:"=%
set PROJECTNAME_NOSPACE=%PROJECTNAME: =_%
set DESTINATION_PATH=^"%FILEPATH%\%PROJECTNAME%\^"
set DESTIN_PATH_SRC=^"%FILEPATH%\%PROJECTNAME%\src^"

:: This part copies the Java 8 SDK and extract it then delete it after
:: Extracting it.
xcopy .\resources\jdk8.zip %DESTINATION_PATH%
set JDK_LOCATION=^"%FILEPATH%\%PROJECTNAME%\jdk8.zip^"
Call :UnZipFile %DESTINATION_PATH% %JDK_LOCATION%
del %JDK_LOCATION%

:: Copy resources to path specified
xcopy .\resources\java.txt %DESTIN_PATH_SRC%
xcopy .\resources\html.txt %DESTIN_PATH_SRC%
xcopy .\resources\Compile-and-Run.bat %DESTIN_PATH_SRC%

:: Replace Placeholders with added 2 second Pauses
cd %DESTIN_PATH_SRC%
timeout /t 1
echo HTML TEXT REPLACE PLACEHOLDER INITIALIZED
powershell -Command "(gc html.txt) -replace 'PLACEHOLDER', '%PROJECTNAME_NOSPACE%' | Out-File -encoding ASCII html.txt"
timeout /t 1
echo JAVA TEXT REPLACE PLACEHOLDER INITIALIZED
powershell -Command "(gc java.txt) -replace 'PLACEHOLDER', '%PROJECTNAME_NOSPACE%' | Out-File -encoding ASCII java.txt"
timeout /t 1
echo COMPILE-AND-RUN TEXT REPLACE PLACEHOLDER INITIALIZED
powershell -Command "(gc Compile-and-Run.bat) -replace 'PLACEHOLDER', '%PROJECTNAME_NOSPACE%' | Out-File -encoding ASCII Compile-and-Run.bat"

:: This renames the txt files to specific type
ren java.txt %PROJECTNAME_NOSPACE%.java
ren html.txt %PROJECTNAME_NOSPACE%.html

:: End Script
cls
call:title
echo:
echo That's about it, thank for using it. If any issues, concern, suggestion please contact. 
echo The author from the top of the console screen.
echo:
echo to close the program
pause
exit

::--------------------------------------------------------
::-- Function section starts below here
::--------------------------------------------------------

:title
    echo Java 8 SDK and Source file generator with Compile and Run Script
    echo Script by: apollo-jhn / follow me: https://github.com/apollo-jhn
    echo Script License: MIT
goto:eof

:: Ask for File Path Directory
:prompt_filepath
    echo Please enter the file path where you want your source to be placed.
    echo If your path has spaces make sure you enclose it with double quotes 
    echo for example "C:\dev\umay lods dot com"
    echo:
    set /p FILEPATH="Enter your path here: "
    if [%FILEPATH%] == [] (
        echo:
        echo **This field is not required to be empty
        goto :prompt_filepath
    )
goto:eof

:: Functions that ask for the project name
:prompt_projectname
    echo Indicate here the name of your project
    echo *Again, if you like spaces please enclosed it with
    echo double quotes for example "project kong maangas"
    echo:
    set /p PROJECTNAME="Enter project name here: "
    if [%PROJECTNAME%] == [] (
        echo:
        echo **This field is not required to be empty
        goto :prompt_projectname
    )
goto:eof

:: If encounters an error
:errorwasfound
    cls
    echo An error was found at %~1 submit an issue on github link
    echo down below with full specification of your machine.
    echo:
    pause
goto:eof

:: Unzip the zip filetype :>
:: Snippet Reference: https://stackoverflow.com/a/21709923
:UnZipFile <ExtractTo> <newzipfile>
    set vbs="%temp%\_.vbs"
    if exist %vbs% del /f /q %vbs%
       >%vbs%  echo Set fso = CreateObject("Scripting.FileSystemObject")
       >>%vbs% echo If NOT fso.FolderExists(%1) Then
       >>%vbs% echo fso.CreateFolder(%1)
       >>%vbs% echo End If
       >>%vbs% echo set objShell = CreateObject("Shell.Application")
       >>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
       >>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
       >>%vbs% echo Set fso = Nothing
       >>%vbs% echo Set objShell = Nothing
    cscript //nologo %vbs%
    if exist %vbs% del /f /q %vbs%
goto:eof

:: Kung nabasa mo to nice one, goodluck sa career mo sa bohai.
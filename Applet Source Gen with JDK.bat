:: This program/script was made by apollo-jhn(Ponteras, John Apollo S.)
:: Student from Dr. Filemon C. Aguilar Memorial College - IT Campus
:: Program: Bachelor of Science in Computer Engineering - 2nd Year

:: PROGRAM DETAILS
:: This Program is licensed Under : MIT
:: ABOUT :>
:: This script is to create a source file containing JDK 8 for creating Java Applet Programs in an instant.
:: Just run it, specify the location, wait for the download to be finished and ready to go.
:: this script provide the source file as starter and a "compile and run" script to compile and run the applet
:: program.

@echo off
:: Calling out the title
call:title

:: Ask for File path directory
echo:
call:prompt_filepath

:: Ask Source Code Name
echo:
call:prompt_projectname

cls
call:title

:: Set the required value for the downloading process
:: *Also please make sure if the URL contains Ampersand '&' put '^' caret first
set "DOWNLOAD_URL=https://drive.google.com/uc?id=1m4vbE9_jxqM6HQ5G7YDt-i2wdj6q1ayy^&export=download^&confirm=t^&uuid=14cdf894-6a15-4ea5-a606-9e161772777a^&at=ALAFpqzd0y3tWhXbxqv69KZBaBk8:1666424455960"
:: Create a folder named jdk8projectApplet
mkdir %FILEPATH%\%PROJECTNAME%
:: This remove Quotes to avoid issues
set PROJECTNAME=%PROJECTNAME:"=%
set FILEPATH=%FILEPATH:"=%


:: This part downloads the jdk
set DESTIN_PATH=^"%FILEPATH%\%PROJECTNAME%\libericajdk8.zip^"
bitsadmin /transfer d_LJDK8 /DOWNLOAD /priority FOREGROUND %DOWNLOAD_URL% %DESTIN_PATH%

:: TODO: CHECK THE FILE 

:: Tite again
call:title


:: This variable DESTIN_PATH_WF is the path of the source
set DESTIN_PATH_WF=^"%FILEPATH%\%PROJECTNAME%\^"
:: Unzips the JDK
Call :UnZipFile %DESTIN_PATH_WF% %DESTIN_PATH%

:: Delete the Zip file
del %DESTIN_PATH%

:: Sets that allspaces turn into hypen
set PROJECTNAME_NOSPACE=%PROJECTNAME%
set PROJECTNAME_NOSPACE=%PROJECTNAME_NOSPACE: =-%

:: Source File Directory
set DESTIN_PATH_SRC=^"%FILEPATH%\%PROJECTNAME%\src^"
xcopy java.txt %DESTIN_PATH_SRC%
xcopy html.txt %DESTIN_PATH_SRC%
xcopy Compile-and-Run.bat %DESTIN_PATH_SRC%

cd %DESTIN_PATH_SRC%
powershell -Command "(gc html.txt) -replace 'REPLACETHIS', '%PROJECTNAME_NOSPACE%' | Out-File -encoding ASCII html.txt"
powershell -Command "(gc Compile-and-Run.bat) -replace 'PLACEHOLDER', '%PROJECTNAME_NOSPACE%' | Out-File -encoding ASCII Compile-and-Run.bat"

:: This renames the txt files to specific type
ren java.txt %PROJECTNAME_NOSPACE%.java
ren html.txt %PROJECTNAME_NOSPACE%.html

cls
call:title
echo:
echo That's about it, thank for using it. If any issues, concern, suggestion please contact. 
echo The author from the top of the console screen.
echo:
echo to close the program
pause
exit \B 0

::--------------------------------------------------------
::-- Function section starts below here "APOLLO IS HERE HEHEHE"
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



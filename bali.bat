@ECHO OFF
SETLOCAL

:: Define the DeleteFolder function
:DeleteFolder
ECHO DeleteFolder function called with argument: %~1

:: Check if the folder path was provided
IF "%~1"=="" (
    ECHO Error: No folder path provided.
    EXIT /B 1
)

SET "folderPath=%~1"

:: Check if the folder exists
IF NOT EXIST "%folderPath%" (
    ECHO Error: The folder "%folderPath%" does not exist.
    EXIT /B 1
)

:: Proceed to delete the folder contents
ECHO Deleting contents of "%folderPath%" ...

:: Attempt to delete files
DEL /Q "%folderPath%\*.*" > NUL 2>&1
IF ERRORLEVEL 1 (
    ECHO Error: Failed to delete files in "%folderPath%".
    EXIT /B 1
)

:: Attempt to delete subdirectories
FOR /D %%x IN ("%folderPath%\*") DO (
    RD /S /Q "%%x" > NUL 2>&1
    IF ERRORLEVEL 1 (
        ECHO Error: Failed to delete directory "%%x".
        EXIT /B 1
    )
)

ECHO Successfully cleaned "%folderPath%".
EXIT /B 0

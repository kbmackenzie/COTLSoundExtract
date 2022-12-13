@echo off
set "thisPath=%~dp0"
set "lambPath=Cult of the Lamb\Cult Of The Lamb_Data\StreamingAssets"

call :GetSteamPath steamPath
set "fullPath=%steamPath%%lambPath%"

cd %thisPath%
if not exist "vgmstream-win" goto VGMStreamNotFound

if not exist "output" mkdir "output"
call :ExtractMusic "%fullPath%" "%thisPath%"

echo Extraction completed!
pause

REM End of main
exit /B %ERRORLEVEL%

REM Get Steam path.
REM Params: 1. Variable by reference
:GetSteamPath
if defined ProgramFiles(x86^) (
	set "%~1=C:\Program Files (x86)\Steam\steamapps\common\" 
) else (
	set "%~1=C:\Program Files\Steam\steamapps\common\"
)
exit /B 0

REM Begin extracting music.
REM Params: 1. Full path, 2. Script path
:ExtractMusic
setlocal
echo Extracting sounds from Cult of the Lamb:
echo [Log Output %DATE% %TIME%] > "LogOutput.txt"
REM Temporarily add to PATH:
set "PATH=%~2\vgmstream-win;%PATH%"
for %%f in ("%~1\*.bank") do (
	call :GetSubsongs "%%f" "%%~nf"
)
endlocal
exit /B 0

REM Get subsongs from a given .bank file.
REM Params: 1. .bank path, 2. .bank filename
:GetSubsongs
setlocal
call :Subsongs "%~2" trackCount
if %trackCount%==0 goto SkipPoint 
echo Extracting tracks from: %~2
if not exist "output/%~2/" mkdir "output/%~2/"
for /l %%i in (1, 1, %trackCount%) do (
	call test.exe -o "output/%~2/%~2_%%i.wav" "%~1" -s %%i >> "LogOutput.txt"
)
:SkipPoint
endlocal
exit /B 0

REM Get subsong count for each .bank file
REM Params: 1. .bank filename, 2. Variable by reference
REM Batch has no Dictionary or swith/case, so I have to do it like this. :'D 
:Subsongs
set /a %~2=0
if /i "Atmos.assets"=="%~1" set /a %~2=20
if /i "Atmos.streams"=="%~1" set /a %~2=22
if /i "Dialogue.assets"=="%~1" set /a %~2=580
if /i "Dialogue.streams"=="%~1" set /a %~2=5
if /i "Master.assets"=="%~1" set /a %~2=1187
if /i "Master.streams"=="%~1" set /a %~2=40
exit /B 0



REM Exit if VGMstream directory not found.
:VGMStreamNotFound
echo Couldn't extract music: VGMStream directory not found!
echo Did you download the proper .zip file?
pause
exit /B %ERRORLEVEL%
@echo off
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do @(if "%%i"=="Version" (set windowsver=%%j) else (set windowsver=%%i))
if %WINDOWSVER% GEQ 10 for /f "tokens=2,*delims=:" %%i in ('chcp') do set /a oldcp=%%i
if %WINDOWSVER% GEQ 10 chcp 65001 >nul
if %WINDOWSVER% GEQ 10 echo/░██████╗░█████╗░██╗░░██╗░█████╗░░█████╗░██╗██╗░██████╗
if %WINDOWSVER% GEQ 10 echo/██╔════╝██╔══██╗██║░░██║██╔══██╗██╔══██╗██║╚█║██╔════╝
if %WINDOWSVER% GEQ 10 echo/╚█████╗░██║░░╚═╝███████║██║░░██║██║░░██║██║░╚╝╚█████╗░
if %WINDOWSVER% GEQ 10 echo/░╚═══██╗██║░░██╗██╔══██║██║░░██║██║░░██║██║░░░░╚═══██╗
if %WINDOWSVER% GEQ 10 echo/██████╔╝╚█████╔╝██║░░██║╚█████╔╝╚█████╔╝██║░░░██████╔╝
if %WINDOWSVER% GEQ 10 echo/╚═════╝░░╚════╝░╚═╝░░╚═╝░╚════╝░░╚════╝░╚═╝░░░╚═════╝░
if %WINDOWSVER% GEQ 10 echo/
if %WINDOWSVER% GEQ 10 echo/███╗░░░███╗██╗░░░██╗██╗░░░░░████████╗██╗████████╗░█████╗░░█████╗░██╗░░░░░
if %WINDOWSVER% GEQ 10 echo/████╗░████║██║░░░██║██║░░░░░╚══██╔══╝██║╚══██╔══╝██╔══██╗██╔══██╗██║░░░░░
if %WINDOWSVER% GEQ 10 echo/██╔████╔██║██║░░░██║██║░░░░░░░░██║░░░██║░░░██║░░░██║░░██║██║░░██║██║░░░░░
if %WINDOWSVER% GEQ 10 echo/██║╚██╔╝██║██║░░░██║██║░░░░░░░░██║░░░██║░░░██║░░░██║░░██║██║░░██║██║░░░░░
if %WINDOWSVER% GEQ 10 echo/██║░╚═╝░██║╚██████╔╝███████╗░░░██║░░░██║░░░██║░░░╚█████╔╝╚█████╔╝███████╗
if %WINDOWSVER% GEQ 10 echo/╚═╝░░░░░╚═╝░╚═════╝░╚══════╝░░░╚═╝░░░╚═╝░░░╚═╝░░░░╚════╝░░╚════╝░╚══════╝
if %WINDOWSVER% GEQ 10 chcp %oldcp% >nul
if %WINDOWSVER% LEQ 6 echo  __      _                 _ _         
if %WINDOWSVER% LEQ 6 echo / _\ ___^| ^|__   ___   ___ (_^| )__      
if %WINDOWSVER% LEQ 6 echo \ \ / __^| '_ \ / _ \ / _ \^| ^|/ __^|     
if %WINDOWSVER% LEQ 6 echo _\ \ (__^| ^| ^| ^| (_) ^| (_) ^| ^|\__ \     
if %WINDOWSVER% LEQ 6 echo \__/\___^|_^| ^|_^|\___/ \___/^|_^|^|___/     
if %WINDOWSVER% LEQ 6 echo.                                    
if %WINDOWSVER% LEQ 6 echo               _ _   _ _              _ 
if %WINDOWSVER% LEQ 6 echo   /\/\  _   _^| ^| ^|_(_) ^|_ ___   ___ ^| ^|
if %WINDOWSVER% LEQ 6 echo  /    \^| ^| ^| ^| ^| __^| ^| __/ _ \ / _ \^| ^|
if %WINDOWSVER% LEQ 6 echo / /\/\ \ ^|_^| ^| ^| ^|_^| ^| ^|^| (_) ^| (_) ^| ^|
if %WINDOWSVER% LEQ 6 echo \/    \/\__,_^|_^|\__^|_^|\__\___/ \___/^|_^|
if %WINDOWSVER% LEQ 6 echo.                            
echo.
echo NSISIFIER
set /p upd=Update? {Y/N} 
if /i %upd%==y set upid=d%time%c%random:~0,4%
if /i %upd%==y echo %upid%>%USERPROFILE%\Documents\Github\smt\Files\config\version
set /p cap=Would you like to commit to the repo? {Y/N} 
if /i %CAP%==Y set /p commitmsg=Commit message: 
if "%commitmsg%"=="" set "commitmsg=Updated the .exe Installer"
if /i %CAP%==Y set "commitdesc="
if /i %CAP%==Y set /p commitdesc=Commit description (optional): 
REM if /i %CAP%==Y if /i %upd%==y echo SMT Update logs for update ID %upid%:>"%USERPROFILE%\Documents\Github\smt\updatelogs.txt"
REM if /i %CAP%==Y if /i %upd%==y echo.>>"%USERPROFILE%\Documents\Github\smt\updatelogs.txt"
if /i %CAP%==Y if /i %upd%==y echo %commitmsg%>"%USERPROFILE%\Documents\Github\smt\updatelogs.txt"
if /i %CAP%==Y if /i %upd%==y if /i NOT "%commitdesc%"=="" echo %commitdesc%>>"%USERPROFILE%\Documents\Github\smt\updatelogs.txt"
REM if /i %CAP%==Y if /i %upd%==y echo.>>"%USERPROFILE%\Documents\Github\smt\updatelogs.txt"
REM if /i %CAP%==Y if /i %upd%==y echo Made with love by Schooi ^<3>>"%USERPROFILE%\Documents\Github\smt\updatelogs.txt"
REM if /i %CAP%==Y if /i %upd%==y echo.>>"%USERPROFILE%\Documents\Github\smt\updatelogs.txt"
REM if /i %CAP%==Y if /i %upd%==y echo https://github.com/SchooiCodes/smt>>"%USERPROFILE%\Documents\Github\smt\updatelogs.txt"
REM if /i %CAP%==Y if /i %upd%==y echo https://youtube.com/@SchooiYT>>"%USERPROFILE%\Documents\Github\smt\updatelogs.txt"
REM if /i %CAP%==Y if /i %upd%==y echo https://discord.com/users/749226175687295028>>"%USERPROFILE%\Documents\Github\smt\updatelogs.txt"
REM if /i %CAP%==Y if /i %upd%==y echo https://discord.gg/REj54yP7Qa>>"%USERPROFILE%\Documents\Github\smt\updatelogs.txt"
call "%USERPROFILE%\Documents\Github\smt\Files\ini.bat" /i usagepingsent /s Telemetry /v false %USERPROFILE%\Documents\Github\smt\Files\config\settings.ini >nul
call "%USERPROFILE%\Documents\Github\smt\Files\ini.bat" /i smtinpath /s AddedToPath /v false %USERPROFILE%\Documents\Github\smt\Files\config\settings.ini >nul
rd /s /q %USERPROFILE%\Documents\smt\app >nul
md %USERPROFILE%\Documents\smt\app >nul
xcopy %USERPROFILE%\Documents\Github\smt\* %USERPROFILE%\Documents\SMT\app\ >nul
xcopy %USERPROFILE%\Documents\Github\smt\Files %USERPROFILE%\Documents\smt\app\Files\ >nul
xcopy %USERPROFILE%\Documents\Github\smt\Files\Apps %USERPROFILE%\Documents\smt\app\Files\Apps\ >nul
xcopy %USERPROFILE%\Documents\Github\smt\Files\config %USERPROFILE%\Documents\smt\app\Files\config\ >nul
xcopy %USERPROFILE%\Documents\Github\smt\Files\Schnuker %USERPROFILE%\Documents\smt\app\Files\Schnuker\ >nul
cd %USERPROFILE%\Documents\smt\app\ >nul
if exist Installer.bat del Installer.bat >nul
if exist Uninstaller.bat del Uninstaller.bat >nul
if exist Files\IPGeolocator.exe del Files\IPGeolocator.exe >nul
if exist Files\autorespo.ps1 del Files\autorespo.ps1 >nul
if exist Files\WD.bat del Files\WD.bat >nul
if exist Files\config\old_path.txt del Files\config\old_path.txt >nul
if exist "Schooi's Multitool Setup.exe" del "Schooi's Multitool Setup.exe" >nul
cd Files >nul
REM del setup.bat >nul 2>&1
REM xcopy ..\..\..\setup.bat . >nul
cd ..
xcopy ..\..\smt.ico . >nul
"C:\Program Files (x86)\NSIS\makensis.exe" %USERPROFILE%\Documents\SMT\setup.nsi >nul
if not errorlevel 0 "C:\Program Files (x86)\NSIS\makensis.exe" %USERPROFILE%\Documents\SMT\setup.nsi
xcopy /y "%USERPROFILE%\Documents\SMT\Schooi's Multitool Setup.exe" %USERPROFILE%\Desktop\LatestSMTxNSISRelease\ >nul
xcopy /y "%USERPROFILE%\Desktop\LatestSMTxNSISRelease\Schooi's Multitool Setup.exe" "%USERPROFILE%\Documents\Github\smt\" >nul
if /i %CAP%==Y cd %USERPROFILE%\Documents\Github\smt\ & git add "*"
if /i %CAP%==Y if "%commitdesc%"=="" git commit -m "%commitmsg%"
if /i %CAP%==Y if not "%commitdesc%"=="" git commit -m "%commitmsg%" -m "%commitdesc%"
set /p push= Would you like to push too? {Y/N} 
if /i %push%==Y cd %USERPROFILE%\Documents\Github\smt\ & git add "*"
if /i %push%==Y git push
xcopy /Y %~f0 %USERPROFILE%\Documents\smt\ >nul
7z x "%USERPROFILE%\Desktop\LatestSMTxNSISRelease\Schooi's Multitool Setup.exe" -o"%USERPROFILE%\Desktop\LatestSMTxNSISRelease\Schooi's Multitool Setup" -aoa >nul
explorer "%USERPROFILE%\Desktop\LatestSMTxNSISRelease\"
call "%USERPROFILE%\Documents\Github\smt\Files\ini.bat" /i usagepingsent /s Telemetry /v true %USERPROFILE%\Documents\Github\smt\Files\config\settings.ini >nul
call "%USERPROFILE%\Documents\Github\smt\Files\ini.bat" /i smtinpath /s AddedToPath /v true %USERPROFILE%\Documents\Github\smt\Files\config\settings.ini >nul
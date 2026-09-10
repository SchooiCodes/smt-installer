@echo off
call .bat\logo.bat
echo.
echo NSISIFIER
set /p upd=Update? {Y/N} 
if /i %upd%==y set upid=d%time%c%random:~0,4%
if /i %upd%==y echo %upid%>C:\Users\Schooi\Documents\Github\smt\Files\config\version
set /p cap=Would you like to commit to the repo? {Y/N} 
if /i %CAP%==Y set /p commitmsg=Commit message: 
if "%commitmsg%"=="" set "commitmsg=Updated the .exe Installer"
if /i %CAP%==Y set "commitdesc="
if /i %CAP%==Y set /p commitdesc=Commit description (optional): 
REM if /i %CAP%==Y if /i %upd%==y echo SMT Update logs for update ID %upid%:>"C:\Users\Schooi\Documents\Github\smt\updatelogs.txt"
REM if /i %CAP%==Y if /i %upd%==y echo.>>"C:\Users\Schooi\Documents\Github\smt\updatelogs.txt"
if /i %CAP%==Y if /i %upd%==y echo %commitmsg%>"C:\Users\Schooi\Documents\Github\smt\updatelogs.txt"
if /i %CAP%==Y if /i %upd%==y if /i NOT "%commitdesc%"=="" echo %commitdesc%>>"C:\Users\Schooi\Documents\Github\smt\updatelogs.txt"
REM if /i %CAP%==Y if /i %upd%==y echo.>>"C:\Users\Schooi\Documents\Github\smt\updatelogs.txt"
REM if /i %CAP%==Y if /i %upd%==y echo Made with love by Schooi ^<3>>"C:\Users\Schooi\Documents\Github\smt\updatelogs.txt"
REM if /i %CAP%==Y if /i %upd%==y echo.>>"C:\Users\Schooi\Documents\Github\smt\updatelogs.txt"
REM if /i %CAP%==Y if /i %upd%==y echo https://github.com/SchooiCodes/smt>>"C:\Users\Schooi\Documents\Github\smt\updatelogs.txt"
REM if /i %CAP%==Y if /i %upd%==y echo https://youtube.com/@SchooiYT>>"C:\Users\Schooi\Documents\Github\smt\updatelogs.txt"
REM if /i %CAP%==Y if /i %upd%==y echo https://discord.com/users/749226175687295028>>"C:\Users\Schooi\Documents\Github\smt\updatelogs.txt"
REM if /i %CAP%==Y if /i %upd%==y echo https://discord.gg/REj54yP7Qa>>"C:\Users\Schooi\Documents\Github\smt\updatelogs.txt"
call "%USERPROFILE%\Documents\Github\smt\Files\ini.bat" /i usagepingsent /s Telemetry /v false %USERPROFILE%\Documents\Github\smt\Files\config\settings.ini >nul
call "%USERPROFILE%\Documents\Github\smt\Files\ini.bat" /i smtinpath /s AddedToPath /v false %USERPROFILE%\Documents\Github\smt\Files\config\settings.ini >nul
rd /s /q C:\Users\Schooi\Documents\smt\app >nul
md C:\Users\Schooi\Documents\smt\app >nul
xcopy C:\Users\Schooi\Documents\Github\smt\* C:\Users\Schooi\Documents\SMT\app\ >nul
xcopy C:\Users\Schooi\Documents\Github\smt\Files C:\Users\Schooi\Documents\smt\app\Files\ >nul
xcopy C:\Users\Schooi\Documents\Github\smt\Files\Apps C:\Users\Schooi\Documents\smt\app\Files\Apps\ >nul
xcopy C:\Users\Schooi\Documents\Github\smt\Files\config C:\Users\Schooi\Documents\smt\app\Files\config\ >nul
xcopy C:\Users\Schooi\Documents\Github\smt\Files\Schnuker C:\Users\Schooi\Documents\smt\app\Files\Schnuker\ >nul
cd C:\Users\Schooi\Documents\smt\app\ >nul
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
"C:\Program Files (x86)\NSIS\makensis.exe" C:\Users\Schooi\Documents\SMT\setup.nsi >nul
if not errorlevel 0 "C:\Program Files (x86)\NSIS\makensis.exe" C:\Users\Schooi\Documents\SMT\setup.nsi
xcopy /y "C:\Users\Schooi\Documents\SMT\Schooi's Multitool Setup.exe" C:\Users\Schooi\Desktop\LatestSMTxNSISRelease\ >nul
xcopy /y "C:\Users\Schooi\Desktop\LatestSMTxNSISRelease\Schooi's Multitool Setup.exe" "C:\Users\Schooi\Documents\Github\smt\" >nul
if /i %CAP%==Y cd C:\Users\Schooi\Documents\Github\smt\ & git add "*"
if /i %CAP%==Y if "%commitdesc%"=="" git commit -m "%commitmsg%"
if /i %CAP%==Y if not "%commitdesc%"=="" git commit -m "%commitmsg%" -m "%commitdesc%"
set /p push= Would you like to push too? {Y/N} 
if /i %push%==Y cd C:\Users\Schooi\Documents\Github\smt\ & git add "*"
if /i %push%==Y git push
xcopy /Y %~f0 C:\Users\Schooi\Documents\smt\ >nul
7z x "C:\Users\Schooi\Desktop\LatestSMTxNSISRelease\Schooi's Multitool Setup.exe" -o"C:\Users\Schooi\Desktop\LatestSMTxNSISRelease\Schooi's Multitool Setup" -aoa >nul
explorer "C:\Users\Schooi\Desktop\LatestSMTxNSISRelease\"
call "%USERPROFILE%\Documents\Github\smt\Files\ini.bat" /i usagepingsent /s Telemetry /v true %USERPROFILE%\Documents\Github\smt\Files\config\settings.ini >nul
call "%USERPROFILE%\Documents\Github\smt\Files\ini.bat" /i smtinpath /s AddedToPath /v true %USERPROFILE%\Documents\Github\smt\Files\config\settings.ini >nul
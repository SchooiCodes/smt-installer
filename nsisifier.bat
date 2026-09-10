@echo off
call .bat\logo.bat
echo.
echo NSISIFIER
set /p upd=Update? {Y/N} 
if /i %upd%==y set upid=d%time%c%random:~0,4%
if /i %upd%==y echo %upid%>C:\Users\User\Documents\Github\smt\Files\config\version
set /p cap=Would you like to commit to the repo? {Y/N} 
if /i %CAP%==Y set /p commitmsg=Commit message: 
if "%commitmsg%"=="" set "commitmsg=Updated the .exe Installer"
if /i %CAP%==Y if /i %upd%==y echo SMT Update logs for update ID %upid%>"C:\Users\User\Documents\Github\smt\updatelogs.txt"
if /i %CAP%==Y if /i %upd%==y echo.>>"C:\Users\User\Documents\Github\smt\updatelogs.txt"
if /i %CAP%==Y if /i %upd%==y echo %commitmsg%>>"C:\Users\User\Documents\Github\smt\updatelogs.txt"
if /i %CAP%==Y if /i %upd%==y echo.>>"C:\Users\User\Documents\Github\smt\updatelogs.txt"
if /i %CAP%==Y if /i %upd%==y echo Made with love by Schooi ^<3>>"C:\Users\User\Documents\Github\smt\updatelogs.txt"
if /i %CAP%==Y if /i %upd%==y echo.>>"C:\Users\User\Documents\Github\smt\updatelogs.txt"
if /i %CAP%==Y if /i %upd%==y echo https://github.com/smt>>"C:\Users\User\Documents\Github\smt\updatelogs.txt"
if /i %CAP%==Y if /i %upd%==y echo https://youtube.com/@SchooiYT>>"C:\Users\User\Documents\Github\smt\updatelogs.txt"
if /i %CAP%==Y if /i %upd%==y echo https://discord.com/users/749226175687295028>>"C:\Users\User\Documents\Github\smt\updatelogs.txt"
if /i %CAP%==Y if /i %upd%==y echo https://discord.gg/REj54yP7Qa>>"C:\Users\User\Documents\Github\smt\updatelogs.txt"
rd /s /q C:\Users\User\Documents\smt\app >nul
md C:\Users\User\Documents\smt\app >nul
xcopy C:\Users\User\Documents\Github\smt\* C:\Users\User\Documents\SMT\app\ >nul
xcopy C:\Users\User\Documents\Github\smt\Files C:\Users\User\Documents\smt\app\Files\ >nul
xcopy C:\Users\User\Documents\Github\smt\Files\Apps C:\Users\User\Documents\smt\app\Files\Apps\ >nul
xcopy C:\Users\User\Documents\Github\smt\Files\config C:\Users\User\Documents\smt\app\Files\config\ >nul
xcopy C:\Users\User\Documents\Github\smt\Files\Schnuker C:\Users\User\Documents\smt\app\Files\Schnuker\ >nul
cd C:\Users\User\Documents\smt\app\ >nul
del Installer.bat >nul
del Uninstaller.bat >nul
del "Schooi's Multitool Setup.exe" >nul
cd Files >nul
REM del setup.bat >nul 2>&1
REM xcopy ..\..\..\setup.bat . >nul
cd ..
xcopy ..\..\smt.ico . >nul
"C:\Program Files (x86)\NSIS\makensis.exe" C:\Users\User\Documents\SMT\setup.nsi >nul
if not errorlevel 0 "C:\Program Files (x86)\NSIS\makensis.exe" C:\Users\User\Documents\SMT\setup.nsi
xcopy /y "C:\Users\User\Documents\SMT\Schooi's Multitool Setup.exe" C:\Users\User\Desktop\LatestSMTxNSISRelease\ >nul
xcopy /y "C:\Users\User\Desktop\LatestSMTxNSISRelease\Schooi's Multitool Setup.exe" "C:\Users\User\Documents\Github\smt\" >nul
if /i %CAP%==Y cd C:\Users\User\Documents\Github\smt\ & git add "*"
if /i %CAP%==Y git commit -m "%commitmsg%" 
set /p push= Would you like to push too? {Y/N} 
if /i %push%==Y cd C:\Users\User\Documents\Github\smt\ & git add "*"
if /i %push%==Y git push
7z x "C:\Users\User\Desktop\LatestSMTxNSISRelease\Schooi's Multitool Setup.exe" -o"C:\Users\User\Desktop\LatestSMTxNSISRelease\Schooi's Multitool Setup" -aoa
explorer "C:\Users\User\Desktop\LatestSMTxNSISRelease\"

;--------------------------------
; Includes

!include "MUI2.nsh"
!include "logiclib.nsh"

;--------------------------------
; Custom defines

!define NAME "Schooi's Multitool"
!define APPFILE "SchooiMultitool.bat"
!define VERSION "2.3"
!define SLUG "${NAME} v${VERSION}"

;--------------------------------
; General

Name "${NAME}"
OutFile "${NAME} Setup.exe"
InstallDir "$PROGRAMFILES\SMT"
InstallDirRegKey HKCU "Software\SMT" ""
RequestExecutionLevel admin

;--------------------------------
; UI

!define MUI_ICON "assets\smt.ico"
!define MUI_HEADERIMAGE
!define MUI_WELCOMEFINISHPAGE_BITMAP "assets\welcome.bmp"
!define MUI_HEADERIMAGE_BITMAP "assets\head.bmp"
!define MUI_ABORTWARNING
!define MUI_WELCOMEPAGE_TITLE "${SLUG} Setup"
!define MUI_FINISHPAGE_RUN "$INSTDIR\SchooiMultitool.bat"
BrandingText "People are asking 10$ for 50 lines of code, I give you 3k for free. That's why you should use SMT.  "

;--------------------------------
; Pages

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "license.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

; Set UI language
!insertmacro MUI_LANGUAGE "English"

;--------------------------------
; Section - Install App

Section "-hidden app"
  SectionIn RO
  SetOutPath "$INSTDIR"
  CopyFiles app\needed_file.schm "$INSTDIR\"
  File /r "app\*.*"
  WriteRegStr HKCU "Software\SMT" "" $INSTDIR
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SMT" \
                 "DisplayName" "Schooi's Multitool"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SMT" \
                 "UninstallString" "$INSTDIR\Uninstall ${NAME}.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SMT" \
                 "DisplayIcon" "$INSTDIR\smt.ico"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SMT" \
                 "DisplayVersion" "2.3"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SMT" \
                 "HelpLink" "https://schooicodes.github.io/smtweb"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SMT" \
                 "Publisher" "Schooi"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SMT" \
                 "InstallLocation" "$INSTDIR"

  WriteUninstaller "$INSTDIR\Uninstall ${NAME}.exe"
SectionEnd

;--------------------------------
; Section - Shortcut

Section "Desktop Shortcut" DeskShort
  CreateShortCut "$DESKTOP\${NAME}.lnk" "$INSTDIR\${APPFILE}" "$INSTDIR\" "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.20.11781.0_x64__8wekyb3d8bbwe\WindowsTerminal.exe"
SectionEnd

;--------------------------------
; Descriptions

;Language strings
LangString DESC_DeskShort ${LANG_ENGLISH} "Creates a Desktop shortcut"

;Assign language strings to sections
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${DeskShort} $(DESC_DeskShort)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
; Function - Check if already installed

Function .onInit
  ; Check if the application is already installed	
  ReadRegStr $0 HKCU "Software\SMT" ""
  IfFileExists "$0\SchooiMultitool.bat" Installed NotInstalled

  Installed:
    MessageBox MB_YESNO|MB_ICONQUESTION "${NAME} is already installed. Would you like to uninstall?" IDNO NotInstalled
    Exec "$0\Uninstall ${NAME}.exe"
    Abort

  NotInstalled:
    ; Continue with the normal installation process
FunctionEnd

;--------------------------------
; Remove empty parent directories

Function un.RMDirUP
  !define RMDirUP '!insertmacro RMDirUPCall'

  !macro RMDirUPCall _PATH
        push '${_PATH}'
        Call un.RMDirUP
  !macroend

  ; $0 - current folder
  ClearErrors

  Exch $0
  ;DetailPrint "ASDF - $0\.."
  RMDir "$0\.."

  IfErrors Skip
  ${RMDirUP} "$0\.."
  Skip:

  Pop $0

FunctionEnd

;--------------------------------
; Section - Uninstaller

Section "Uninstall"

  ;Delete Shortcut
  Delete "$DESKTOP\${NAME}.lnk"

  ;Delete Uninstall
  Delete "$INSTDIR\Uninstall ${NAME}.exe"

  ;Delete Folder
  RMDir /r "$INSTDIR"
  ${RMDirUP} "$INSTDIR"

  DeleteRegKey /ifempty HKCU "Software\SMT"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SMT"

SectionEnd

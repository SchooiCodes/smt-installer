;--------------------------------
; Includes

!include "MUI2.nsh"
!include "logiclib.nsh"
!include "UninstallLog.nsh"

;--------------------------------
; Configure UnInstall log to only remove what is installed

  ;Set the name of the uninstall log
    !define UninstLog "uninstall.log"
    Var UninstLog
  ;The root registry to write to
    !define REG_ROOT "HKLM"
  ;The registry path to write to
    !define REG_APP_PATH "SOFTWARE\appname"
 
  ;Uninstall log file missing.
    LangString UninstLogMissing ${LANG_ENGLISH} "${UninstLog} not found!$\r$\nUninstallation cannot proceed!"
 
  ;AddItem macro
    !define AddItem "!insertmacro AddItem"
 
  ;BackupFile macro
    !define BackupFile "!insertmacro BackupFile" 
 
  ;BackupFiles macro
    !define BackupFiles "!insertmacro BackupFiles" 
 
  ;Copy files macro
    !define CopyFiles "!insertmacro CopyFiles"
 
  ;CreateDirectory macro
    !define CreateDirectory "!insertmacro CreateDirectory"
 
  ;CreateShortcut macro
    !define CreateShortcut "!insertmacro CreateShortcut"
 
  ;File macro
    !define File "!insertmacro File"
 
  ;Rename macro
    !define Rename "!insertmacro Rename"
 
  ;RestoreFile macro
    !define RestoreFile "!insertmacro RestoreFile"    
 
  ;RestoreFiles macro
    !define RestoreFiles "!insertmacro RestoreFiles"
 
  ;SetOutPath macro
    !define SetOutPath "!insertmacro SetOutPath"
 
  ;WriteRegDWORD macro
    !define WriteRegDWORD "!insertmacro WriteRegDWORD" 
 
  ;WriteRegStr macro
    !define WriteRegStr "!insertmacro WriteRegStr"
 
  ;WriteUninstaller macro
    !define WriteUninstaller "!insertmacro WriteUninstaller"
 
  Section -openlogfile
    CreateDirectory "$INSTDIR"
    IfFileExists "$INSTDIR\${UninstLog}" +3
      FileOpen $UninstLog "$INSTDIR\${UninstLog}" w
    Goto +4
      SetFileAttributes "$INSTDIR\${UninstLog}" NORMAL
      FileOpen $UninstLog "$INSTDIR\${UninstLog}" a
      FileSeek $UninstLog 0 END
  SectionEnd

;--------------------------------
; Custom defines

!define NAME "Schooi's Multitool"
!define APPFile "SchooiMultitool.bat"
!define VERSION "2.3"
!define SLUG "${NAME} v${VERSION}"

;--------------------------------
; General

Name "${NAME}"
OutFile "${NAME} Setup.exe"
InstallDir "C:\Program Files\SMT"
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
  ${SetOutPath} "$INSTDIR"
  ${CopyFiles} app\needed_File.schm "C:\Program Files\SMT\"
  ${File} /r "app\*.*"
  Exec '"start" /MIN "cmd" /c "powershell -Command "Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force;"'
  Exec '"start" /MIN "taskkill" /f /im "cmd.exe"'
  ${WriteRegStr} HKCU "Software\SMT" "" $INSTDIR
  ${WriteRegStr} HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SMT" \
                 "DisplayName" "Schooi's Multitool"
  ${WriteRegStr} HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SMT" \
                 "UninstallString" "$INSTDIR\Uninstall ${NAME}.exe"
  ${WriteRegStr} HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SMT" \
                 "DisplayIcon" "$INSTDIR\smt.ico"
  ${WriteRegStr} HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SMT" \
                 "DisplayVersion" "2.3"
  ${WriteRegStr} HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SMT" \
                 "HelpLink" "https://schooicodes.github.io/smtweb"
  ${WriteRegStr} HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SMT" \
                 "Publisher" "Schooi"
  ${WriteRegStr} HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SMT" \
                 "InstallLocation" "$INSTDIR"
  WriteUninstaller "$INSTDIR\Uninstall ${NAME}.exe"
SectionEnd

;--------------------------------
; Section - Shortcut

Section "Desktop Shortcut" DeskShort
  ${CreateShortcut} "$DESKTOP\${NAME}.lnk" "$INSTDIR\${APPFILE}" "$INSTDIR\" "$INSTDIR\smt.ico" 0
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
	IfFileExists "$TEMP\SMT\SkipMSGBox" Skip DontSkip
	DontSkip:
		MessageBox MB_YESNO|MB_ICONQUESTION "${NAME} is already installed. Would you like to uninstall?" IDNO NotInstalled
		Exec "$0\Uninstall ${NAME}.exe"
		Abort
	Skip:
		
	

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

; ;--------------------------------
; ; Section - Uninstaller

; Section "Uninstall"

  ; ;Delete Shortcut
  ; Delete "$DESKTOP\${NAME}.lnk"

  ; ;Delete Uninstall
  ; Delete "$INSTDIR\Uninstall ${NAME}.exe"

  ; ;Delete Folder
  ; RMDir /r "$INSTDIR"
  ; ${RMDirUP} "$INSTDIR"

  ; DeleteRegKey /ifempty HKCU "Software\SMT"
  ; DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SMT"

; SectionEnd

;--------------------------------
; Uninstaller

Section Uninstall
  ;Can't uninstall if uninstall log is missing!
  IfFileExists "$INSTDIR\${UninstLog}" +3
    MessageBox MB_OK|MB_ICONSTOP "$(UninstLogMissing)"
      Abort
 
  Push $R0
  Push $R1
  Push $R2
  SetFileAttributes "$INSTDIR\${UninstLog}" NORMAL
  FileOpen $UninstLog "$INSTDIR\${UninstLog}" r
  StrCpy $R1 -1
 
  GetLineCount:
    ClearErrors
    FileRead $UninstLog $R0
    IntOp $R1 $R1 + 1
    StrCpy $R0 $R0 -2
    Push $R0   
    IfErrors 0 GetLineCount
 
  Pop $R0
 
  LoopRead:
    StrCmp $R1 0 LoopDone
    Pop $R0
 
    IfFileExists "$R0\*.*" 0 +3
      RMDir $R0  #is dir
    Goto +9
    IfFileExists $R0 0 +3
      Delete $R0 #is file
    Goto +6
    StrCmp $R0 "${REG_ROOT} ${REG_APP_PATH}" 0 +3
      DeleteRegKey ${REG_ROOT} "${REG_APP_PATH}" #is Reg Element
    Goto +3
    StrCmp $R0 "${REG_ROOT} ${UNINSTALL_PATH}" 0 +2
      DeleteRegKey ${REG_ROOT} "${UNINSTALL_PATH}" #is Reg Element
 
    IntOp $R1 $R1 - 1
    Goto LoopRead
  LoopDone:
  FileClose $UninstLog
  Delete "$INSTDIR\${UninstLog}"
  RMDir "$INSTDIR"
  Pop $R2
  Pop $R1
  Pop $R0
  DeleteRegKey HKCU "Software\SMT"
 
  ;Remove registry keys
    ;DeleteRegKey ${REG_ROOT} "${REG_APP_PATH}"
    ;DeleteRegKey ${REG_ROOT} "${UNINSTALL_PATH}"
SectionEnd

; MagicCapsLock Installer
; NSIS Script

Unicode true

!include "MUI2.nsh"
!include "FileFunc.nsh"
!include "x64.nsh"

; Installer Information
Name "MagicCapsLock"
OutFile "MagicCapsLock_Setup.exe"
InstallDir "$LOCALAPPDATA\MagicCapsLock"
InstallDirRegKey HKCU "Software\MagicCapsLock" "InstallDir"
RequestExecutionLevel user  ; Only requires user privileges

; Version Information
VIProductVersion "1.1.0.0"
VIAddVersionKey "ProductName" "MagicCapsLock"
VIAddVersionKey "FileDescription" "MagicCapsLock Installer"
VIAddVersionKey "LegalCopyright" "Copyright (c) 2025 superhello2099"
VIAddVersionKey "FileVersion" "1.1.0"
VIAddVersionKey "ProductVersion" "1.1.0"

; Include AutoHotkey Runtime Installer
!define AHK_SETUP "ahk-v2.0.2-setup.exe"

; Interface Settings
!define MUI_ICON "assets\logo.ico"
!define MUI_UNICON "assets\logo.ico"
!define MUI_ABORTWARNING

; Welcome Page Text
!define MUI_WELCOMEPAGE_TITLE "Welcome to MagicCapsLock Setup"
!define MUI_WELCOMEPAGE_TEXT "This will install MagicCapsLock v1.1.0 on your computer.$\n$\nIf AutoHotkey is not installed, the installer will install it automatically.$\n$\nClick Next to continue."

; Interface Pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "LICENSE"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!define MUI_FINISHPAGE_RUN "$INSTDIR\magic_capslock.ahk"
!define MUI_FINISHPAGE_RUN_TEXT "Run MagicCapsLock now"
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\README.txt"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "View Instructions"
!insertmacro MUI_PAGE_FINISH

; Uninstall Pages
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

; Language Settings
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "SimpChinese"

; Logging
!define LOGFILE "$TEMP\MagicCapsLock_install.log"

Function .onInit
  ; Check if already running
  System::Call 'kernel32::CreateMutexA(i 0, i 0, t "MagicCapsLockInstaller") i .r1 ?e'
  Pop $R0
  StrCmp $R0 0 +3
    MessageBox MB_OK|MB_ICONEXCLAMATION "The installer is already running."
    Abort
    
  ; Check Windows version
  ReadRegStr $R0 HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion" "CurrentVersion"
  StrCmp $R0 "" WinVersionError
  Goto ContinueInstall
  
  WinVersionError:
    MessageBox MB_OK|MB_ICONSTOP "This program requires Windows 7 or later."
    Abort
    
  ContinueInstall:
FunctionEnd

; Main Installation Section
Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  
  ; Copy main script
  File "magic_capslock.ahk"
  
  ; Create start menu shortcut
  CreateDirectory "$SMPROGRAMS\MagicCapsLock"
  CreateShortcut "$SMPROGRAMS\MagicCapsLock\MagicCapsLock.lnk" "$INSTDIR\magic_capslock.ahk"
  
  ; Create uninstaller
  WriteUninstaller "$INSTDIR\uninstall.exe"
  
  ; Create startup shortcut
  CreateShortcut "$SMSTARTUP\MagicCapsLock.lnk" "$INSTDIR\magic_capslock.ahk"
  
  ; Write uninstall information
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\MagicCapsLock" "DisplayName" "MagicCapsLock"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\MagicCapsLock" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\MagicCapsLock" "InstallLocation" "$INSTDIR"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\MagicCapsLock" "DisplayIcon" "$INSTDIR\magic_capslock.ahk"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\MagicCapsLock" "Publisher" "superhello2099"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\MagicCapsLock" "DisplayVersion" "1.1.0"
  
  ; Create README
  FileOpen $0 "$INSTDIR\README.txt" w
  FileWrite $0 "MagicCapsLock v1.1.0$\n$\n"
  FileWrite $0 "Installation Directory: $INSTDIR$\n$\n"
  FileWrite $0 "Shortcuts:$\n"
  FileWrite $0 "- Start Menu: $SMPROGRAMS\MagicCapsLock\MagicCapsLock.lnk$\n"
  FileWrite $0 "- Startup: $SMSTARTUP\MagicCapsLock.lnk$\n$\n"
  FileWrite $0 "Hotkeys:$\n"
  FileWrite $0 "- CapsLock + F1: Show all hotkeys$\n"
  FileWrite $0 "- CapsLock + F2: Toggle CapsLock$\n"
  FileWrite $0 "- CapsLock + F3: Toggle NumLock$\n"
  FileWrite $0 "- CapsLock + F4: Toggle ScrollLock$\n"
  FileWrite $0 "- CapsLock + F5: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + F6: Toggle all locks (with notification)$\n"
  FileWrite $0 "- CapsLock + F7: Toggle all locks (with sound)$\n"
  FileWrite $0 "- CapsLock + F8: Toggle all locks (with notification and sound)$\n"
  FileWrite $0 "- CapsLock + F9: Toggle all locks (with notification and sound)$\n"
  FileWrite $0 "- CapsLock + F10: Toggle all locks (with notification and sound)$\n"
  FileWrite $0 "- CapsLock + F11: Toggle all locks (with notification and sound)$\n"
  FileWrite $0 "- CapsLock + F12: Toggle all locks (with notification and sound)$\n"
  FileWrite $0 "- CapsLock + Tab: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Space: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Enter: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Backspace: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Delete: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Insert: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Home: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + End: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + PageUp: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + PageDown: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Left: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Right: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Up: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Down: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + 1: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + 2: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + 3: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + 4: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + 5: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + 6: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + 7: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + 8: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + 9: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + 0: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + -: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + =: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + [: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + ]: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + \: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + ;: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + ': Toggle all locks$\n"
  FileWrite $0 "- CapsLock + ,: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + .: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + /: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + `: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + F1: Show all hotkeys$\n"
  FileWrite $0 "- CapsLock + Shift + F2: Toggle CapsLock$\n"
  FileWrite $0 "- CapsLock + Shift + F3: Toggle NumLock$\n"
  FileWrite $0 "- CapsLock + Shift + F4: Toggle ScrollLock$\n"
  FileWrite $0 "- CapsLock + Shift + F5: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + F6: Toggle all locks (with notification)$\n"
  FileWrite $0 "- CapsLock + Shift + F7: Toggle all locks (with sound)$\n"
  FileWrite $0 "- CapsLock + Shift + F8: Toggle all locks (with notification and sound)$\n"
  FileWrite $0 "- CapsLock + Shift + F9: Toggle all locks (with notification and sound)$\n"
  FileWrite $0 "- CapsLock + Shift + F10: Toggle all locks (with notification and sound)$\n"
  FileWrite $0 "- CapsLock + Shift + F11: Toggle all locks (with notification and sound)$\n"
  FileWrite $0 "- CapsLock + Shift + F12: Toggle all locks (with notification and sound)$\n"
  FileWrite $0 "- CapsLock + Shift + Tab: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + Space: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + Enter: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + Backspace: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + Delete: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + Insert: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + Home: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + End: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + PageUp: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + PageDown: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + Left: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + Right: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + Up: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + Down: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + 1: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + 2: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + 3: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + 4: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + 5: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + 6: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + 7: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + 8: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + 9: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + 0: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + -: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + =: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + [: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + ]: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + \: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + ;: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + ': Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + ,: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + .: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + /: Toggle all locks$\n"
  FileWrite $0 "- CapsLock + Shift + `: Toggle all locks$\n"
  FileClose $0
SectionEnd

; AutoHotkey Installation Section
Section "Install AutoHotkey" SecAHK
  ; Check if AutoHotkey is installed
  IfFileExists "$PROGRAMFILES\AutoHotkey\AutoHotkey.exe" AHKInstalled
  
  ; Extract AutoHotkey installer
  SetOutPath "$TEMP"
  File "ahk-v2.0.2-setup.exe"
  
  ; Install AutoHotkey (silent)
  DetailPrint "Installing AutoHotkey..."
  ExecWait '"$TEMP\ahk-v2.0.2-setup.exe" /S' $0
  DetailPrint "AutoHotkey installation complete"
  
  AHKInstalled:
SectionEnd

; Uninstall Section
Section "Uninstall"
  ; Stop running processes
  nsExec::Exec 'taskkill /f /im "AutoHotkey.exe"'
  
  ; Remove created files
  Delete "$INSTDIR\magic_capslock.ahk"
  Delete "$INSTDIR\README.txt"
  Delete "$INSTDIR\LICENSE"
  Delete "$INSTDIR\uninstall.exe"
  RMDir /r "$INSTDIR\assets"
  RMDir "$INSTDIR"
  
  ; Remove shortcuts
  Delete "$SMPROGRAMS\MagicCapsLock\MagicCapsLock.lnk"
  Delete "$SMPROGRAMS\MagicCapsLock\Uninstall.lnk"
  RMDir "$SMPROGRAMS\MagicCapsLock"
  Delete "$SMSTARTUP\MagicCapsLock.lnk"
  
  ; Remove registry keys
  DeleteRegKey HKCU "Software\MagicCapsLock"
  DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\MagicCapsLock"
  
  ; Show uninstall completion message
  MessageBox MB_OK|MB_ICONINFORMATION "MagicCapsLock has been successfully uninstalled."
SectionEnd 
; MagicCapsLock安装程序
; NSIS脚本

!include "MUI2.nsh"
!include "FileFunc.nsh"
!include "x64.nsh"

; 定义安装程序信息
Name "MagicCapsLock"
OutFile "MagicCapsLock_Setup.exe"
InstallDir "$LOCALAPPDATA\MagicCapsLock"
InstallDirRegKey HKCU "Software\MagicCapsLock" "InstallDir"
RequestExecutionLevel user  ; 使用用户权限即可，无需管理员权限

; 定义版本信息
VIProductVersion "1.1.0.0"
VIAddVersionKey "ProductName" "MagicCapsLock"
VIAddVersionKey "FileDescription" "MagicCapsLock Installer"
VIAddVersionKey "LegalCopyright" "Copyright (c) 2025 superhello2099"
VIAddVersionKey "FileVersion" "1.1.0"
VIAddVersionKey "ProductVersion" "1.1.0"

; 包含AutoHotkey运行时安装程序
!define AHK_SETUP "ahk-v2.0.2-setup.exe"

; 界面设置
!define MUI_ICON "assets\logo.svg"  ; 临时使用SVG文件
!define MUI_UNICON "assets\logo.svg"
!define MUI_WELCOMEFINISHPAGE_BITMAP "assets\logo.svg"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP "assets\logo.svg"
!define MUI_ABORTWARNING

; 欢迎页面文字
!define MUI_WELCOMEPAGE_TITLE "欢迎安装 MagicCapsLock"
!define MUI_WELCOMEPAGE_TEXT "这将安装 MagicCapsLock v1.1.0 到您的计算机。$\n$\n如果您没有安装 AutoHotkey，安装程序会自动为您安装。$\n$\n点击 [下一步] 继续。"

; 界面页面
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "LICENSE"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!define MUI_FINISHPAGE_RUN "$INSTDIR\magic_capslock.ahk"
!define MUI_FINISHPAGE_RUN_TEXT "立即运行 MagicCapsLock"
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\README.txt"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "查看使用说明"
!insertmacro MUI_PAGE_FINISH

; 卸载页面
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

; 语言设置
!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_LANGUAGE "English"

Function .onInit
  ; 检查是否已经在运行
  System::Call 'kernel32::CreateMutexA(i 0, i 0, t "MagicCapsLockInstaller") i .r1 ?e'
  Pop $R0
  StrCmp $R0 0 +3
    MessageBox MB_OK|MB_ICONEXCLAMATION "安装程序已经在运行中。"
    Abort
    
  ; 检查Windows版本
  ${If} ${AtLeastWin7}
    ; Windows 7 或更高版本，继续安装
  ${Else}
    MessageBox MB_OK|MB_ICONSTOP "此程序需要 Windows 7 或更高版本。"
    Abort
  ${EndIf}
FunctionEnd

; 安装部分
Section "安装MagicCapsLock" SecInstall
  SetOutPath "$INSTDIR"
  
  ; 关闭正在运行的实例
  nsExec::Exec 'taskkill /f /im "AutoHotkey.exe"'
  
  ; 提取文件
  File "magic_capslock.ahk"
  File "LICENSE"
  File "README.md"
  File /r "assets"
  
  ; 创建README.txt
  FileOpen $0 "$INSTDIR\README.txt" w
  FileWrite $0 "MagicCapsLock 使用指南$\r$\n"
  FileWrite $0 "===================$\r$\n$\r$\n"
  FileWrite $0 "快速开始:$\r$\n"
  FileWrite $0 "1. 按下 CapsLock + F1 查看所有快捷键$\r$\n"
  FileWrite $0 "2. 连按三次 CapsLock 切换大写锁定$\r$\n"
  FileWrite $0 "3. 程序已添加到开机启动项$\r$\n$\r$\n"
  FileWrite $0 "更多信息请访问: https://github.com/superhello2099/MagicCapsLock$\r$\n"
  FileClose $0
  
  ; 写入注册表
  WriteRegStr HKCU "Software\MagicCapsLock" "InstallDir" $INSTDIR
  WriteRegStr HKCU "Software\MagicCapsLock" "Version" "1.1.0"
  
  ; 创建卸载信息
  WriteUninstaller "$INSTDIR\uninstall.exe"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\MagicCapsLock" "DisplayName" "MagicCapsLock"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\MagicCapsLock" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\MagicCapsLock" "DisplayIcon" "$INSTDIR\assets\logo.svg"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\MagicCapsLock" "Publisher" "superhello2099"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\MagicCapsLock" "URLInfoAbout" "https://github.com/superhello2099/MagicCapsLock"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\MagicCapsLock" "DisplayVersion" "1.1.0"
  ${GetSize} "$INSTDIR" "/S=0K" $0 $1 $2
  IntFmt $0 "0x%08X" $0
  WriteRegDWORD HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\MagicCapsLock" "EstimatedSize" "$0"
  
  ; 创建开始菜单快捷方式
  CreateDirectory "$SMPROGRAMS\MagicCapsLock"
  CreateShortCut "$SMPROGRAMS\MagicCapsLock\MagicCapsLock.lnk" "$INSTDIR\magic_capslock.ahk" "" "$INSTDIR\assets\logo.svg"
  CreateShortCut "$SMPROGRAMS\MagicCapsLock\卸载.lnk" "$INSTDIR\uninstall.exe"
  
  ; 创建开机启动项
  CreateShortCut "$SMSTARTUP\MagicCapsLock.lnk" "$INSTDIR\magic_capslock.ahk" "" "$INSTDIR\assets\logo.svg"
  
  ; 显示安装完成信息
  MessageBox MB_OK|MB_ICONINFORMATION "安装完成！$\n$\n按下 CapsLock + F1 查看所有快捷键。"
SectionEnd

; 安装AutoHotkey部分
Section "安装AutoHotkey" SecAHK
  ; 检查是否已安装AutoHotkey
  IfFileExists "$PROGRAMFILES\AutoHotkey\AutoHotkey.exe" AHKInstalled
  
  ; 提取AutoHotkey安装程序
  SetOutPath "$TEMP"
  File "${AHK_SETUP}"
  
  ; 安装AutoHotkey (无提示)
  DetailPrint "正在安装AutoHotkey..."
  ExecWait '"$TEMP\${AHK_SETUP}" /S' $0
  DetailPrint "AutoHotkey安装完成"
  
  AHKInstalled:
SectionEnd

; 卸载部分
Section "Uninstall"
  ; 停止运行中的进程
  nsExec::Exec 'taskkill /f /im "AutoHotkey.exe"'
  
  ; 删除创建的文件
  Delete "$INSTDIR\magic_capslock.ahk"
  Delete "$INSTDIR\README.txt"
  Delete "$INSTDIR\LICENSE"
  Delete "$INSTDIR\uninstall.exe"
  RMDir /r "$INSTDIR\assets"
  RMDir "$INSTDIR"
  
  ; 删除快捷方式
  Delete "$SMPROGRAMS\MagicCapsLock\MagicCapsLock.lnk"
  Delete "$SMPROGRAMS\MagicCapsLock\卸载.lnk"
  RMDir "$SMPROGRAMS\MagicCapsLock"
  Delete "$SMSTARTUP\MagicCapsLock.lnk"
  
  ; 删除注册表项
  DeleteRegKey HKCU "Software\MagicCapsLock"
  DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\MagicCapsLock"
  
  ; 显示卸载完成信息
  MessageBox MB_OK|MB_ICONINFORMATION "MagicCapsLock 已成功卸载。"
SectionEnd 

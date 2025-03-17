; ====================================================================================
; MagicCapsLock - 2024年3月17日
; 功能：将CapsLock键完全改造为修饰键，使用连按三次CapsLock来切换大小写
; 版本：v1.0.2
; ====================================================================================
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
FileEncoding, UTF-8

#SingleInstance Force
SetCapsLockState, AlwaysOff
SetKeyDelay, 0

; 全局变量，用于跟踪CapsLock按下次数和时间
global capsCount := 0
global lastCapsTime := 0

; ====================================================================================
; 光标移动
; ====================================================================================
CapsLock & f::Send, {Right}
CapsLock & b::Send, {Left}
CapsLock & u::Send, {Up}
CapsLock & n::Send, {Down}
CapsLock & p::Send, ^{Right}
CapsLock & o::Send, ^{Left}

; ====================================================================================
; 文本编辑
; ====================================================================================
CapsLock & h::Send, {Backspace}
CapsLock & d::Send, {Delete}
CapsLock & k::Send, ^{Delete}
CapsLock & l::Send, +{End}{Delete}
CapsLock & x::Send, {Home}+{End}^x{Delete}
CapsLock & [::Send, +{Tab}
CapsLock & ]::Send, {Tab}

; ====================================================================================
; 导航控制
; ====================================================================================
CapsLock & a::Send, {Home}
CapsLock & e::Send, {End}
CapsLock & v::Send, {PgDn}      ; 使用v作为PageDown
CapsLock & t::Send, {PgUp}      ; 使用t作为PageUp

; ====================================================================================
; 新增功能 (i, m, y键)
; ====================================================================================
CapsLock & i::Send, {Home}+{End}       ; 选择当前行内容
CapsLock & m::WinMinimize, A           ; 最小化当前窗口
CapsLock & y::Send, ^y                 ; 重做操作(Ctrl+Y)

; ====================================================================================
; 文本选择 - 使用CapsLock+q进入选择模式
; ====================================================================================
CapsLock & q::
 Send, {Shift Down}
 KeyWait, CapsLock
 Send, {Shift Up}
Return

; ====================================================================================
; 增值功能
; ====================================================================================
; 窗口置顶/取消置顶
CapsLock & w::WinSet, AlwaysOnTop, Toggle, A

; 复制并打开Perplexity
CapsLock & s::
 Send, ^c
 Sleep, 30
 Run, https://www.perplexity.ai
Return

; 复制并用Google搜索选中文本
CapsLock & g::
 Send, ^c
 Sleep, 30
 Run, https://www.google.com/search?q=%clipboard%,, Max UseErrorLevel
Return

; 回车键
CapsLock & r::Send, {Enter}
; 将 Caps Lock + Z 组合键映射为 Esc 键
CapsLock & z::Esc

; 智能 URL 打开
CapsLock & c::
{
    ; 保存当前剪贴板内容
    ClipSaved := ClipboardAll()
    A_Clipboard := ""
    
    ; 复制选中内容
    Send ^c
    if !ClipWait(1)
        return
        
    text := A_Clipboard
    
    ; 检查是否为URL（包括无协议的域名）
    if RegExMatch(text, "^(https?://|www\.|[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+)")
    {
        ; 如果没有协议前缀，添加https://
        if !RegExMatch(text, "^https?://")
            text := "https://" text
            
        try {
            Run text,, "Max"
            ToolTip "正在打开: " text
            SetTimer RemoveToolTip, -1000
        } catch {
            ToolTip "无法打开URL: " text
            SetTimer RemoveToolTip, -2000
        }
    } else {
        ToolTip "未检测到有效URL"
        SetTimer RemoveToolTip, -1000
    }
    
    ; 恢复剪贴板
    A_Clipboard := ClipSaved
    ClipSaved := ""
}

; 小写转大写
CapsLock & .::
Send, ^x
Sleep, 50
StringUpper, clipboard, clipboard
Send, ^v
Return

; 大写转小写
CapsLock & ,::
Send, ^x
Sleep, 50
StringLower, clipboard, clipboard
Send, ^v
Return

; 首字母大写
CapsLock & /::
Send, ^x
Sleep, 50
clipboard := RegExReplace(clipboard, "^(.)", "$U1")
Send, ^v
Return

; 往前删除一个词
CapsLock & j::Send, ^{Backspace}

; 快速插入当前日期
CapsLock & `::
FormatTime, CurrentDate,, yyyy-MM-dd
SendInput, %CurrentDate%{Space}
Return

; ====================================================================================
; F1帮助功能 - 显示所有快捷键
; ====================================================================================
CapsLock & F1::
  Gui, Destroy
  Gui, +AlwaysOnTop
  Gui, Margin, 10, 10
  Gui, Color, FFFFFF
  
  ; 使用英文字体避免中文乱码问题
  Gui, Font, s10 c000000, Segoe UI
  Gui, Add, Text, x10 y10 w580, CapsLock Enhance Script - Shortcuts Guide
  Gui, Font, s9, Consolas
  
  Gui, Add, GroupBox, x10 y30 w280 h180, Cursor Movement
  Gui, Add, Text, x20 y50 w260, CapsLock + f     -> Right
  Gui, Add, Text, x20 y70 w260, CapsLock + b     -> Left
  Gui, Add, Text, x20 y90 w260, CapsLock + u     -> Up
  Gui, Add, Text, x20 y110 w260, CapsLock + n     -> Down
  Gui, Add, Text, x20 y130 w260, CapsLock + p     -> Word Right
  Gui, Add, Text, x20 y150 w260, CapsLock + o     -> Word Left
  Gui, Add, Text, x20 y170 w260, CapsLock + a/e   -> Home/End
  Gui, Add, Text, x20 y190 w260, CapsLock + t/v   -> Page Up/Down
  
  Gui, Add, GroupBox, x300 y30 w280 h180, Text Editing
  Gui, Add, Text, x310 y50 w260, CapsLock + h     -> Backspace
  Gui, Add, Text, x310 y70 w260, CapsLock + d     -> Delete
  Gui, Add, Text, x310 y90 w260, CapsLock + k     -> Delete Word Right
  Gui, Add, Text, x310 y110 w260, CapsLock + j     -> Delete Word Left
  Gui, Add, Text, x310 y130 w260, CapsLock + l     -> Delete to End
  Gui, Add, Text, x310 y150 w260, CapsLock + x     -> Cut Line
  Gui, Add, Text, x310 y170 w260, CapsLock + [/]   -> Indent Left/Right
  Gui, Add, Text, x310 y190 w260, CapsLock + .     -> To UPPERCASE
  
  Gui, Add, GroupBox, x10 y220 w280 h160, Selection & Formatting
  Gui, Add, Text, x20 y240 w260, CapsLock + q     -> Selection Mode
  Gui, Add, Text, x20 y260 w260, CapsLock + i     -> Select Current Line
  Gui, Add, Text, x20 y280 w260, CapsLock + .     -> To UPPERCASE
  Gui, Add, Text, x20 y300 w260, CapsLock + ,     -> To lowercase
  Gui, Add, Text, x20 y320 w260, CapsLock + /     -> Capitalize First
  Gui, Add, Text, x20 y340 w260, CapsLock (3 times) -> Toggle CapsLock
  
  Gui, Add, GroupBox, x300 y220 w280 h160, Other Functions
  Gui, Add, Text, x310 y240 w260, CapsLock + w     -> Window Always on Top
  Gui, Add, Text, x310 y260 w260, CapsLock + m     -> Minimize Window
  Gui, Add, Text, x310 y280 w260, CapsLock + s     -> Open Perplexity
  Gui, Add, Text, x310 y300 w260, CapsLock + g     -> Search Selected Text
  Gui, Add, Text, x310 y320 w260, CapsLock + c     -> Smart URL Open
  Gui, Add, Text, x310 y340 w260, CapsLock + r     -> Enter Key
  Gui, Add, Text, x310 y360 w260, CapsLock + z     -> Esc Key
  Gui, Add, Text, x310 y380 w260, CapsLock + `     -> Insert Date
  
  Gui, Add, Button, x250 y410 w100 h30 gCloseHelp, Close
  
  Gui, Show, w590 h450, CapsLock Enhanced Script Help
Return

CloseHelp:
  Gui, Destroy
Return

; ====================================================================================
; 连按三次CapsLock切换大小写锁定状态(缩短时间间隔)
; ====================================================================================
CapsLock::
 currentTime := A_TickCount
 
 ; 将时间间隔缩短为300毫秒
 if (currentTime - lastCapsTime > 300)
   capsCount := 0
 
 ; 增加计数
 capsCount := capsCount + 1
 
 ; 记录这次按下的时间
 lastCapsTime := currentTime
 
 ; 如果连按三次，切换CapsLock状态
 if (capsCount >= 3) {
   if GetKeyState("CapsLock", "T") = 1
     SetCapsLockState, off
   else
     SetCapsLockState, on
   ToolTip, CapsLock状态已切换为: %A_IsCapsLockOn%
   SetTimer, RemoveToolTip, 1000
   capsCount := 0  ; 重置计数
 }
Return

RemoveToolTip:
 ToolTip
 SetTimer, RemoveToolTip, Off
Return

; ====================================================================================
; 鼠标快速滚动
; ====================================================================================

; 使用CapsLock + 鼠标滚轮实现翻页效果
; 向上滚动时翻上一页
CapsLock & WheelUp::
    Send, {PgUp}
Return

; 向下滚动时翻下一页
CapsLock & WheelDown::
    Send, {PgDn}
Return
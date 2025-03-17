#Requires AutoHotkey v2.0
#SingleInstance Force

; ====================================================================================
; MagicCapsLock - 2024年3月17日
; 功能：将CapsLock键完全改造为修饰键，使用连按三次CapsLock来切换大小写
; 版本：v1.0.4
; ====================================================================================

; 初始化设置
SetWorkingDir A_ScriptDir
SetCapsLockState "AlwaysOff"

; 全局变量，用于跟踪CapsLock按下次数和时间
global capsCount := 0
global lastCapsTime := 0

; ====================================================================================
; 光标移动
; ====================================================================================
CapsLock & f::Send "{Right}"
CapsLock & b::Send "{Left}"
CapsLock & u::Send "{Up}"
CapsLock & n::Send "{Down}"
CapsLock & p::Send "^{Right}"
CapsLock & o::Send "^{Left}"

; ====================================================================================
; 文本编辑
; ====================================================================================
CapsLock & h::Send "{Backspace}"
CapsLock & d::Send "{Delete}"
CapsLock & k::Send "^{Delete}"
CapsLock & l::Send "+{End}{Delete}"
CapsLock & x::Send "{Home}+{End}^x{Delete}"
CapsLock & [::Send "+{Tab}"
CapsLock & ]::Send "{Tab}"

; ====================================================================================
; 导航控制
; ====================================================================================
CapsLock & a::Send "{Home}"
CapsLock & e::Send "{End}"
CapsLock & v::Send "{PgDn}"      ; 使用v作为PageDown
CapsLock & t::Send "{PgUp}"      ; 使用t作为PageUp

; ====================================================================================
; 新增功能 (i, m, y键)
; ====================================================================================
CapsLock & i::Send "{Home}+{End}"       ; 选择当前行内容
CapsLock & m::WinMinimize "A"           ; 最小化当前窗口
CapsLock & y::Send "^y"                 ; 重做操作(Ctrl+Y)

; ====================================================================================
; 文本选择 - 使用CapsLock+q进入选择模式
; ====================================================================================
CapsLock & q::{
    Send "{Shift Down}"
    KeyWait "CapsLock"
    Send "{Shift Up}"
}

; ====================================================================================
; 增值功能
; ====================================================================================
; 窗口置顶/取消置顶
CapsLock & w::WinSetAlwaysOnTop -1, "A"

; 复制并打开Perplexity
CapsLock & s::{
    Send "^c"
    Sleep 30
    Run "https://www.perplexity.ai"
}

; 复制并用Google搜索选中文本
CapsLock & g::{
    Send "^c"
    Sleep 30
    Run "https://www.google.com/search?q=" A_Clipboard
}

; 回车键
CapsLock & r::Send "{Enter}"

; 将 Caps Lock + Z 组合键映射为 Esc 键
CapsLock & z::Send "{Esc}"

; 智能 URL 打开
CapsLock & c::{
    ; 保存当前剪贴板内容
    ClipSaved := A_Clipboard
    A_Clipboard := ""
    
    ; 复制选中内容
    Send "^c"
    if !ClipWait(1)
    {
        A_Clipboard := ClipSaved
        return
    }
        
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
            SetTimer () => ToolTip(), -1000
        } catch {
            ToolTip "无法打开URL: " text
            SetTimer () => ToolTip(), -2000
        }
    } else {
        ToolTip "未检测到有效URL"
        SetTimer () => ToolTip(), -1000
    }
    
    ; 恢复剪贴板
    A_Clipboard := ClipSaved
}

; 小写转大写
CapsLock & .::{
    Send "^x"
    Sleep 50
    A_Clipboard := StrUpper(A_Clipboard)
    Send "^v"
}

; 大写转小写
CapsLock & ,::{
    Send "^x"
    Sleep 50
    A_Clipboard := StrLower(A_Clipboard)
    Send "^v"
}

; 首字母大写
CapsLock & /::{
    Send "^x"
    Sleep 50
    A_Clipboard := RegExReplace(A_Clipboard, "^(.)", "$U1")
    Send "^v"
}

; 往前删除一个词
CapsLock & j::Send "^{Backspace}"

; 快速插入当前日期
CapsLock & `::Send FormatTime(, "yyyy-MM-dd") " "

; ====================================================================================
; F1帮助功能 - 显示所有快捷键
; ====================================================================================
CapsLock & F1::{
    helpGui := Gui("+AlwaysOnTop", "CapsLock Enhanced Script Help")
    helpGui.MarginX := 10
    helpGui.MarginY := 10
    helpGui.BackColor := "FFFFFF"
    
    ; 使用英文字体避免中文乱码问题
    helpGui.SetFont("s10 c000000", "Segoe UI")
    helpGui.Add("Text", "x10 y10 w580", "CapsLock Enhance Script - Shortcuts Guide")
    helpGui.SetFont("s9", "Consolas")
    
    helpGui.Add("GroupBox", "x10 y30 w280 h180", "Cursor Movement")
    helpGui.Add("Text", "x20 y50 w260", "CapsLock + f     -> Right")
    helpGui.Add("Text", "x20 y70 w260", "CapsLock + b     -> Left")
    helpGui.Add("Text", "x20 y90 w260", "CapsLock + u     -> Up")
    helpGui.Add("Text", "x20 y110 w260", "CapsLock + n     -> Down")
    helpGui.Add("Text", "x20 y130 w260", "CapsLock + p     -> Word Right")
    helpGui.Add("Text", "x20 y150 w260", "CapsLock + o     -> Word Left")
    helpGui.Add("Text", "x20 y170 w260", "CapsLock + a/e   -> Home/End")
    helpGui.Add("Text", "x20 y190 w260", "CapsLock + t/v   -> Page Up/Down")
    
    helpGui.Add("GroupBox", "x300 y30 w280 h180", "Text Editing")
    helpGui.Add("Text", "x310 y50 w260", "CapsLock + h     -> Backspace")
    helpGui.Add("Text", "x310 y70 w260", "CapsLock + d     -> Delete")
    helpGui.Add("Text", "x310 y90 w260", "CapsLock + k     -> Delete Word Right")
    helpGui.Add("Text", "x310 y110 w260", "CapsLock + j     -> Delete Word Left")
    helpGui.Add("Text", "x310 y130 w260", "CapsLock + l     -> Delete to End")
    helpGui.Add("Text", "x310 y150 w260", "CapsLock + x     -> Cut Line")
    helpGui.Add("Text", "x310 y170 w260", "CapsLock + [/]   -> Indent Left/Right")
    helpGui.Add("Text", "x310 y190 w260", "CapsLock + .     -> To UPPERCASE")
    
    helpGui.Add("GroupBox", "x10 y220 w280 h160", "Selection & Formatting")
    helpGui.Add("Text", "x20 y240 w260", "CapsLock + q     -> Selection Mode")
    helpGui.Add("Text", "x20 y260 w260", "CapsLock + i     -> Select Current Line")
    helpGui.Add("Text", "x20 y280 w260", "CapsLock + .     -> To UPPERCASE")
    helpGui.Add("Text", "x20 y300 w260", "CapsLock + ,     -> To lowercase")
    helpGui.Add("Text", "x20 y320 w260", "CapsLock + /     -> Capitalize First")
    helpGui.Add("Text", "x20 y340 w260", "CapsLock (3 times) -> Toggle CapsLock")
    
    helpGui.Add("GroupBox", "x300 y220 w280 h160", "Other Functions")
    helpGui.Add("Text", "x310 y240 w260", "CapsLock + w     -> Window Always on Top")
    helpGui.Add("Text", "x310 y260 w260", "CapsLock + m     -> Minimize Window")
    helpGui.Add("Text", "x310 y280 w260", "CapsLock + s     -> Open Perplexity")
    helpGui.Add("Text", "x310 y300 w260", "CapsLock + g     -> Search Selected Text")
    helpGui.Add("Text", "x310 y320 w260", "CapsLock + c     -> Smart URL Open")
    helpGui.Add("Text", "x310 y340 w260", "CapsLock + r     -> Enter Key")
    helpGui.Add("Text", "x310 y360 w260", "CapsLock + z     -> Esc Key")
    helpGui.Add("Text", "x310 y380 w260", "CapsLock + `     -> Insert Date")
    
    helpGui.Add("Button", "x250 y410 w100 h30", "Close").OnEvent("Click", (*) => helpGui.Destroy())
    
    helpGui.Show("w590 h450")
}

; ====================================================================================
; 连按三次CapsLock切换大小写锁定状态(缩短时间间隔)
; ====================================================================================
CapsLock::{
    currentTime := A_TickCount
    
    ; 将时间间隔缩短为300毫秒
    if (currentTime - lastCapsTime > 300)
        capsCount := 0
    
    ; 增加计数
    capsCount++
    
    ; 记录这次按下的时间
    lastCapsTime := currentTime
    
    ; 如果连按三次，切换CapsLock状态
    if (capsCount >= 3) {
        if GetKeyState("CapsLock", "T")
            SetCapsLockState "Off"
        else
            SetCapsLockState "On"
        ToolTip "CapsLock状态已切换为: " GetKeyState("CapsLock", "T")
        SetTimer () => ToolTip(), -1000
        capsCount := 0  ; 重置计数
    }
}

; ====================================================================================
; 鼠标快速滚动
; ====================================================================================

; 使用CapsLock + 鼠标滚轮实现翻页效果
; 向上滚动时翻上一页
CapsLock & WheelUp::Send "{PgUp}"

; 向下滚动时翻下一页
CapsLock & WheelDown::Send "{PgDn}"

; ====================================================================================
; 检查 MagicCapsLock 是否激活的函数
; ====================================================================================
IsMagicCapsLockActive() {
    return true  ; 始终返回 true，表示功能始终处于激活状态
}

#HotIf IsMagicCapsLockActive()
; Navigation keys
x::Send "{Alt down}{F4}{Alt up}" ; Close current window (like Alt+F4) 
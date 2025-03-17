# MagicCapsLock

<div align="center">

[![Release](https://img.shields.io/badge/release-v1.0.1-blue.svg)](https://github.com/superhello2099/MagicCapsLock/releases)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![AutoHotkey](https://img.shields.io/badge/AutoHotkey-1.1-orange.svg)](https://www.autohotkey.com/)
[![Windows](https://img.shields.io/badge/platform-Windows-lightgrey.svg)](https://www.microsoft.com/windows)

[English](#english) | [中文](#chinese)

<img src="https://raw.githubusercontent.com/superhello2099/MagicCapsLock/main/assets/logo.png" alt="MagicCapsLock Logo" width="200"/>

*Transform your CapsLock key from rarely-used annoyance to productivity supercharger*

</div>

---

<a id="english"></a>

# 🚀 MagicCapsLock

## ⚡ Quick Start

1. **Install AutoHotkey**:
   - Download from [AutoHotkey Official Site](https://www.autohotkey.com/download/)
   - Run the installer and follow the prompts (default options are fine)

2. **Get the Script**:
   - Download `magic_capslock.ahk` from [latest release](https://github.com/superhello2099/MagicCapsLock/releases)
   - Save it anywhere on your computer

3. **Run the Script**:
   - Double-click the script file to run it immediately
   - A small "H" icon will appear in your system tray showing the script is active

4. **Auto-start with Windows** (recommended):
   - Press `Win+R`, type `shell:startup` and press Enter
   - Copy or create a shortcut to the script in this folder
   - The script will now run automatically each time you start your computer

## ✨ Features

### 🎯 Core Functionality
- CapsLock becomes a modifier key for 30+ custom shortcuts
- Triple-press CapsLock to toggle traditional CapsLock state

### 🎮 Navigation
- Vim-like cursor movement (h/j/k/l style with different keys)
- Quick word/line/page navigation
- Efficient text selection

### ✏️ Text Editing
- Delete words, lines, and characters with ease
- Case conversion (lowercase, UPPERCASE, Title Case)
- Indentation control

### 🪟 Window Management
- Toggle window always-on-top
- Minimize current window

### 🎁 Additional Features
- Quick Google search of selected text
- Perplexity AI quick access
- Date insertion
- Built-in help system (Caps+F1)

## 📖 Usage

> Press **CapsLock + F1** at any time to see all available shortcuts.

### ⌨️ Key Shortcuts Overview

<details>
<summary>📍 Cursor Movement</summary>

| Shortcut | Action |
|----------|--------|
| `CapsLock + f` | Right |
| `CapsLock + b` | Left |
| `CapsLock + u` | Up |
| `CapsLock + n` | Down |
| `CapsLock + p` | Word Right |
| `CapsLock + o` | Word Left |
| `CapsLock + a` | Home |
| `CapsLock + e` | End |
| `CapsLock + t` | Page Up |
| `CapsLock + v` | Page Down |

</details>

<details>
<summary>✂️ Text Editing</summary>

| Shortcut | Action |
|----------|--------|
| `CapsLock + h` | Backspace |
| `CapsLock + d` | Delete |
| `CapsLock + k` | Delete Word Right |
| `CapsLock + j` | Delete Word Left |
| `CapsLock + l` | Delete to End |
| `CapsLock + x` | Cut Line |
| `CapsLock + [/]` | Indent Left/Right |

</details>

<details>
<summary>📝 Selection & Formatting</summary>

| Shortcut | Action |
|----------|--------|
| `CapsLock + q` | Selection Mode |
| `CapsLock + i` | Select Current Line |
| `CapsLock + .` | To UPPERCASE |
| `CapsLock + ,` | To lowercase |
| `CapsLock + /` | Capitalize First |
| `CapsLock` (3x) | Toggle CapsLock |

</details>

<details>
<summary>🔧 Other Functions</summary>

| Shortcut | Action |
|----------|--------|
| `CapsLock + w` | Window Always on Top |
| `CapsLock + m` | Minimize Window |
| `CapsLock + s` | Open Perplexity |
| `CapsLock + g` | Search Selected Text |
| `CapsLock + r` | Enter Key |
| `CapsLock + z` | Esc Key |
| `CapsLock + `` | Insert Date |
| `CapsLock + F1` | Help Screen |

</details>

## 📝 Version History

### v1.0.1 (2024-03-17)
- 🐛 Fixed: Improved CapsLock + s functionality to copy text before opening Perplexity
- ✨ Enhanced: Better clipboard handling for text operations

### v1.0.0 (2024-03-17)
- 🎉 Initial release
- ✨ Basic CapsLock enhancement features

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

Copyright (c) 2024 superhello2099

---

<a id="chinese"></a>

# 🚀 MagicCapsLock 中文版

<div align="center">

*将几乎从不使用的 CapsLock 键变成效率倍增器*

</div>

## ⚡ 快速开始

1. **安装 AutoHotkey**:
   - 从 [AutoHotkey 官网](https://www.autohotkey.com/download/) 下载
   - 运行安装程序，按照提示操作（默认选项即可）

2. **获取脚本**:
   - 从[最新发布](https://github.com/superhello2099/MagicCapsLock/releases)下载 `magic_capslock.ahk` 文件
   - 保存到计算机上的任意位置

3. **运行脚本**:
   - 双击脚本文件立即运行
   - 系统托盘会出现一个小"H"图标，表示脚本已激活

4. **随 Windows 自启动**（推荐）:
   - 按下 `Win+R`，输入 `shell:startup` 并回车
   - 将脚本复制或创建快捷方式到此文件夹
   - 这样每次启动计算机时脚本都会自动运行

## ✨ 功能特点

### 🎯 核心功能
- CapsLock 成为 30+ 自定义快捷键的修饰键
- 连按三次 CapsLock 切换传统的大小写锁定状态

### 🎮 导航功能
- 类似 Vim 的光标移动（h/j/k/l 风格但使用不同按键）
- 快速的词/行/页面导航
- 高效的文本选择

### ✏️ 文本编辑
- 轻松删除词、行和字符
- 大小写转换（小写、大写、首字母大写）
- 缩进控制

### 🪟 窗口管理
- 切换窗口置顶状态
- 最小化当前窗口

### 🎁 其他功能
- 快速 Google 搜索选中文本
- 快速访问 Perplexity AI
- 日期插入
- 内置帮助系统（Caps+F1）

## 📖 使用方法

> 随时按下 **CapsLock + F1** 查看所有可用快捷键。

### ⌨️ 快捷键概览

<details>
<summary>📍 光标移动</summary>

| 快捷键 | 功能 |
|--------|------|
| `CapsLock + f` | 向右 |
| `CapsLock + b` | 向左 |
| `CapsLock + u` | 向上 |
| `CapsLock + n` | 向下 |
| `CapsLock + p` | 向右移动一个词 |
| `CapsLock + o` | 向左移动一个词 |
| `CapsLock + a` | 行首 |
| `CapsLock + e` | 行尾 |
| `CapsLock + t` | 上一页 |
| `CapsLock + v` | 下一页 |

</details>

<details>
<summary>✂️ 文本编辑</summary>

| 快捷键 | 功能 |
|--------|------|
| `CapsLock + h` | 退格 |
| `CapsLock + d` | 删除 |
| `CapsLock + k` | 删除右侧词 |
| `CapsLock + j` | 删除左侧词 |
| `CapsLock + l` | 删除至行尾 |
| `CapsLock + x` | 剪切整行 |
| `CapsLock + [/]` | 左/右缩进 |

</details>

<details>
<summary>📝 选择和格式化</summary>

| 快捷键 | 功能 |
|--------|------|
| `CapsLock + q` | 选择模式 |
| `CapsLock + i` | 选择当前行 |
| `CapsLock + .` | 转为大写 |
| `CapsLock + ,` | 转为小写 |
| `CapsLock + /` | 首字母大写 |
| `CapsLock`（3次） | 切换大小写锁定 |

</details>

<details>
<summary>🔧 其他功能</summary>

| 快捷键 | 功能 |
|--------|------|
| `CapsLock + w` | 窗口置顶/取消 |
| `CapsLock + m` | 最小化窗口 |
| `CapsLock + s` | 打开 Perplexity |
| `CapsLock + g` | 搜索选中文本 |
| `CapsLock + r` | 回车键 |
| `CapsLock + z` | Esc 键 |
| `CapsLock + `` | 插入日期 |
| `CapsLock + F1` | 帮助界面 |

</details>

## 📝 版本历史

### v1.0.1 (2024-03-17)
- 🐛 修复：改进 CapsLock + s 功能，先复制文本再打开 Perplexity
- ✨ 增强：优化剪贴板处理

### v1.0.0 (2024-03-17)
- 🎉 初始发布
- ✨ 基础 CapsLock 增强功能

## 📄 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件。

Copyright (c) 2024 superhello2099
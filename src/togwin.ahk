#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#NoTrayIcon
;===================================================================================
; Toggle visibility of hidden files in Explorer with Ctrl+Windows+H, and
; toggle visibility of both system files and hidden files with Ctrl+H.
;===================================================================================

;============AutoExecute============

ControlGet, hwWindow, HWND,, SysListView321, ahk_class Progman
if hwWindow {
	desktopclassname := "Progman"
	explorerlistview := "SysListView321"
} else {
	desktopclassname := "WorkerW"
	explorerlistview := "DirectUIHWND3"
}
GroupAdd, ExplorerWindowsGroup, ahk_class CabinetWClass
;==========End AutoExecute==========

IsShellWindowActive() {
	return WinActive("ahk_class CabinetWClass")          ; Explorer
		|| WinActive("ahk_class Progman")                ; Desktop (XP)
		|| WinActive("ahk_class WorkerW")                ; Desktop (Win 7+)
		|| WinActive("ahk_class #32770")                 ; File dialogs
		|| WinActive("ahk_class ExploreWClass")          ; Control Panel
		|| WinActive("ahk_class Shell_TrayWnd")          ; Taskbar shell
		|| WinActive("ahk_class ApplicationFrameWindow") ; Settings app
}

#If IsShellWindowActive()

^h::  ; Ctrl+H: Toggle hidden files only
RegRead, HiddenVisible, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden
RegRead, SystemVisible, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, ShowSuperHidden
if HiddenVisible = 2
    ShowHiddenFiles(1)
else if SystemVisible = 1
    ShowHiddenFiles(1)
else ShowHiddenFiles(0)
gosub, ShowToolTip
sleep 1000
gosub, RemoveToolTip
return

^#h::  ; Ctrl+Win+H: Toggle hidden + system files
RegRead, HiddenVisible, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden
RegRead, SystemVisible, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, ShowSuperHidden
if SystemVisible = 0
    ShowHiddenFiles(2)
else
    ShowHiddenFiles(0)
gosub, ShowToolTip
sleep 1000
gosub, RemoveToolTip
return

#If  ; Ends context-sensitive hotkey block

ShowToolTip:
RefreshExplorerWindows()
ToolTip, Hidden Files: %HiddenFilesState%`nSystem Files: %SystemFilesState%
return

RemoveToolTip:
ToolTip
return

ShowHiddenFiles(mode) {
global HiddenFilesState, SystemFilesState
    if (mode == 0) {
	RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 2
	RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, ShowSuperHidden, 0
	HiddenFilesState := "Not Visible"
	SystemFilesState := "Not Visible"
    } else if (mode == 1) {
	RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1
	RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, ShowSuperHidden, 0
	HiddenFilesState := "Visible"
	SystemFilesState := "Not Visible"
    } else {
	RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1
	RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, ShowSuperHidden, 1
	HiddenFilesState := "Visible"
	SystemFilesState := "Visible"
    }
    sleep, 10
    return
}

RefreshExplorerWindows() {
Send ^r
Send {F5}
}
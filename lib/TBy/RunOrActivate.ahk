runOrActivate(Target, WinTitle := "", ShowTrayTip := false) {
	/* Function: RunOrActivate
	Run a program or switch to it if already running.

	Parameters:
	Target - Program to run. E.g. Calc.exe or C:\Progs\Mine.exe
	WinTitle - Optional title of the window to activate.  Programs like MS Outlook might have
				multiple windows open (main window and email windows).  This parm allows activating a specific window.
	ShowTrayTip - Show TrayTip with information about action

	Example:
	==== AutoHotkey ====
	> #b::RunOrActivate("c:\Usr\bin\DebugView++.exe",,true)
	> #o::RunOrActivate("OUTLOOK.EXE", "Microsoft Outlook", false) ; Outlook can have multiple child windows, so specify which window to activate
	===

	Credits:
	* Original: <deanhill1971: https://autohotkey.com/board/topic/7129-run-a-program-or-switch-to-an-already-running-instance/#entry43438>
	*/

	; Get the filename without a path
	SplitPath Target, TargetNameOnly

	PID := ProcessExist(TargetNameOnly)
	if !(PID) {
		Run(Target, , , PID)
	}

	; If WinTitle is given, activate by WinTitle else activate by PID
	If (WinTitle == "") {
		WinTitle := "ahk_pid" PID
	}

	tmm := A_TitleMatchMode
	SetTitleMatchMode(2)
	WinWait(WinTitle,,3)
	if (ShowTrayTip)  {
		TrayTip("Activating Window <" WinTitle ">",  TargetNameOnly, 1)
		SetTimer "_3b0493_HideTrayTip", -5000
	}
	WinActivate(WinTitle)
	SetTitleMatchMode(tmm)  ; Restore TitleMatchMode

	return
}


; internal callback with random name
_3b0493_HideTrayTip() { ; See https://lexikos.github.io/v2/docs/commands/TrayTip.htm
	TrayTip  ; Attempt to hide it the normal way.
	if SubStr(A_OSVersion,1,3) = "10." {
		A_IconHidden := true
		Sleep 200  ; It may be necessary to adjust this sleep.
		A_IconHidden := false
	}
}
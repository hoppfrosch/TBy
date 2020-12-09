#include %A_ScriptDir%\..\lib\TBy\RunOrActivate.ahk

#b::runOrActivate("c:\Usr\bin\DebugView++.exe",,true)
#o::runOrActivate("OUTLOOK.EXE", "Posteingang", false) ; Outlook can have multiple child windows, so specify which window to activate

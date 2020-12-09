#include %A_ScriptDir%\..\lib\TBy\CallStack.ahk

A()
ExitApp

A(){
 B()
}

B(){
	C()	
}

C(){
	cs := CallStack()
	; Print the current callstack
	str := ""
	for level, obj in  CallStack() { 
		if (A_Index > 1 )
			str := str . " => "
		str := str . obj.function	
		OutputDebug(obj.function " in " obj.file " (" value := obj.line ")`n")
	}
	OutputDebug("Current CallStack: " str "`n")

	OutputDebug(cs[0].function " in " cs[0].file " (" value := cs[0].line ")`n")
	return
}
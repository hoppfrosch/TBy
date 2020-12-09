global stack := Map()

CallStack(deepness :=100, getContents := true) {
	/* --------------------------------------------------------------------------------------
	Function: CallStack
	Gets the current call stack

	Description:
	Gets the current callstack, containing information like functionname, filename and linenumber of the function.
	An associative Array is returned, containing array elements in range of 0 to -calldepth (negative numbers). 
	Index 0 contains the info about current function, whereas Index -1 contains info about the parent (caller) 
	of the current function. (-2: Grandparent ...)

	Parameters:
	* deepness (optional, default := 100) - determines the depth of the determined callstack
	* getContents (optional, default := true) - get the contents of the line, where the current function is called

	Example:
	==== AutoHotkey ====
	#include TBy\CallStack.ahk

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
	===

	Credits:
	* Original: <deo: https://autohotkey.com/board/topic/76062-ahk-l-how-to-get-callstack-solution/>
	*/

	global stack
	max := 0
	loop deepness {
		lvl := -1 - deepness + A_Index
		oEx := Exception("", lvl)
		oExPrev := Exception("", lvl - 1)
			
		if (getContents) { ; Get the corresponding line from the file
			file := FileOpen(oEx.file, "r")
			loop {
				if (file.AtEOF)
					break
				line := File.ReadLine() 
				if (A_Index == oEx.line)
					break
			}
			file.close()
		}
		
		if(oEx.What == lvl)
			continue
			
		currStack := {}			
		currStack.file := oEx.File
		currStack.line := oEx.Line
		currStack.function := (oExPrev.What = lvl-1 ? "main" :  oExPrev.What)
		currStack.depth := deepness - A_Index
		if (max < currStack.depth) {
			max :=  currStack.depth
		}
		if (getContents) {
			currStack.contents := line
		}
		stack[lvl+1] := currStack
	}
	for key,value in stack {
		stack[key].depth := max - stack[key].depth
	}
	return stack
}
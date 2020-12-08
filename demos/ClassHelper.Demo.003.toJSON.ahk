#include %A_ScriptDir%\..\lib\TBy\ClassHelper.ahk

class a{ 
	class b{ 
		x := 42
		y := 17

		test() {
			return 55
		}
	} 
}
c := a.b.new()
str := ClassHelper.toJSON(c, indent := 2)

OutputDebug("Serialized obj <c> to <" str ">")
ExitApp
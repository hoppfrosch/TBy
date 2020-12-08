#Include %A_ScriptDir%\..\lib\TBy.ahk  ; Where to get version to be used within documentation
#include %A_ScriptDir%\BuildTools.ahk

DocuUpdateVersion(release_version())
DocuGenerate()

ExitApp
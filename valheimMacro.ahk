SetWorkingDir %A_ScriptDir% 
#ifWinActive ahk_exe valheim.exe
#SingleInstance
#Include %A_LineFile%\..\source.ahk


!+j::
	logInToValheim(v_monitorRight, v_monitorBottom, valheimIP, valheimPW)
Return

!+c::
	Send {F5}
Return


/*=========================================================================================
||
||	-The default is {Alt}+{Shift}+j
||	-To change the macro key combo, change the stuff that comes before the '::'
||		-Each modifier key has an associated symbol
||			-Shift is denoted with a '+'
||			-Alt is denoted with a '!'
||			-Ctrl is denoted with a '^'
||			-Windows is denoted with a '#'
||		-If you wanted to do {Ctrl}+{Windows}+o , for example then replace '!+j' with '^#o'
||		-Read more about ahk macro bindings here:
||			https://www.autohotkey.com/docs/Hotkeys.htm
||			
=========================================================================================*/
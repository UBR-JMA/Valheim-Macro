SetWorkingDir %A_ScriptDir% 
#ifWinActive ahk_exe valheim.exe
#SingleInstance
#Include %A_LineFile%\..\source.ahk


!+j::
	f_logInToValheim(v_monitorRight, v_monitorBottom, valheimIP, valheimPW)
Return

e::
	f_ActivateKeySpam() 
Return

!+t::	
	f_StartTestingMode() 
Return

!+x::
	f_mapBreadCrumb()
Return





/*=========================================================================================
||
||	-The default is {Alt}+{Shift}+j (j for join) for instant login
||	-The activation key (e by default) will now activate rapidly and repeatedly if held down for more than 1 second.
||	-The default for instant devcommands is {Alt}+{Shift}+t (t for testing).
||		-This starts decommands and debug mode as well as a few other tools.
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
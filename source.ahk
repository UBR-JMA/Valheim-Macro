SetWorkingDir %A_ScriptDir% 
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
#Include %A_LineFile%\..\config.ahk

global currentMenuItem := 1

SysGet, v_monitor, Monitor  ;Get the monitor Height and Width
v_maxScreenWidth = %v_monitorRight%
v_maxScreenHeight = %v_monitorBottom%

f_MouseMoveScreenPercent(xPercent, yPercent, xMax, yMax, hover:=0){	
	xScreenCoord := xMax*xPercent
	yScreenCoord := yMax*yPercent
	MouseMove, %xScreenCoord%, %yScreenCoord%, 0.5
	if (hover != 1){
		Click
	}
	Sleep 50
	Return
	/*
	||	The hover option lets the function be written for either moving and then clicking,
	||	or just moving to a location without clicking. Click by default.
	||
	||	xMax represents primary monitor resolution width, in pixels.
	||	yMax represents primary monitor resolution height, in pixels.
	||	xPercent and yPercent represent a decimal version of the percentage of the screen where the coordinate is found
	||		(for xPercent and yPercent: 0.xx rather than %xx)
	||	
	||	Fixable Limitation: This does not work if valheim is not displayed on the primary monitor
	*/
}

f_sleepLoading(){
	Sleep 1500
	MouseGetPos, MouseX, MouseY
	PixelGetColor, loadingColor, %MouseX%, %MouseY%
	newColor = %loadingColor%
	while (newColor = loadingColor)
	{
		Sleep 500
		MouseGetPos, MouseX, MouseY
		PixelGetColor, newColor, %MouseX%, %MouseY%
	}
	Return
}

f_logInToValheim(xMax, yMax, ipAddress, loginPassword){
	BlockInput On
	BlockInput MouseMove
	;From the start menu, after the title sequence:
	f_MouseMoveScreenPercent(0.50, 0.76, xMax, yMax)		;Click Start Game
	f_MouseMoveScreenPercent(0.5, 0.95, xMax, yMax)			;Click Start 
	Sleep 60
	f_MouseMoveScreenPercent(0.25, 0.21, xMax, yMax)		;Click Join Game 
	f_MouseMoveScreenPercent(0.35, 0.65, xMax, yMax)		;Click Join IP 
	f_MouseMoveScreenPercent(0.4, 0.5, xMax, yMax)			;Click Textbox 
	SendInput ^a											;Highlight any text in the text box
	SendInput {Delete}										;Clear any existing text from IP box
	SendInput %ipAddress%									;Type in the IP address
	Sleep 100
	f_MouseMoveScreenPercent(0.55, 0.55, xMax, yMax)		;Click Connect
	Sleep 1500
	f_MouseMoveScreenPercent(0.865, 0.945, xMax, yMax, 1)	;Hover over loading text
	f_sleepLoading()										;Wait for for the loading text to disappear
	Sleep 500												;Wait a moment
	SendInput %loginPassword%								;Type in the Password
	Sleep 500												;Wait a moment
	SendInput {Enter}										;Submit Password
	BlockInput MouseMoveOff								
	BlockInput Off
	Return
}


f_ActivateKeySpam(){ ;this should be reworked to allow for any key, rather than just e.
	SendInput e
	Sleep 1000
	while (getKeyState("E", "P"))
	{
		Send e
		sleep, 100
	}
	Return
}

f_StartTestingMode(){
	SendInput {F5}					;open console
	Sleep 60
	SendInput devcommands{Enter}	;start dev mode
	Sleep 60
	SendInput debugmode{Enter}		;start debug mode
	Sleep 60
	sendInput god{Enter}			;enable god mode
	Sleep 60
	SendInput ghost{Enter}			;become allied to enemies
	Sleep 60
	SendInput tod 0.5{Enter}		;set time to noon
	Sleep 60
	SendInput {F5}					;close the console
	Sleep 60
	SendInput b						;enable free building
	Sleep 60
	SendInput z						;enable flying
	Return
}
	
f_mapBreadCrumb()
{
	BlockInput On
	BlockInput MouseMove
	SendInput m											;Open the map
	Sleep 60	
	f_MouseMoveScreenPercent(0.5, 0.5, xMax, yMax)		;click the center of the map
	Sleep 30
	f_MouseMoveScreenPercent(0.5, 0.5, xMax, yMax)		;click again
	Sleep 120	
	SendInput {Enter} 									;Leave the name blank
	Sleep 60	
	SendInput m											;Close the map
	BlockInput MouseMoveOff								
	BlockInput Off
	Return
}

f_menuScrollUp(){
	
}

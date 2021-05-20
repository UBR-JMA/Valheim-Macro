SetWorkingDir %A_ScriptDir% 
#Include %A_LineFile%\..\config.ahk

;Get the monitor Height and Width
SysGet, v_monitor, Monitor
v_maxScreenWidth = %v_monitorRight%
v_maxScreenHeight = %v_monitorBottom%

/*
1663, 1018
87% x 94%
*/

f_screenCoordsPercent(xPercent, yPercent, xMax, yMax, hover:=0){	
/*
||	xMax represents primary monitor resolution width
||	yMax represents primary monitor resolution Height
||	xPercent and yPercent represent a decimal version of the percentage of the screen where the coordinate is found	
*/
	xScreenCoord := xMax*xPercent
	yScreenCoord := yMax*yPercent
	MouseMove, %xScreenCoord%, %yScreenCoord%, 0.5
	if (hover != 1){
		Click
	}
	Sleep 50
	Return
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

logInToValheim(xMax, yMax, ipAddress, loginPassword){
	BlockInput On
	;From the start menu, after the title sequence:
	f_screenCoordsPercent(0.50, 0.76, xMax, yMax)		;Click Start Game
	f_screenCoordsPercent(0.5, 0.95, xMax, yMax)		;Click Start 
	f_screenCoordsPercent(0.25, 0.21, xMax, yMax)		;Click Join Game 
	f_screenCoordsPercent(0.35, 0.65, xMax, yMax)		;Click Join IP 
	f_screenCoordsPercent(0.4, 0.5, xMax, yMax)			;Click Textbox 
	Send ^a												;Highlight any text in the text box
	Send {Delete}										;Clear any existing text from IP box
	SendRaw %ipAddress%									;Type in the IP address
	f_screenCoordsPercent(0.55, 0.55, xMax, yMax)		;Click Connect
	f_screenCoordsPercent(0.865, 0.945, xMax, yMax, 1)	;Hover over loading text
	f_sleepLoading()									;Wait for for the loading text to disappear
	Sleep 500											;Wait a moment
	SendRaw %loginPassword%								;Type in the Password
	Sleep 500											;Wait a moment
	Send {Enter}										;Submit Password
	BlockInput Off
}


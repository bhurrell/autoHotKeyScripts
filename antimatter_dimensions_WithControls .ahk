#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance ignore
SetTitleMatchMode, 2
DetectHiddenText ON 
CoordMode, Tooltip, Screen
tooltipX := 144
tooltipY := 190

doSacrifices := True

`::Suspend

;; Increase sOffsetValue with F7 key
F7::
		{
		SOffsetValue := SOffsetValue + 100
		SCount = 0
		}
	ToolTip, SOffsetValue is %SOffsetValue%, tooltipX, tooltipY + 35, 2
return

;; Decrease sOffsetValue with F6 key
F6::
	If SOffsetValue > 100
		{
		SOffsetValue := SOffsetValue - 100
		SCount = 0
		}
	ToolTip, SOffsetValue is %SOffsetValue%, tooltipX, tooltipY + 35, 2
return

;; Turn Sacrifices on/off with F5 key
F5::
	If doSacrifices = 1
		doSacrifices := False
	Else
		{
		doSacrifices := True
		SCount = 0
		}
	ToolTip, doSacrifices is %doSacrifices%, tooltipX, tooltipY, 1
return

;; kill the script with F4 key
F4::
	Stopped := 1
	ToolTip,,,,1
	ToolTip,,,,2
	ToolTip,,,,3
return

;; start the script with F3 key
F3::
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; here are your config options to toggle certain keystrokes or functions ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	useMaxAll := true

	;; all individual dims are ignored if useMaxAll is true
	d1 := false
	d2 := false
	d3 := false
	d4 := false
	d5 := false
	d6 := false
	d7 := false
	d8 := false


	doSacrifices := True
	doGalaxies := false
	doDBoosts := false
	doCrunch := True

	;; if offsetS is true, it will only send the sacrifice key on loops that are multiples of sOffsetValue
	offsetS := true
	SOffsetValue := 100

	;; if offsetD is true, it will only send the sacrifice key on loops that are multiples of DOffsetValue 
	offsetD := true
	DOffsetValue := 300

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; you shouldn't have to change anything under this. ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	Stopped := 0
	SCount := 0
	DCount := 0


	Loop{
		if (useMaxAll = false && d1 = false && d2 = false && d3 = false && d4 = false && d5 = false && d6 = false && d7 = false && d8 = false){
			debug("useMaxAll and all individual dims are disabled, effectively meaning you will not buy any dims at all.", true)
		}

		sendString := ""

		if (useMaxAll = true){
			sendString = %sendString%m
			sendString = %sendString%+1
		}

		if (useMaxAll = false && d1 = true){
			sendString = %sendString%1
		}
		if (useMaxAll = false && d2 = true){
			sendString = %sendString%2
		}
		if (useMaxAll = false && d3 = true){
			sendString = %sendString%3
		}
		if (useMaxAll = false && d4 = true){
			sendString = %sendString%4
		}
		if (useMaxAll = false && d5 = true){
			sendString = %sendString%5
		}
		if (useMaxAll = false && d6 = true){
			sendString = %sendString%6
		}
		if (useMaxAll = false && d7 = true){
			sendString = %sendString%7
		}
		if (useMaxAll = false && d8 = true){
			sendString = %sendString%8
		}
		
		;; add non-offset hotkeys
		if (doCrunch = true) {
			debug("crunching")
			sendString = %sendString%c
		}
		if (doDBoosts = true && offsetD = false){
			debug("d shift or boosting")
			sendString = %sendString%d
		}
		if (offsetS = false && doSacrifices = true){
			debug("sending sacrifice")
			sendString = %sendString%s
		}
		if (doGalaxies = true){
			debug("buying galaxy")
			sendString = %sendString%g
		}

		; set and send occasional dim boost every x loops
		if (doDBoosts = true && offsetD = true && DCount = DOffsetValue){
			debug("offset boost or shift")
			sendString = %sendString%d
			DCount = 0
		}

		; set and send occasional sacrifice command every x loops
		if (doSacrifices = true && offsetS = true && SCount = SOffsetValue){
			debug("offset sacrifice")
			sendString = %sendString%s
			SCount = 0
		}
		
		if(enableDebug = true){
			debug(sendString, true, "Key string to send: ")
		} else {
			send, %sendString%
		}

		SCount += 1
		DCount += 1 

		Sleep, 20

		if (Stopped = 1){
			break
		}
	}
return

;; supporting functions
debug(msg, override := false, prepend:= "Debug: "){
	if (enableDebug = true || override = true){
		MsgBox % prepend msg
	}
}

;; Turn dBoosts on/off with F2 key
F2::
	If doDBoosts = 1
		doDBoosts := False
	Else
		{
		doDBoosts := True
		DCount = 0
		}
	ToolTip, doDBoosts is %doDBoosts%, tooltipX, tooltipY + 70, 3
return

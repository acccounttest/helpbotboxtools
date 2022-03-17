; <COMPILER: v1.1.13.01>
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
SetBatchLines, -1
SetWinDelay, -1
MSG:="Little tool to convert mouse selection into parameters for addBoxes command in springlobby. Shift+LeftMouseButton:Begin to draw a rectangle around the minimap from left to right. Control+LeftMouseButton:Draw a box on the map. Shift+Digit:Fill your clipboard with latest selected box into coordinates. Ctrl+v:Paste last clipboard remain in the current view."
MsgBox, %MSG%
global L:=0
global T:=0
global R:=0
global B:=0
BW := 2
BC := "Orange"
FirstCall := True
CoordMode, Mouse, Screen
Gui, -Caption +ToolWindow +LastFound +AlwaysOnTop
Gui, Color, %BC%
1::PasteIntoClipboard(1)
2::PasteIntoClipboard(2)
3::PasteIntoClipboard(3)
4::PasteIntoClipboard(4)
5::PasteIntoClipboard(5)
6::PasteIntoClipboard(6)
7::PasteIntoClipboard(7)
8::PasteIntoClipboard(8)
9::PasteIntoClipboard(9)
PasteIntoClipboard(Number)
{
L:=Round(L)
T:=Round(T)
R:=Round(R)
B:=Round(B)
thecommand=!addBox %L% %T% %R% %B% %Number%
clipboard = %thecommand%
}
Return
+LButton::
Gui, Color, ORANGE
MouseGetPos, OriginX, OriginY
SetTimer, DrawRectangle, 10
Return
+LButton Up::
SetTimer, DrawRectangle, Off
FirstCall := True
Gui, Cancel
ToolTip
Xa=%X1%
Ya=%Y1%
Wa=%W1%
Ha=%H1%
Return
^LButton::
Gui, Color, GREEN
MouseGetPos, OriginX, OriginY
SetTimer, DrawRectangle, 10
Return
^LButton Up::
SetTimer, DrawRectangle, Off
FirstCall := True
Gui, Cancel
ToolTip
Xb=%X1%
Yb=%Y1%
Wb=%W1%
Hb=%H1%
L:= Wa/(Xb-Xa)
L:=200/L
T:=Ha/(Yb-Ya)
T:=200/T
RightX:=Wa-(Xb-Xa)-Wb
RightX:=Wa/(RightX)
R:=200-(200/RightX)
BottomY:=Ha-(Yb-Ya)-Hb
BottomY:=Ha/(BottomY)
B:=200-(200/BottomY)
Return
DrawRectangle:
MouseGetPos, X2, Y2
If (XO = X2) And (YO = Y2)
Return
Gui, +LastFound
XO := X2, YO := Y2
If (X2 < OriginX)
X1 := X2, X2 := OriginX
Else
X1 := OriginX
If (Y2 < OriginY)
Y1 := Y2, Y2 := OriginY
Else
Y1 := OriginY
W1 := X2 - X1, H1 := Y2 - Y1
W2 := W1 - BW, H2 := H1 - BW
WinSet, Region, 0-0 %W1%-0 %W1%-%H1% 0-%H1% 0-0  %BW%-%BW% %W2%-%BW% %W2%-%H2% %BW%-%H2% %BW%-%BW%
If (FirstCall) {
Gui, Show, NA x%X1% y%Y1% w%W1% h%H1%
FirstCall := False
}
WinMove, , , X1, Y1, W1, H1
Return

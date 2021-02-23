LabelUmDia:
GuiControl,, TextData1, Data:
GuiControl, Hide, TextData2
GuiControl, Hide, MyLaterTime
GuiControl, Enable, Bt ;HABILITA O USO DO BOTTOM
GuiControl, Disable, BoxHora
GuiControl, Disable, TextHora
Return
LabelMaisDia: ;FAZ APARECER A 2 DATA ESCONDIDA
GuiControl,, TextData1, De:
GuiControl, Show, TextData2
GuiControl, Show, MyLaterTime
GuiControl, Enable, Bt ;HABILITA O USO DO BOTTOM
GuiControl, Disable, BoxHora
GuiControl, Disable, TextHora
Return
LabelReset: ;ESCONDE A 2 DATA NOVAMENTE
GuiControl,, TextData1, Data:
GuiControl, Hide, TextData2
GuiControl, Hide, MyLaterTime
GuiControl, Enable, Bt ;HABILITA O USO DO BOTTOM
GuiControl, Enable, BoxHora
GuiControl, Enable, TextHora
Return
RESETANDO:
GuiControl,, BoxHora, %A_Now%
GuiControl,, MyDateTime, %A_Now%
GuiControl,, MyLaterTime, %A_Now%
Return
LabelPessoa:    
if !(PESSOA := "")
    GuiControl, Enable, Consultar   
Return    

c = 1
ASSTECA:
c++
if c = 5
    GuiControl, Enable, ConsultarSige  
Return
;-----------------------------------------------------------------------------------
darkMode:
Gui, 2: Submit, nohide
Gui, 2: Default
if (Noturno){
    Gui, 2: Font, s14 w700 cCCCCCC, Calibri
    SetStaticColor(Text0, 0xF0F0F0)
    GuiControl, Font, Text1
    GuiControl, Font, Text2
    GuiControl, Font, Text3
    GuiControl, Font, Text4
    SetStaticColor(Text5, 0xF0F0F0)
    SetStaticColor(Text6, 0xF0F0F0)
    SetStaticColor(Text7, 0xF0F0F0)
    SetStaticColor(Text8, 0xF0F0F0)
    SetStaticColor(Text9, 0xF0F0F0)
    GuiControl, Font, QuerEntrar
    GuiControl, Font, QuerSair
    GuiControl, Font, QuerUmDia
    GuiControl, Font, QuerMaisDia
    GuiControl, Font, TextHora
    GuiControl, Font, TextData1
    GuiControl, Font, TextData2
    Gui, 2: Color, 252526
    ;Gui, 2: Color, 3A3A3A ;para rafael
    GuiControl, Show, Cebra_branco
    GuiControl, Hide, Cebra_preto
}
Else{
    Gui, 2: Font, s14 w700 cDefault, Calibri
    SetStaticColor(Text0, 0xF0F0F0)
    GuiControl, Font, Text1
    GuiControl, Font, Text2
    GuiControl, Font, Text3
    GuiControl, Font, Text4
    GuiControl, Font, QuerEntrar
    GuiControl, Font, QuerSair
    GuiControl, Font, QuerUmDia
    GuiControl, Font, QuerMaisDia
    GuiControl, Font, TextHora
    GuiControl, Font, TextData1
    GuiControl, Font, TextData2
    Gui, 2: Color, Default
    GuiControl, Show, Cebra_preto
    GuiControl, Hide, Cebra_branco
    
}
Return


SetStaticColor(hStatic, b_color, f_color := 0)
{
   static arr := [], GWL_WNDPROC := -4
   b_color := DllCall("Ws2_32\ntohl", UInt, b_color << 8, UInt)
   f_color := DllCall("Ws2_32\ntohl", UInt, f_color << 8, UInt)
   hGui := DllCall("GetParent", Ptr, hStatic, Ptr)
   if !arr.HasKey(hGui)  {
      arr[hGui] := {}, arr[hGui].Statics := []
      arr[hGui].ProcOld := DllCall("SetWindowLong" . (A_PtrSize = 8 ? "Ptr" : ""), Ptr, hGui, Int, GWL_WNDPROC
                                    , Ptr, RegisterCallback("WindowProc", "", 4, Object(arr[hGui])), Ptr)
   }
   else if arr[hGui].Statics.HasKey(hStatic)
      DllCall("DeleteObject", Ptr, arr[hGui].Statics[hStatic].hBrush)
   arr[hGui].Statics[hStatic] := { b_color: b_color, f_color: f_color
                                 , hBrush: DllCall("CreateSolidBrush", UInt, b_color, Ptr) }
   WinSet, Redraw,, ahk_id %hStatic%
}

WindowProc(hwnd, uMsg, wParam, lParam)
{
   Critical
   static WM_CTLCOLORSTATIC := 0x138
   obj := Object(A_EventInfo)
   if (uMsg = WM_CTLCOLORSTATIC && k := obj.Statics[lParam])  {
      DllCall("SetBkColor", Ptr, wParam, UInt, k.b_color)
      DllCall("SetTextColor", Ptr, wParam, UInt, k.f_color)
      Return k.hBrush
   }
   Return DllCall("CallWindowProc", Ptr, obj.ProcOld, Ptr, hwnd, UInt, uMsg, Ptr, wParam, Ptr, lParam)
}
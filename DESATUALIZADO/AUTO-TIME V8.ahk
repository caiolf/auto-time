; INTERFACE
; AUTOR: CAIO
; DATA DE ESCRITA: 11/2020
; O PROGRAMA INICIA AQUI


CriarGui2() ;NESTA LINHA CHAMAMOS A FUNÇÃO CRIARGUI2().
Return

;----------------CONFIRMAR----------------------
CONFIRMAR:
{   
    ; ------TRATAMENTO DE ERROS INCIAIS---------
    
    Msgbox, 0x04, Aviso, Confirma a inclusao do tempo?
    IfMsgbox, No
        Return
    Gui, 2: Submit, nohide
    Gui, 2: Default
    CoordMode, Mouse, Relative ;Adaptando coordenadas para cada janela específica
    ; ---------IF'S-------------
    if !WinExist("SIGEWin - Entrada de Tempos - Asstec/OS") ;Inicia o sige caso nao tenha iniciado
        INICIAR_SIGE()
    WinActivate, SIGEWin - Entrada de Tempos - Asstec/OS
    if WinExist("Warning") ;Mata a janela de warning
    WinKill, Warning
    WinWaitActive, SIGEWin - Entrada de Tempos - Asstec/OS ;Aguarda a janela de tempo estabilizar

    PixelGetColor, pColor, 187, 354, RGB ;Identifica que o tempo está setado "Fim"
	if (pColor = "0xFF0000")
        MouseClick, left, 550, 442, ,0 ;Limpa a entrada de tempo
    PixelGetColor, pColor, 184, 352, RGB ;Identifica que o tempo está setado "Inicio"
	if (pColor = "0x0000FF")
        MouseClick, left, 550, 442, ,0 ;Limpa a entrada de tempo

    if WinExist("Tempos Lidos - SIGEWin") ; Fecha o relatório de tempos, caso esteja aberto.
        WinKill, Tempos Lidos - SIGEWin
    
    ;-------Escolha das radios-----------
    OnlyTimeWindow() ;Faz aparecer somente a janela de entrada de tempo
    if (QuerEntrar) ;Rotina de entrada
    {
        RotinaDeTempo(1, ASSTEC, ETAPA, PESSOA) 
        EntrarRetro(BoxHora, MyDateTime, QuerUmDia, Ignore, Ignore)
        if WinExist("Warning")
            Return
    }
    if (QuerSair) ;Rotina de saída
    {
        RotinaDeTempo(0, ASSTEC, ETAPA, PESSOA) 
        EntrarRetro(BoxHora, MyDateTime, QuerUmDia, Ignore, Ignore)
        if WinExist("Warning")
            Return
    }    
    if (QuerUmDia) ;Rotina de um dia
        OneDay(ASSTEC, ETAPA, PESSOA, MyDateTime, QuerUmDia, Ignore, Ignore)
    if (QuerMaisDia) ;Rotina de varios dias
    {
        FormatTime, data1, %MyDateTime%, d
        FormatTime, data2, %MyLaterTime%, d
        if(data2 < data1)
        {
            msgbox, 0x10, Erro, O dia final nao pode ser menor do que o dia inicial!
            Return
        }
        Loop
        {
            OneDay(ASSTEC, ETAPA, PESSOA, MyDateTime, QuerUmDia, QuerMaisDia, data1)
            if (data1 = data2)
                Break
            data1++
        }
    }
      
    WinActivate, INTERFACE ;APÓS FINALIZAR A ENTRADA, ABRE NOVAMENTE O PROGRAMA
}
Return

CONSULTANDO:
{   
    if WinExist("Warning") ;Mata a janela de warning
        WinKill, Warning
    Gui, 2: Submit, nohide
    Gui, 2: Default
    CoordMode, Mouse, Relative ;Adaptando coordenadas para cada janela específica
    ; ---------IF'S-------------
    if !WinExist("SIGEWin - Entrada de Tempos - Asstec/OS") ;Inicia o sige caso nao tenha iniciado
        INICIAR_SIGE()  
        
    if !WinExist("Tempos Lidos - SIGEWin")
    {   
        OnlyTimeWindow() ;Faz aparecer somente a janela de entrada de tempo 
        Send, !v ;Acessar o alt v
        WinWaitActive, Login
        MouseClick, left, 148, 76, ,0
        Send, R{Enter}
        Send, {Tab}
        SendInput, r3170{Enter} ;Senha
    }   
    WinActivate, Tempos Lidos - SIGEWin     
    WinWaitActive, Tempos Lidos - SIGEWin  
    ConsultarEspecifico(PESSOA) 
}
Return

TESTANDO:
CriarGui3()
Sleep, 5000
MsgBox, TROUXA
IfMsgBox, OK
    Gui, 3: Destroy
Return

Help:
Run, \\servidor\desenv\USUARIOS\Caio\PROGRAMAÇÃO\AutoHotkey\AUTO-TIME\help.txt
Return

;---------------SAINDO DO APP-------------------

2GuiClose: 
ExitApp

3GuiClose:
Gui, 3: Destroy
Return

Escape::
if WinActive("INTERFACE")
    ExitApp 


;*******************
;*                 *
;*    Includes     *
;*                 *
;*******************
#include %A_ScriptDir%
#include addTooltip.ahk
#include functions.ahk
#include guiControl.ahk

#NoEnv
#SingleInstance Force
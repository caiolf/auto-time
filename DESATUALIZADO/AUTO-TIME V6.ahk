; INTERFACE
; AUTOR: CAIO
; DATA DE ESCRITA: 11/2020
; O PROGRAMA INICIA AQUI


CriarGui2() ;NESTA LINHA CHAMAMOS A FUNÇÃO CRIARGUI2().
Return

;----------------CONFIRMAR----------------------
INICIANDO:
{
    Msgbox, 0x04, Aviso, Confirma a inclusao do tempo?
    IfMsgbox, No
        Return
    Gui, 2: Submit, nohide
    Gui, 2: Default
    CoordMode, Mouse, Relative ;Adaptando coordenadas para cada janela específica
    ; ---------IF'S-------------

    if WinExist("Tempos Lidos - SIGEWin") ; Fecha o relatório de tempos, caso esteja aberto.
        WinKill, Tempos Lidos - SIGEWin
    if !WinExist("SIGEWin - Entrada de Tempos - Asstec/OS") ;Inicia o sige caso nao tenha iniciado
        INICIAR_SIGE()

    ;-------Escolha das radios-----------
    
    if QuerEntrar = 1 ;Rotina de entrada
    {
        RotinaDeTempo(1, ASSTEC, ETAPA, PESSOA) 
        EntrarRetro(BoxHora, MyDateTime, QuerUmDia)
    }
    if QuerSair = 1 ;Rotina de saída
    {
        RotinaDeTempo(0, ASSTEC, ETAPA, PESSOA) 
        EntrarRetro(BoxHora, MyDateTime, QuerUmDia)
    }
    if QuerUmDia = 1 ;Rotina de um dia
        OneDay(ASSTEC, ETAPA, PESSOA, MyDateTime)
    if QuerMaisDia = 1
    {
        
        FormatTime, DiaFinal, %MyDateTime%, dd
        Loop{
            OneDay(ASSTEC, ETAPA, PESSOA, MyDateTime)
            if (DiaInicial = DiaFinal)
                Break
            FormatTime, DiaInicial, %MyDateTime%, dd
            DiaInicial++
        }
    }   
    WinActivate, INTERFACE ;APÓS FINALIZAR A ENTRADA, ABRE NOVAMENTE O PROGRAMA
}
Return
TESTANDO:
{ 
    MsgBox, Testando 123...
    
    ;FormatTime MyDateTime, DD
    ;MsgBox, %MyDateTime%
}
Return

CONSULTANDO:
{
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

;---------------SAINDO DO APP-------------------

2GuiClose: 
ExitApp

Escape::
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
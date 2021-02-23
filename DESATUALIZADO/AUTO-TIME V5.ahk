; AUTO-TIME
; AUTOR: CAIO
; DATA DE ESCRITA: 11/2020
; O PROGRAMA INICIA AQUI

Habilitar_gui1:= 0 ;1 para habilitar a interface de senha e 0 para ir direto para a interface central
If Habilitar_gui1
{
    Menu, Tray, Icon, \\servidor\desenv\USUARIOS\Caio\PROGRAMAÇÃO\AutoHotkey\AUTO-TIME\pictures\time-orange.ico
    Gui, Font, s16 w700
    Gui, Add, Text, x20 y20 w560 Center, ENTRADA DE TEMPO
    Gui, Add, Picture, x150 y90 w300 h-1 Center, \\servidor\desenv\USUARIOS\Caio\IMAGENS\cebra_transparente.png
    Gui, Font
    Gui, Font, s12 w700
    Gui, Add, Text, x20 y280 w560 Center, Insira a senha abaixo para continuar
    Gui, Add, Text, 
    Gui, add, Edit, Password x200 y310 w200 Limit12 vSENHA_INSERIDA
    Gui, add, Button, x250 y350 w100 gAbrir_Interface, Entrar
    Gui, show, w600 h400, AUTO-TIME V5.0
    Enter::Send, {Tab}{Enter}
    NumpadEnter::Send, {Tab}{Enter}
    Return
}

Abrir_Interface:
{
    Gui, Submit, nohide
    If !(SENHA_INSERIDA = "r3170") and (Habilitar_gui1) ;;;;;SENHA;;;;;;
    {
        msgbox, 0x10, Erro, A senha digitada esta incorreta! Tente novamente ou procure o suporte!
        Return
    }   

    CriarGui2() ;NESTA LINHA CHAMAMOS A FUNÇÃO CRIARGUI2().

    GoSub, GuiClose ;Fecha o GUI para deixar apenas o GUI2
    Return
}   

    

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
    if !WinExist("SIGEWin - Entrada de Tempos - Asstec/OS") ;Inicia o sige caso nao tenha iniciado
        INICIAR_SIGE()
    OnlyTimeWindow() ;Faz aparecer somente a janela de entrada de tempo
    Send, !v ;Acessar o alt v
    MouseClick, left, 148, 76
    Send, R{Enter}
    Send, {Tab}
    Send, r3170{Enter} ;Senha
    WinActivate, Tempos Lidos - SIGEWin     
    WinWaitActive, Tempos Lidos - SIGEWin 
    
    ConsultarEspecifico(PESSOA) 
}
Return
;---------------SAINDO DO APP-------------------
GuiClose: ; Termina o programa se o GUI2 nao for chamado
if !WinExist("INTERFACE")
    ExitApp
Gui, 1: Destroy ; Se o GUI2 foi chamado, a janela apenas é destruída
Return

2GuiClose: 
ExitApp
Reload
Return

Escape::
ExitApp 


;*******************
;*                 *
;*    Functions    *
;*                 *
;*******************
#include %A_ScriptDir%
#include AddTooltip.ahk
#include Functions.ahk

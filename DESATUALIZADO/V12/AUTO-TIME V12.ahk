; INTERFACE
; AUTOR: CAIO
; DATA DE ESCRITA: 11/2020
; O PROGRAMA INICIA AQUI


CriarGui2() ;NESTA LINHA CHAMAMOS A FUNÇÃO CRIARGUI2().
Return

;----------------PRIMEIRA ABA----------------------
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
        INICIAR_SIGE(0) ;0 para entrada de tempos e 1 para o aplicativo do sige
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
    Gui, 2: Submit, nohide
    Gui, 2: Default
    CoordMode, Mouse, Relative ;Adaptando coordenadas para cada janela específica

    if WinExist("Warning") ;Mata a janela de warning
        WinKill, Warning

    ; ---------IF'S-------------
    if !WinExist("SIGEWin - Entrada de Tempos - Asstec/OS") ;Inicia o sige caso nao tenha iniciado
        INICIAR_SIGE(0) ;0 para entrada de tempos e 1 para o aplicativo do sige
        
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
    ;Caso esteja maximizado, voltar a ser janela pequena
    WinRestore, Tempos Lidos - SIGEWin
    ConsultarEspecifico(PESSOA) 
}
Return

CONSULTANDO_SIGE:
{   
    Gui, 2: Submit, nohide
    Gui, 2: Default
    WinActivate, SIGEWin - Sistema Integrado de Gestão Empresarial
    ; CASO ELE ESTEJA NA ABA DE MAO DE OBRA
    Text:=Text:="|<>*120$58.000000000000000000024000U10E08E00208000V0008000024QnUZWCHUDm+12N95F0V8cw94Y5424WYEYGEIE8G+F2F95F0V78w94XYs000000000000000000000000000008"
    if (ok:=FindText(686-150000, 291-150000, 686+150000, 291+150000, 0, 0, Text)){
        ;Caso esteja maximizado
        Text:="|<>*120$56.0000000000000000000y00080+008E20202U0240U0U0c00V7BbD7+lkDW+E+8+mW24yYSWSccUV898cce+88G+G+++WW24QISwScb00000000000000000008"
        if (ok:=FindText(1136-150000, 136-150000, 1136+150000, 136+150000, 0, 0, Text))
            MouseClick, Left, 1242, 21, , 0
        MouseClick, Left, 35, 63, , 0
    }
    ; Inicia o sige caso nao tenha iniciado
    if !WinExist("SIGEWin - Sistema Integrado de Gestão Empresarial") 
        INICIAR_SIGE(1) ;0 para entrada de tempos e 1 para o aplicativo do sige
    WinActivate, SIGEWin - Sistema Integrado de Gestão Empresarial
    ; CASO A JANELA DE REGISTRO DE TEMPO DA ASTEC NAO ESTEJA ABERTA, ELA ABRE
    Encerramento:="|<>*120$68.000000000007k000000000100000000080E000000002042llnNngQgnVsmWWY2Ycgd4E8cDd7d/u+F42+22G+GUWYF0WWWYWYccd4T8b797d9m9C00000000000000000000000U"
    if !(ok:=FindText(462-150000, 163-150000, 462+150000, 163+150000, 0, 0, Encerramento))
    {
        Loop{ ;SIGEWin - Sistema Integrado de Gestão Empresarial
        Sleep, 100
        if (ok:=FindText(245-150000, 117-150000, 245+150000, 117+150000, 0, 0, "|<>*125$66.0000000000000000000000000000000000T8zk1z4Tzw1VsD0D1w7UQ30MD0S0Q7UA308D0w0A7U47U8D1w0A7U07k8D1w047V03w0D3s007V03z0D3s007X01zkD3s007z00TsD3s007X00DwD3s7z7V041wD3s1w7V040wD1s1w7U060QD1w1w7U260QD0w1w7U670MD0S1w7U47UkD0D1s7kQ4T0zk1z0Tzw0000000000000000000000U"))
            Break
        }
        MouseClick, left, 465, 39, ,0
        MouseClick, left, 465, 220, ,0
        Loop{ ;Localizando janela de registro de asstec
            Sleep, 100
            Encerramento:="|<>*120$68.000000000007k000000000100000000080E000000002042llnNngQgnVsmWWY2Ycgd4E8cDd7d/u+F42+22G+GUWYF0WWWYWYccd4T8b797d9m9C00000000000000000000000U"
            if (ok:=FindText(462-150000, 163-150000, 462+150000, 163+150000, 0, 0, Encerramento))
                Break
        }
    }
    ; AÇÃO DENTRO DA JANELA DE ASSTEC
    WinKill, SIGEWin - Registro de Assistência Técnica
    MouseClick, Left, 66, 440, , 0
    Send, 01012000
    Send, {Tab}{Tab}{Enter}{Tab}{Tab}{Tab}
    Sleep, 300
    SendInput, %ASSTEC%
    MouseClick, left, 238, 63, ,0

}
Return

SIGE:
If WinExist("Sistema Integrado de Gestão Empresarial"){
    MsgBox, Sige já se encontra aberto!
    Return
}
INICIAR_SIGE(1)
WinWaitActive, Sistema Integrado de Gestão Empresarial
MouseClick, Left, 60, 260, , 0
MouseClick, Left, 300, 730, , 0
Return

Help:
Run, \\servidor\desenv\USUARIOS\Caio\PROGRAMAÇÃO\AutoHotkey\AUTO-TIME\help.txt
Return
;----------------SEGUNDA ABA----------------------
TESTANDO2:
Return

;----------------TEST ZONE---------------------
TESTANDO:
{
    CriarGui3()
    Sleep, 5000
    MsgBox, TROUXA
    IfMsgBox, OK
        Gui, 3: Destroy
    Return
}
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
#Include FindText.ahk
#SingleInstance ForceP15
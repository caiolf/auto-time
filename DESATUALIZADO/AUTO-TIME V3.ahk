; GESTOR DE TAREFAS.AHK
; AUTOR: GIO
; LINK DO POST: https://autohotkey.com/boards/viewtopic.php?p=213650#p213650
; DATA DE ESCRITA: 21/05/2018
; DESCRIÇÃO DO PROGRAMA: GERENCIADOR DE TAREFAS COM ROTINAS DE INCLUSAO E VISUALIZAÇÃO DE TAREFAS E DE SEUS ANDAMENTOS EM TABELAS
; O PROGRAMA INICIA AQUI
; ESTA PORÇÃO INICIAL ABRE A PRIMEIRA TELA, ONDE O USUÁRIO DEVE COLOCAR A SENHA ABACAXI.

Gui, Font, s16 w700
Gui, Add, Text, x20 y20 w560 Center, ENTRADA DE TEMPO
Gui, Font
Gui, Font, s12 w700
Gui, Add, Text, x20 y280 w560 Center, Insira a senha abaixo para continuar
Gui, Add, Text, 
Gui, add, Edit, Password x200 y310 w200 Limit12 vSENHA_INSERIDA
Gui, add, Button, x250 y350 w100 gAbrir_Agenda, Entrar ; AQUI TEM UMA G-LABEL! ISSO SIGNIFICA QUE QUANDO ESSE BOTAO DA PRIMEIRA TELA É PRESSIONADO, A LABEL ABRIR_AGENDA É EXECUTADA!
Gui, show, w600 h400, SisOrg v0.1
Return

Abrir_Agenda:
Gui, Submit, nohide
If !(SENHA_INSERIDA = "r3170") ; ESTA CONDICIONAL CHECA SE O USUÁRIO NÃO ESCREVEU ABACAXI NO CAMPO DE SENHA DA PRIMEIRA TELA. SE ELE NÃO ESCREVEU, EXIBE UM ERRO E RETORNA A EXECUÇÃO SEM PROSSEGUIR.
{
	msgbox, 0x10, Erro, A senha digitada esta incorreta! Tente novamente ou procure o suporte!
	Return
}
;NESTA LINHA CHAMAMOS A FUNÇÃO CRIARGUI2().  ASSIM, A EXECUÇÃO PULARÁ ATÉ O CÓDIGO DELA (PROCURE POR ELE ABAIXO). A FUNÇÃO NOS PERMITE SEPARAR E ORGANIZAR O CÓDIGO LONGO, VEZ QUE AQUI IRIAM MUITAS LINHAS RELACIONADAS SOMENTE A CRIAR A JANELA, POR ISSO, SEPARAMOS ELAS EM UMA FUNÇÃO PRÓPRIA. ASSIM, SE QUISER VER AS LINHAS QUE LIDAM COM A CRIAÇÃO DA TELA 2, BASTA IR NO CORPO DA FUNÇÃO CRIARGUI2(), QUE É AGORA UM PASSO SEPARADO DA ROTINA ABRIR_AGENDA.
CriarGui2() 

GoSub, GuiClose
Return

; A FUNÇÃO ABAIXO CRIA A TELA 2. VEJA QUE TODOS OS COMANDOS VEM ANTES DO COMANDO SHOW (QUE É O ÚLTIMO).
CriarGui2()
{
	global
	Gui, 2: Font, s12 w700
	Gui, 2: Add, GroupBox, x40 y60 w720 h400, NOVA INCLUSAO
	Gui, 2: Add, Text, x60 y90, ASSTEC
	Gui, 2: Add, Edit, x60 y110 w600 Number UPPERCASE vASSTEC
	Gui, 2: Add, Text, x60 y150, Etapa
	Gui, 2: Add, Edit, x60 y170 w600 UPPERCASE vETAPA
	Gui, 2: Add, Text, x60 y210, Ser Humaninho
	Gui, 2: Add, Edit, x60 y230 w600 UPPERCASE vPESSOA

    Gui, 2: Add, Radio, x60 y280 vQuerEntrar, Entrar.
    Gui, 2: Add, Radio, x160 y280 vQuerSair, Sair.
    Gui, 2: Add, Radio, x260 y280 vQuerUmDia, Entrar um dia completo.

    Gui, 2: Add, Text, x60 y310, Horario 
    Gui, 2: Add, DateTime, x60 y330 w70 vHORARIO_ENTRADA, time
    Gui, 2: Add, Text, x260 y310, Data
    Gui, 2: Add, DateTime, x260 y330 vMyDateTime, LongDate
	Gui, 2: Add, Button, x60 y420 gINICIAR_ENTRADA, CONFIRMAR

	Gui, 2: Show, w800 h600, AUTO-TIME
}

Return

INICIAR_ENTRADA: ;ESTA LABEL É CHAMADA QUANDO O USUÁRIO CLICA NO BOTÃO "CONFIRMAR"
Msgbox, 0x04, Aviso, Confirma a inclusao do tempo?
IfMsgbox, No
{
	Msgbox, 0x10, Aviso, Inclusao da tarefa cancelada pelo usuario.
	Return
}
Gui, 2: Submit, nohide
Gui, 2: Default
CoordMode, Mouse, Relative ;Adaptando coordenadas para cada janela específica

if QuerUmDia = 1
    OneDay(ASSTEC, ETAPA, PESSOA, MyDateTime)
if QuerEntrar = 1
{
    RotinaDeTempo(1, ASSTEC, ETAPA, PESSOA)
    EntrarRetro(HORARIO_ENTRADA, MyDateTime, QuerUmDia)
}
if QuerSair = 1
{
    RotinaDeTempo(0, ASSTEC, ETAPA, PESSOA)
    EntrarRetro(HORARIO_ENTRADA, MyDateTime, QuerUmDia)
}
/*
Send, {Tab}
Send, {Enter}

WinActivate, Information ;Aviso de entrada de tempo concluída
Sleep, 100 ;Delay para aparecer a Msgbox do SIGE
PixelGetColor, pColor, -71, 315, RGB
If (pColor = "0xFF0000")
{
    msgbox, 0x10, Erro, Voce ja entrou no tempo! Tente novamente ou procure o suporte!
    Return
}
Else
    MouseClick, left, 184, 104 ;Finalizando entrada
*/
;ENTRADA RETROATIVA

OneDay(ASSTEC, ETAPA, PESSOA, MyDateTime)
{
    ;Msgbox, Funcionou!
    switch PESSOA ;Horário de trabalho adaptativo adaptado para cada mebro do desnv.
    {
        case "c": 
            hora_inicial := 070000
            hora_final :=164800
        case "f": 
            hora_inicial := 070000
            hora_final :=164800
        case "j":
            hora_inicial := 070000
            hora_final :=164800
        case "a":
            hora_inicial := 073000 
            hora_final :=171800
        case "r":
            hora_inicial := 074500 
            hora_final :=173300
        case "v":
            hora_inicial := 080000 
            hora_final :=174800
    }
    ;Rotina de tempo: 1 para entrar e 0 para sair
    RotinaDeTempo(1, ASSTEC, ETAPA, PESSOA)
    EntrarRetro(hora_inicial, MyDateTime, QuerUmDia) 

    RotinaDeTempo(0, ASSTEC, ETAPA, PESSOA)
    EntrarRetro(120000, MyDateTime, QuerUmDia)

    RotinaDeTempo(1, ASSTEC, ETAPA, PESSOA)
    EntrarRetro(130000, MyDateTime, QuerUmDia)

    RotinaDeTempo(0, ASSTEC, ETAPA, PESSOA)
    EntrarRetro(hora_final, MyDateTime, QuerUmDia)
}
Return

RotinaDeTempo(Estado, ASSTEC, ETAPA, PESSOA)
{
    WinMinimizeAll ;Minimizar todas as janelas
    WinActivate, SIGEWin - Entrada de Tempos - Asstec/OS ;Somente a janela de entrada de tempos ativa

    MouseClick, left, 150,95 ;Asstec
    Send, %ASSTEC%{Tab} ;Asstec
    Send, %ETAPA%{Tab} ;Etapa
    Send, %ETAPA%{Tab} ;Atividade
    switch ETAPA ;Máquina de acordo com a ETAPA
    {
        case "P01":   Send, 38{Tab}
        case "P02":   Send, 38{Tab}
        case "P03":   Send, 38{Tab}
        case "P04":   Send, 38{Tab}
        case "P13":   Send, 38{Tab}
        case "P14":   Send, 38{Tab}
        case "P15":   Send, 38{Tab}
        case "P09":   Send, 38{Tab}
        case "P06":   Send, 35{Tab}
        case "P08":   Send, 35{Tab}
        case "P05":   Send, 39{Tab}
    }
    switch PESSOA ;Operador
    {
        case "c":   Send, 00562607
        case "a":   Send, 00561297
        case "f":   Send, 00560078
        case "r":   Send, 00561723
        case "v":   Send, 00561419
        case "j":   Send, 00560924
    }
    if Estado = 1
        Send, {F2} ;Início
    Else
        Send, {F3} ;Fim
    Return
}
Return

EntrarRetro(Hora, MyDateTime, QuerUmDia)
{
    Send, ^h ;Acessar o ctrl H
    MouseClick, left, 148, 76
    Send, R{Enter}
    Send, {Tab}
    Send, r3170{Enter} ;Senha
    FormatTime, MyDate, %MyDateTime%, ddMMyyyy
    Send, %MyDate%{Tab}
    if (QuerUmDia = 0) ;Ou seja, se a pessoa estiver apenas entrando ou saindo
    {
        FormatTime, MyHour, %Hora%, HHmmss
        Send, %MyHour%{Enter}
    }
    Else
        Send, %Hora%{Enter}
    Sleep, 100 ;Delay para aparecer a Msgbox do SIGE
    MouseClick, left, 184, 104 ;Finalizando entrada
}
Return

INICIAR_SIGE()
{
	Run, \\servidor\sigewin\Arquivos de Programas\SIGEWin\TemposAsstec.exe
	WinActivate, SIGEWin
	CoordMode, Mouse
	MouseClick, left, 650, 400
	Send, sige
	MouseClick, left, 690, 448
}
Return

; ESTA LABEL EXECUTA QUANDO O USUÁRIO OU O PROGRAMA FECHA A TELA 1. ELA APENAS TERMINA O PROGRAMA (SE O USUARIO FECHOU) OU DESTROI A TELA 1 (SE O PROGRAMA FECHOU PARA ABRIR A TELA 2).
GuiClose:
IfWinNotExist, AUTO-TIME
{
	ExitApp
}
Gui, 1: Destroy
Return

; ESTA LABEL EXECUTA QUANDO O USUARIO FECHA A TELA 2. ELA APENAS DESTROI A TELA 2 E DEPOIS REINICIA O PROGRAMA.  PARA FECHAR O PROGRAMA, O USUARIO DEVE FECHAR A TELA 1 CLICANDO NO X.
2GuiClose:
Gui, 2: Destroy
Reload
Return

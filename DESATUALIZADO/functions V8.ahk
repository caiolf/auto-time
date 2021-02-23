;Rotina de tempo de um dia inteiro
CriarGui2()
{
	global
    ajusteX:= 250
	Gui, 2: Font, s12 w700
	Gui, 2: Add, GroupBox, x40 y60 w650 h400, Nova Inclusao de Tempo
    ;---------ENTRADA DE DADOS-------------
    Gui, 2: Add, Text, x600 y20, ESC para sair
	Gui, 2: Add, Text, x60 y90, ASSTEC
	Gui, 2: Add, Edit, x60 y110 w150 Number Limit5 UPPERCASE vASSTEC
	Gui, 2: Add, Text, x60 y150, Etapa
    Gui, 2: Add, ComboBox, x60 y170 w150 HwndButtonHwnd Limit UPPERCASE vETAPA, P01|P02|P03|P04|P05|P06|P08|P09|P10|P11|P12|P13|P14|P15|AT10|AT20|AT30|AT40|AT50
	AddToolTip(ButtonHwnd, "P01 - Especificacao`nP02 - Esquematico`nP03 - Layout da PCI`nP04 - Desenho mecanico`nP05 - Doc. e conf. da PCI`nP06 - Montagem do prototipo`nP08 - Teste eletrico e mecanico`nP09 - Artefatos e doc. prod.`nP10 - Montagem do lote piloto`nP11 - Teste do lote piloto`nP12 - Teste do produto final`nP13 - Doc. e instalacao de uso`nP14 - Verif. de instalacao/uso`nP15 - Estudo de novos prod./processos`nAT10 - Manutencao`nAT20 - Teste eletrico de PCI`nAT30 - Montagem mecanica`nAT40 - Isnpecao/embalgem/expedicao`nAT50 - Relatorio assistencia tec.")	
    Gui, 2: Add, Text, x60 y210, Pessoa
    Gui, 2: Add, ComboBox, x60 y230 w56 HwndButton2Hwnd Limit UPPERCASE vPESSOA gLabelPessoa, F|R|A|C|V|J
    AddToolTip(Button2Hwnd, "F - Rafa`nR - Robson`nA - Japa`nC - Caio`nV - Victor`nJ - Junior")
    ;-------------RADIOS------------------
    Gui, 2: Add, Radio, x60 y280 vQuerEntrar gLabelReset, Entrar.
    Gui, 2: Add, Radio, x160 y280 vQuerSair gLabelReset, Sair.
    Gui, 2: Add, Radio, x260 y280 vQuerUmDia gLabelUmDia, Entrar um dia completo.
    Gui, 2: Add, Radio, x500 y280 HwndManutencao vQuerMaisDia gLabelMaisDia, Entrar varios dias.
    AddToolTip(Manutencao, "Cuidado com os finais de semama!")
    ;------------DATETIMES-----------------
    Gui, 2: Add, Text, x60 y310 vTextHora, Horario ;TEXTO DO HORARIO
    Gui, 2: Add, DateTime, x61 y330 w70 vBoxHora, Time ;ENTRAR HORA
    Gui, 2: Add, Text, x225 y310 vTextData1, Data: ;TEXTO DA DATA
    Gui, 2: Add, DateTime, x225 y330 vMyDateTime, LongDate ;ENTRAR DATA
    Gui, 2: Add, Text, x225 y384 vTextData2 Hidden, Ate: ;DECLARAR SEGUNDA DATA
    Gui, 2: Add, DateTime, x225 y404 vMyLaterTime Hidden, LongDate ;ENTRAR SEGUNDA DATA
    ;-------------IMAGENS-----------------
	;Gui, 2: Add, Picture, x530 y80 w150 h-1,\\servidor\desenv\USUARIOS\Caio\IMAGENS\cebra_transparente.png
    Gui, 2: Add, Picture, x300 y100 w300 h-1,\\servidor\desenv\USUARIOS\Caio\IMAGENS\cebra_transparente.png
    Gui, 2: Add, Picture, x250 y10 w200 h-1, \\servidor\desenv\USUARIOS\Caio\IMAGENS\auto-time-dragon.png
    ;-------------BUTTONS-----------------
    Gui, 2: Add, Button, x60 y380 gRESETANDO vHoraBt, RESET`nData/Hora ;RESETAR HORA
	Gui, 2: Add, Button, x60 y480 vBt gCONFIRMAR Disabled, CONFIRMAR ;CONFRIMAR ENTRADA
    Gui, 2: Add, Button, x600 y480 vTest gTESTANDO, TESTE
    Gui, 2: Add, Button, x340 y480 gHelp, HELP
    Gui, 2: Add, Button, x116 y228 HwndConsult vConsultar gCONSULTANDO Disabled, Consultar
    AddToolTip(Consult, "Clique aqui para consultar sua entrada de tempo no sige")
    ;---------MOSTRAR INTERFACE------------
	;Gui, 2: Show, w740 h800, INTERFACE
    Gui, 2: Show, w740 h550, INTERFACE
    AddToolTip("AutoPopDelay", 20)
} 
Return

OneDay(ASSTEC, ETAPA, PESSOA, MyDateTime, QuerUmDia, QuerMaisDia, data1)
{
    ;Msgbox, Funcionou!
    switch PESSOA ;Horário de trabalho adaptativo para cada membro do desnv.
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
    EntrarRetro(hora_inicial, MyDateTime, QuerUmDia, QuerMaisDia, data1) ;ENTRA DE MANHÃ

    RotinaDeTempo(0, ASSTEC, ETAPA, PESSOA)
    EntrarRetro(120000, MyDateTime, QuerUmDia, QuerMaisDia, data1) ;SAI DE MANHÃ

    RotinaDeTempo(1, ASSTEC, ETAPA, PESSOA)
    EntrarRetro(130000, MyDateTime, QuerUmDia, QuerMaisDia, data1) ;ENTRA DE TARDE

    RotinaDeTempo(0, ASSTEC, ETAPA, PESSOA)
    EntrarRetro(hora_final, MyDateTime, QuerUmDia, QuerMaisDia, data1) ;SAI DE TARDE
}
Return

RotinaDeTempo(Estado, ASSTEC, ETAPA, PESSOA)
{
    MouseClick, left, 150, 95, ,0 ;Asstec
    SendInput, %ASSTEC%{Tab} ;Asstec
    SendInput, %ETAPA%{Tab} ;Etapa
    SendInput, %ETAPA%{Tab} ;Atividade
    switch ETAPA ;Máquina de acordo com a ETAPA
    {
        case "P01":   SendInput, 38{Tab}
        case "P02":   SendInput, 38{Tab}
        case "P03":   SendInput, 38{Tab}
        case "P04":   SendInput, 38{Tab}
        case "P13":   SendInput, 38{Tab}
        case "P14":   SendInput, 38{Tab}
        case "P15":   SendInput, 38{Tab}
        case "P09":   SendInput, 38{Tab}
        case "P06":   SendInput, 35{Tab}
        case "P08":   SendInput, 35{Tab}
        case "P05":   SendInput, 39{Tab}
        case "AT10":  SendInput, 35{Tab}
        case "AT20":  SendInput, 35{Tab}
        case "AT30":  SendInput, 40{Tab}
        case "AT40":  SendInput, 40{Tab}
        case "AT50":  SendInput, 38{Tab}
        Default:
            msgbox, 0x10, Erro, Etapa nao cadastrada no sistema AUTO-TIME!
	        Return
    }
    switch PESSOA ;Operador
    {
        case "c":   SendInput, 00562607
        case "a":   SendInput, 00561297
        case "f":   SendInput, 00560078
        case "r":   SendInput, 00561723
        case "v":   SendInput, 00561419
        case "j":   SendInput, 00560924
        Default:
            msgbox, 0x10, Erro, Pessoa nao cadastrada no sistema AUTO-TIME!
	        Return
    }
    if Estado = 1
        Send, {F2} ;Início
    Else
        Send, {F3} ;Fim
    Return
}
Return

EntrarRetro(Hora, MyDateTime, QuerUmDia, QuerMaisDia, data1)
{
    Send, ^h ;Acessar o ctrl H
    WinWaitActive, Login
    MouseClick, left, 148, 76, ,0
    Send, R{Enter}
    Send, {Tab}
    SendInput, r3170{Enter} ;Senha
    if (QuerMaisDia) ;Se o usuario clicou em "Entrar vários dias"
    {
        FormatTime, mesAno, %MyDateTime%, MMyyyy ;Formata o mes e o ano
        if data1 < 10
            Send, 0 ;entra com o zero ao lado da casa decimal
        SendInput, %data1% ;Entra com o dia 
        SendInput, %mesAno%{Tab} ;Entra com o mes e o ano
    }
    else
    {
        FormatTime, MyDate, %MyDateTime%, ddMMyyyy
        SendInput, %MyDate%{Tab}
    }

    if !(QuerUmDia or QuerMaisDia) ;Ou seja, se a pessoa estiver apenas entrando ou saindo
    {
        FormatTime, MyHour, %Hora%, HHmmss
        SendInput, %MyHour%{Enter}
    }
    else
        SendInput, %Hora%{Enter}
    Sleep, 100
    if WinExist("Warning")
        Return
    WinWaitActive, Information ;Delay para aparecer a Msgbox do SIGE
    MouseClick, left, 184, 104, ,0 ;Finalizando entrada
}
Return

INICIAR_SIGE()
{
    Send, #r ;Atalho para abrir o Executar do Windows
    WinWaitActive, Executar
    SendInput, \\servidor\sigewin\Arquivos de Programas\SIGEWin\TemposAsstec.exe{Enter}
    WinMinimizeAll
	WinActivate, Database Login
    WinWaitActive, Database Login
    Sleep, 100
	SendInput, sige{Enter}
}
Return

ConsultarEspecifico(P)   
{    
    MouseClick, left, 670, 510, ,0 ;Seleciona caixa de texto onde fica os nomesra 
    Sleep, 100
    switch P ;Horário de trabalho adaptativo para cada membro do desnv.
    {
        case "c":   
            Send, c
            MouseClick, left, 670, 580, ,0 
        case "f": 
            Send, r
            MouseClick, left, 670, 605, ,0 
        case "j":
            SendInput, joe
            MouseClick, left, 670, 565, ,0 
        case "a":
            Send, a
            MouseClick, left, 670, 565, ,0
        case "r":
            SendInput, ro
            MouseClick, left, 670, 580, ,0 
        case "v":
            SendInput, vi
            Send, {Down}{Down}{Down}{Down}
            MouseClick, left, 670, 605, ,0 
        Default:
            msgbox, 0x10, Erro, Pessoa nao cadastrada no sistema AUTO-TIME!
	        Return
    }
    MouseClick, left, 670, 540, ,0
    MouseMove, 396, 318, 0
}
Return

OnlyTimeWindow()    
{       
    WinActivate, SIGEWin - Entrada de Tempos - Asstec/OS ;Somente a janela de entrada de tempos ativa
    WinWaitActive, SIGEWin - Entrada de Tempos - Asstec/OS  
    MouseClick, left, 150, 70, ,0
}   
Return

CriarGui3()
{
    global
    Gui, 3: Font, s12 w700
    Gui, 3: Add, Text, x10 y10 , Aguarde...
    ;Gui, 3: Add, Progress, w300 h20 BackgroundC9C9C9 vMyProgress, 50
    Gui, 3: Add, Progress, w300 h20 hwndMARQ4 -0x00000001 +0x00000008, 50
    DllCall("User32.dll\SendMessage", "Ptr", MARQ4, "Int", 0x00000400 + 10, "Ptr", 1, "Ptr", 50)
    Gui, 3: Show, AutoSize
    
}
Return
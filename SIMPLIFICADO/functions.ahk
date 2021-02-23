
;==========================
;=========BACK-END=========
;==========================

;Rotina de tempo de um dia inteiro
CriarGui2()
{
	global
    Gui, 2: Font, s8 w600, Calibri
    gui, 2: add, text, x640 y536 w50 vText12, By Caio
    Gosub, darkMode
	;Gui, 2: Add, TEXT, x40 y60 hwndText0, Nova Inclusao de Tempo
    ;---------ENTRADA DE DADOS-------------
    Gui, 2: Add, Text, x580 y20 vText1, ESC para sair
	Gui, 2: Add, Text, x60 y90 vText2, ASSTEC
	Gui, 2: Add, Edit, x60 y110 w150 Number Limit5 UPPERCASE gASSTECA vASSTEC
	Gui, 2: Add, Text, x60 y150 vText3, Etapa
    Gui, 2: Add, ComboBox, x60 y170 w150 HwndButtonHwnd Limit UPPERCASE vETAPA, P01|P02|P03|P04|P05|P06|P08|P09|P10|P11|P12|P13|P14|P15|AT10|AT20|AT30|AT40|AT50
	AddToolTip(ButtonHwnd, "P01 - DFEMEA`nP02 - PLACAS E ESQUEMATICOS`nP03 - CNC`nP04 - MECANICOS 3D`nP05 - CRIACAO DE GRUPO, DOC. DO MAGNETICO`nP06 - MONTAGEM DE PROTOTIPO, TESTE E AJUSTES`nP07 - DESENVOLVIMENTO DE FIRMWARE`nP08 - COMPATIBILIDADE`nP09 - CONFECCAO DE ARTEFATOS`nP10 - OF E SUPORTE A PRODUCAO`nP11 - ENSAIOS DO PROTOTIO NO LOTE PILOTO`nP12 - TESTES E ENSAIOS DO PRODUTO FINAL`nP13 - DOCUMENTOS PARA O CLIENTE`nP14 - ALTERACAO DO PROJETO PARA O CLIENTE`nP15 - PESQUISA DE NOVOS ITENS E PROCESSOS`nAT10 - Manutencao`nAT20 - Teste eletrico de PCI`nAT30 - Montagem mecanica`nAT40 - Isnpecao/embalgem/expedicao`nAT50 - Relatorio assistencia tec.")	
    Gui, 2: Add, Text, x60 y210 vText4, Pessoa
    Gui, 2: Add, ComboBox, x60 y230 w150 HwndButton2Hwnd Limit UPPERCASE vPESSOA gLabelPessoa, F|R|A|C|V|J
    AddToolTip(Button2Hwnd, "F - Rafa`nR - Robson`nA - Japa`nC - Caio`nV - Victor`nJ - Junior")
    ;-------------RADIOS------------------
    Gui, 2: Add, Radio, x380 y90 vQuerEntrar gLabelReset hwndText5, Entrar.
    Gui, 2: Add, Radio, x380 y120 vQuerSair gLabelReset hwndText6, Sair.
    Gui, 2: Add, Radio, hidden x380 y150 vQuerManha gLabelUmDia hwndText10, Manha completa.
    Gui, 2: Add, Radio, hidden x380 y180 vQuerTarde gLabelUmDia hwndText11, Tarde completa.
    Gui, 2: Add, Radio, hidden x380 y210 vQuerUmDia gLabelUmDia hwndText7, Entrar um dia completo.
    Gui, 2: Add, Radio, hidden x380 y240 HwndManutencao vQuerMaisDia gLabelMaisDia hwndText8, Entrar varios dias.
    AddToolTip(Manutencao, "Cuidado com os finais de semama!")
    ;------------DATETIMES-----------------
    Gui, 2: Add, Text, x60 y310 vTextHora, Horario ;TEXTO DO HORARIO
    Gui, 2: Add, DateTime, x61 y330 w67 vBoxHora, Time ;ENTRAR HORA
    Gui, 2: Add, Text, x225 y307 vTextData1, Data: ;TEXTO DA DATA
    Gui, 2: Add, DateTime, x225 y330 vMyDateTime, LongDate ;ENTRAR DATA
    Gui, 2: Add, Text, x225 y384 vTextData2 Hidden, Ate: ;DECLARAR SEGUNDA DATA
    Gui, 2: Add, DateTime, x225 y404 vMyLaterTime Hidden, LongDate ;ENTRAR SEGUNDA DATA
    ;-------------IMAGENS-----------------
	;Gui, 2: Add, Picture, x530 y80 w150 h-1,\\servidor\desenv\USUARIOS\Caio\IMAGENS\cebra_transparente.png
    Gui, 2: Add, Picture, x55 y10 w80 h-1 vCebra_preto,\\servidor\desenv\USUARIOS\Caio\IMAGENS\cebra_transparente.png
    Gui, 2: Add, Picture, x55 y10 w80 h-1 vCebra_branco hidden,\\servidor\desenv\USUARIOS\Caio\IMAGENS\cebra_transparente_mais_branco.png  
    Gui, 2: Add, Picture, x260 y10 w200 h-1, \\servidor\desenv\USUARIOS\Caio\IMAGENS\Cool Text - AUTO-TIME 376502985796717.png
    Gui, 2: Add, Picture, x470 y26 w35 h-1, \\servidor\desenv\USUARIOS\Caio\IMAGENS\v133.png
    
    Gui, Add, Text, x0  y0   w35   h700    0x4
    Gui, Add, Text, x695 y0   w35   h700    0x4
    Gui, Add, Text, x35 y0   w10   h800    0x5
    Gui, Add, Text, x686 y0   w10   h800    0x5

    Gui, Add, Text, x0 y55   w800   h10    0x5
    Gui, Add, Text, x356 y55   w10   h235    0x5
    Gui, Add, Text, x0 y280   w800  h10    0x5

    Gui, Add, Text, x0 y460   w800  h10    0x5
    
    ;-------------BUTTONS-----------------
    Gui, 2: Add, Button, x60 y380 gRESETANDO vHoraBt, RESET`nData/Hora ;RESETAR HORA
	Gui, 2: Add, Button, x60 y490 vBt gCONFIRMAR Disabled, Confirmar ;CONFRIMAR ENTRADA
    Gui, 2: Add, Button, x600 y490 vTest gTESTANDO, Teste
    Gui, 2: Add, Button, x435 y490 gHelp, Help
    Gui, 2: Add, Button, x220 y108 HwndConsultsige vConsultarSige gCONSULTANDO_SIGE Disabled, Mao de Obra
    AddToolTip(Consultsige, "Clique aqui para modificar a ASSTEC selecionada")
    Gui, 2: Add, Button, x220 y228 HwndConsult vConsultar gCONSULTANDO Disabled, Ver Tempo
    AddToolTip(Consult, "Clique aqui para consultar sua entrada de tempo no sige")
    Gui, 2: Add, Button, x270 y490 gSIGE, Sige
    ;----------CHECK BOX------------------
    Gui, 2: Add, CheckBox, x570 y80 vNoturno gdarkMode hwndText9, Dark Mode
    ;---------MOSTRAR INTERFACE------------
    Gui, 2: Show, w730 h550, INTERFACE
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
    EntrarRetro(hora_inicial, MyDateTime, QuerManha, QuerTarde, QuerUmDia, QuerMaisDia, data1) ;ENTRA DE MANHÃ

    RotinaDeTempo(0, ASSTEC, ETAPA, PESSOA)
    EntrarRetro(120000, MyDateTime, QuerManha, QuerTarde, QuerUmDia, QuerMaisDia, data1) ;SAI DE MANHÃ

    RotinaDeTempo(1, ASSTEC, ETAPA, PESSOA)
    EntrarRetro(130000, MyDateTime, QuerManha, QuerTarde, QuerUmDia, QuerMaisDia, data1) ;ENTRA DE TARDE

    RotinaDeTempo(0, ASSTEC, ETAPA, PESSOA)
    EntrarRetro(hora_final, MyDateTime, QuerManha, QuerTarde, QuerUmDia, QuerMaisDia, data1) ;SAI DE TARDE
}
Return

OnlyMorning(ASSTEC, ETAPA, PESSOA, MyDateTime, QuerManha, QuerTarde, QuerUmDia, QuerMaisDia, data1)
{
    ;Msgbox, Funcionou!
    switch PESSOA ;Horário de trabalho adaptativo para cada membro do desnv.
    {
        case "c": 
            hora_inicial := 070000
        case "f": 
            hora_inicial := 070000
        case "j":
            hora_inicial := 070000
        case "a":
            hora_inicial := 073000 
        case "r":
            hora_inicial := 074500 
        case "v":
            hora_inicial := 080000 
    }
    ;Rotina de tempo: 1 para entrar e 0 para sair
    RotinaDeTempo(1, ASSTEC, ETAPA, PESSOA)
    EntrarRetro(hora_inicial, MyDateTime, QuerManha, QuerTarde, QuerUmDia, QuerMaisDia, data1) ;ENTRA DE MANHÃ

    RotinaDeTempo(0, ASSTEC, ETAPA, PESSOA)
    EntrarRetro(120000, MyDateTime, QuerManha, QuerTarde, QuerUmDia, QuerMaisDia, data1) ;SAI DE MANHÃ
}
Return

OnlyAfter(ASSTEC, ETAPA, PESSOA, MyDateTime, QuerManha, QuerTarde, QuerUmDia, QuerMaisDia, data1)
{
    ;Msgbox, Funcionou!
    switch PESSOA ;Horário de trabalho adaptativo para cada membro do desnv.
    {
        case "c": 
            hora_final :=164800
        case "f": 
            hora_final :=164800
        case "j":
            hora_final :=164800
        case "a":
            hora_final :=171800
        case "r":
            hora_final :=173300
        case "v":
            hora_final :=174800
    }
    RotinaDeTempo(1, ASSTEC, ETAPA, PESSOA)
    EntrarRetro(130000, MyDateTime, QuerManha, QuerTarde, QuerUmDia, QuerMaisDia, data1) ;ENTRA DE TARDE

    RotinaDeTempo(0, ASSTEC, ETAPA, PESSOA)
    EntrarRetro(hora_final, MyDateTime, QuerManha, QuerTarde, QuerUmDia, QuerMaisDia, data1) ;SAI DE TARDE
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
        ;======VALENDO EM 2021============
        case "P01":   SendInput, 38{Tab} ;DFEMEA
        case "P02":   SendInput, 38{Tab} ;PLACAS E ESQUEMÁTICOS
        case "P03":   SendInput, 39{Tab} ;CNC
        case "P04":   SendInput, 38{Tab} ;MECANICOS 3D
        case "P05":   SendInput, 38{Tab} ;CRIAÇÃO DE GRUPO, DOCUMENTOS DO MAGNETICO
        case "P06":   SendInput, 35{Tab} ;MONTAGEM DE PROTÓTIPO, TESTE E AJUSTES
        case "P07":   SendInput, 38{Tab} ;DESENVOLVIMENTO DE FIRMWARE
        case "P08":   SendInput, 41{Tab} ;COMPATIBILIDADE
        case "P09":   SendInput, 38{Tab} ;CONFECÇÃO DE ARTEFATOS  ****38 OU 35****
        case "P10":   SendInput, 35{Tab} ;OF E SUPORTE A PRODUÇÃO
        case "P11":   SendInput, 35{Tab} ;ENSAIOS DO PROTÓTIO NO LOTE PILOTO ****38 OU 35****
        case "P12":   SendInput, 35{Tab} ;TESTES E ENSAIOS DO PRODUTO FINAL ****38 OU 35****
        case "P13":   SendInput, 38{Tab} ;DOCUMENTOS PARA O CLIENTE 
        case "P14":   SendInput, 38{Tab} ;ALTERAÇÃO DO PROJETO PARA O CLIENTE ****38 OU 35****
        case "P15":   SendInput, 38{Tab} ;PESQUISA DE NOVOS ITENS E PROCESSOS
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

EntrarRetro(Hora, MyDateTime, QuerManha, QuerTarde, QuerUmDia, QuerMaisDia, data1)
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

    if (QuerUmDia || QuerMaisDia || QuerManha || QuerTarde)
    {
        SendInput, %Hora%{Enter}
    }
    else
    {   
        FormatTime, MyHour, %Hora%, HHmmss;Ou seja, se a pessoa estiver apenas entrando ou saindo
        SendInput, %MyHour%{Enter}
    }    

    Sleep, 100
    if WinExist("Warning")
        Return
    WinWaitActive, Information ;Delay para aparecer a Msgbox do SIGE
    MouseClick, left, 184, 104, ,0 ;Finalizando entrada
}
Return

INICIAR_SIGE(porta)
{
    Switch porta
    {
        case 0: ;INICIA A ENTRADA DE TEMPOS DO SIGE
            Send, #r ;Atalho para abrir o Executar do Windows
            WinWaitActive, Executar
            SendInput, \\servidor\sigewin\Arquivos de Programas\SIGEWin\TemposAsstec.exe{Enter}
            WinMinimizeAll
            WinActivate, Database Login
            WinWaitActive, Database Login
            Sleep, 100
            SendInput, sige{Enter} 
        case 1: ;INICIA O SIGE
            Send, #r ;Atalho para abrir o Executar do Windows
            WinWaitActive, Executar
            SendInput, \\servidor\sigewin\Arquivos de Programas\SIGEWin\sige.exe{Enter}
            WinMinimizeAll
            Loop{ ;Login do sige 
                Sleep, 100
                if (ok:=FindText(592-150000, 424-150000, 592+150000, 424+150000, 0, 0, "|<>*120$32.Q00E08U040200100UCKKCL4KKEE9x54w2EFFF8YIIIFkt54xU"))
                    Break
            }
            SendInput, r{Tab}
            SendInput, r3170{Enter}   
    }    
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
            Send, {Down}{Down}{Down}{Down}{Down}
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
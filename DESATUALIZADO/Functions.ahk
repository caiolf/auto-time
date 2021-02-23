;Rotina de tempo de um dia inteiro
CriarGui2()
{
	global
	Gui, 2: Font, s12 w700
	Gui, 2: Add, GroupBox, x40 y60 w650 h400, Nova Inclusao de Tempo
    ;---------ENTRADA DE DADOS-------------
	Gui, 2: Add, Text, x60 y90, ASSTEC
	Gui, 2: Add, Edit, x60 y110 w150 Number UPPERCASE vASSTEC
	Gui, 2: Add, Text, x60 y150, Etapa
	Gui, 2: Add, Edit, x60 y170 w150  HwndButtonHwnd UPPERCASE vETAPA
	AddToolTip(ButtonHwnd, "P01 - Especificacao`nP02 - Esquematico`nP03 - Layout da PCI`nP04 - Desenho mecanico`nP05 - Doc. e conf. da PCI`nP06 - Montagem do prototipo`nP08 - Teste eletrico e mecanico`nP09 - Artefatos e doc. prod.`nP10 - Montagem do lote piloto`nP11 - Teste do lote piloto`nP12 - Teste do produto final`nP13 - Doc. e instalacao de uso`nP14 - Verif. de instalacao/uso`nP15 - Estudo de novos prod./processos")	
    Gui, 2: Add, Text, x60 y210, Pessoa
    Gui, 2: Add, Edit, x60 y230 w56 HwndButton2Hwnd UPPERCASE vPESSOA gLabelPessoa
    AddToolTip(Button2Hwnd, "F - Rafa`nR - Robson`nA - Japa`nC - Caio`nV - Victor`nJ - Junior")
    ;-------------RADIOS------------------
    Gui, 2: Add, Radio, x60 y280 vQuerEntrar gLabelReset, Entrar.
    Gui, 2: Add, Radio, x160 y280 vQuerSair gLabelReset, Sair.
    Gui, 2: Add, Radio, x260 y280 vQuerUmDia gLabelUmDia, Entrar um dia completo.
    Gui, 2: Add, Radio, x500 y280 HwndManutencao vQuerMaisDia gLabelMaisDia, Entrar varios dias.
    AddToolTip(Manutencao, "Em manutencao")
    ;------------DATETIMES-----------------
    Gui, 2: Add, Text, x60 y310 vTextHora, Horario ;TEXTO DO HORARIO
    Gui, 2: Add, DateTime, x61 y330 w70 vBoxHora, Time ;ENTRAR HORA
    Gui, 2: Add, Text, x260 y310 vTextData1, Data ;TEXTO DA DATA
    Gui, 2: Add, DateTime, x260 y330 vMyDateTime, LongDate ;ENTRAR DATA
    Gui, 2: Add, Text, x260 y370 vTextData2 Hidden, Ate: ;DECLARAR SEGUNDA DATA
    Gui, 2: Add, DateTime, x260 y390 vMyLaterTime Hidden, LongDate ;ENTRAR SEGUNDA DATA
    ;-------------IMAGENS-----------------
	Gui, 2: Add, Picture, x300 y100 w300 h-1,\\servidor\desenv\USUARIOS\Caio\IMAGENS\cebra_transparente.png
    ;-------------BUTTONS-----------------
    Gui, 2: Add, Button, x60 y360 gRESETANDO vHoraBt, RESET ;RESETAR HORA
	Gui, 2: Add, Button, x60 y480 vBt gINICIANDO Disabled, CONFIRMAR ;CONFRIMAR ENTRADA
    Gui, 2: Add, Button, x600 y480 vTest gTESTANDO, TESTE
    Gui, 2: Add, Button, x116 y228 HwndConsult vConsultar gCONSULTANDO Disabled, Consultar  
    AddToolTip(Consult, "Clique aqui para consultar sua entrada de tempo no sige")
    ;---------MOSTRAR INTERFACE------------
	Gui, 2: Show, w740 h550, INTERFACE
    AddToolTip("AutoPopDelay", 20)
} 
Return

;-----------------CONTROLE-DE-GUI------------------------
LabelUmDia:
GuiControl,, TextData1, Data:
GuiControl, Hide, TextData2
GuiControl, Hide, MyLaterTime
GuiControl, Enable, Bt ;HABILITA O USO DO BOTTOM
GuiControl, Disable, BoxHora
GuiControl, Disable, TextHora
GuiControl, Disable, HoraBt
Return
LabelMaisDia: ;FAZ APARECER A 2 DATA ESCONDIDA
GuiControl,, TextData1, De:
GuiControl, Show, TextData2
GuiControl, Show, MyLaterTime
GuiControl, Enable, Bt ;HABILITA O USO DO BOTTOM
GuiControl, Disable, BoxHora
GuiControl, Disable, TextHora
GuiControl, Disable, HoraBt
Return
LabelReset: ;ESCONDE A 2 DATA NOVAMENTE
GuiControl,, TextData1, Data:
GuiControl, Hide, TextData2
GuiControl, Hide, MyLaterTime
GuiControl, Enable, Bt ;HABILITA O USO DO BOTTOM
GuiControl, Enable, BoxHora
GuiControl, Enable, TextHora
GuiControl, Enable, HoraBt
Return
RESETANDO:
GuiControl,, BoxHora, %A_Now%
Return  
LabelPessoa:    
if !(PESSOA := "")
    GuiControl, Enable, Consultar   
Return

OneDay(ASSTEC, ETAPA, PESSOA, MyDateTime)
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
    EntrarRetro(hora_inicial, MyDateTime, QuerUmDia) ;ENTRA DE MANHÃ

    RotinaDeTempo(0, ASSTEC, ETAPA, PESSOA)
    EntrarRetro(120000, MyDateTime, QuerUmDia) ;SAI DE MANHÃ

    RotinaDeTempo(1, ASSTEC, ETAPA, PESSOA)
    EntrarRetro(130000, MyDateTime, QuerUmDia) ;ENTRA DE TARDE

    RotinaDeTempo(0, ASSTEC, ETAPA, PESSOA)
    EntrarRetro(hora_final, MyDateTime, QuerUmDia) ;SAI DE TARDE
}
Return

RotinaDeTempo(Estado, ASSTEC, ETAPA, PESSOA)
{
    OnlyTimeWindow() ;Faz aparecer somente a janela de entrada de tempo
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
    Send, #r
    WinWaitActive, Executar
    SendInput, \\servidor\sigewin\Arquivos de Programas\SIGEWin\TemposAsstec.exe{Enter}
    WinMinimizeAll
	WinActivate, Database Login
    WinWaitActive, Database Login
	Send, sige{Enter}
}
Return

ConsultarEspecifico(PESSOA)   
{       
    switch PESSOA ;Operador
    {
        case "c":   
        {   
            MsgBox, asdasdasdaads 
            /*   
            MouseClick, left, 670, 510 ;Seleciona caixa de texto onde fica os nomesra    
            Sleep, 1000
            Send, c 
            Sleep, 1000
            MouseClick, left, 670, 580  
            Sleep, 1000
            */
        }
        case "a":   Send, 00561297
        case "f":   Send, 00560078
        case "r":   Send, 00561723
        case "v":   Send, 00561419
        case "j":   Send, 00560924
    }   
    MouseClick, left, 670, 540
}
Return


OnlyTimeWindow()    
{       
    WinMinimizeAll ;Minimizar todas as janelas
    WinActivate, SIGEWin - Entrada de Tempos - Asstec/OS ;Somente a janela de entrada de tempos ativa
    WinWaitActive, SIGEWin - Entrada de Tempos - Asstec/OS  
    MouseClick, left, 150, 70
}   
Return
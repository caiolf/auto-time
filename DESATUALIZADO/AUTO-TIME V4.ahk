; AUTO-TIME
; AUTOR: CAIO
; DATA DE ESCRITA: 11/2020
; O PROGRAMA INICIA AQUI

Gui, Font, s16 w700
Gui, Add, Text, x20 y20 w560 Center, ENTRADA DE TEMPO
Gui, Add, Picture, x150 y90 w300 h-1 Center, \\servidor\desenv\USUARIOS\Caio\IMAGENS\cebra_transparente.png
Gui, Font
Gui, Font, s12 w700
Gui, Add, Text, x20 y280 w560 Center, Insira a senha abaixo para continuar
Gui, Add, Text, 
Gui, add, Edit, Password x200 y310 w200 Limit12 vSENHA_INSERIDA
Gui, add, Button, x250 y350 w100 gAbrir_Agenda, Entrar ; AQUI TEM UMA G-LABEL! ISSO SIGNIFICA QUE QUANDO ESSE BOTAO DA PRIMEIRA TELA É PRESSIONADO, A LABEL ABRIR_AGENDA É EXECUTADA!
Gui, show, w600 h400, AUTO-TIME
Return

Abrir_Agenda:
Gui, Submit, hide
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
	Gui, 2: Add, GroupBox, x40 y60 w650 h400, NOVA INCLUSAO
	Gui, 2: Add, Text, x60 y90, ASSTEC
	Gui, 2: Add, Edit, x60 y110 w150 Number UPPERCASE vASSTEC

	Gui, 2: Add, Text, x60 y150, Etapa
	Gui, 2: Add, Edit, x60 y170 w150  HwndButtonHwnd UPPERCASE vETAPA
	AddToolTip(ButtonHwnd, "P01 - Especificacao`nP02 - Esquematico`nP03 - Layout da PCI`nP04 - Desenho mecanico`nP05 - Doc. e conf. da PCI`nP06 - Montagem do prototipo`nP08 - Teste eletrico e mecanico`nP09 - Artefatos e doc. prod.`nP10 - Montagem do lote piloto`nP11 - Teste do lote piloto`nP12 - Teste do produto final`nP13 - Doc. e instalacao de uso`nP14 - Verif. de instalacao/uso`nP15 - Estudo de novos prod./processos")

	Gui, 2: Add, Text, x60 y210, Pessoa
    Gui, 2: Add, Edit, x60 y230 w150 HwndButton2Hwnd UPPERCASE vPESSOA
    AddToolTip(Button2Hwnd, "F - Rafa`nR - Robson`nA - Japa`nC - Caio`nV - Victor`nJ - Junior")

    Gui, 2: Add, Radio, x60 y280 vQuerEntrar, Entrar.
    Gui, 2: Add, Radio, x160 y280 vQuerSair, Sair.
    Gui, 2: Add, Radio, x260 y280 vQuerUmDia, Entrar um dia completo.
    Gui, 2: Add, Radio, x500 y280 vQuerMaisDia, Entrar varios dias.

    Gui, 2: Add, Text, x60 y310, Horario 
    Gui, 2: Add, DateTime, x60 y330 w70 vHORARIO_ENTRADA, time
    Gui, 2: Add, Text, x260 y310, Data
    Gui, 2: Add, DateTime, x260 y330 vMyDateTime, LongDate

	Gui, 2: Add, Picture, x300 y100 w300 h-1,\\servidor\desenv\USUARIOS\Caio\IMAGENS\cebra_transparente.png

	Gui, 2: Add, Button, x60 y420 gINICIAR_ENTRADA, CONFIRMAR

	Gui, 2: Show, w740 h550, AUTO-TIME
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

if !WinExist("SIGEWin - Entrada de Tempos - Asstec/OS")
    INICIAR_SIGE()

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

;Rotina de tempo de um dia inteiro
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
    WinMinimizeAll ;Minimizar todas as janelas
    WinActivate, SIGEWin - Entrada de Tempos - Asstec/OS ;Somente a janela de entrada de tempos ativa
    WinWaitActive, SIGEWin - Entrada de Tempos - Asstec/OS
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
    ;Run, \\servidor\sigewin\Arquivos de Programas\SIGEWin\TemposAsstec.exe
    WinMinimizeAll
	WinActivate, Database Login
    WinWaitActive, Database Login
	Send, sige{Enter}
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

AddToolTip(_CtrlHwnd, _TipText, _Modify = 0)
{
	
	Static TTHwnds, GuiHwnds, Ptr
	, LastGuiHwnd
	, LastTTHwnd
	, TTM_DELTOOLA := 1029
	, TTM_DELTOOLW := 1075
	, TTM_ADDTOOLA := 1028
	, TTM_ADDTOOLW := 1074
	, TTM_UPDATETIPTEXTA := 1036
	, TTM_UPDATETIPTEXTW := 1081
	, TTM_SETMAXTIPWIDTH := 1048
	, WS_POPUP := 0x80000000
	, BS_AUTOCHECKBOX = 0x3
	, CW_USEDEFAULT := 0x80000000
	
	Ptr := A_PtrSize ? "Ptr" : "UInt"

	If (_TipText = "Destroy" Or _TipText = "Remove All" And _Modify = -1)
	{
		; Check if the GuiHwnd exists in the cache list of GuiHwnds
		; If it doesn't exist, no tool tips can exist for the GUI.
		;
		; If it does exist, find the cached TTHwnd for removal.
		Loop, Parse, GuiHwnds, |
			If (A_LoopField = _CtrlHwnd)
			{
				TTHwnd := A_Index
				, TTExists := True
				Loop, Parse, TTHwnds, |
					If (A_Index = TTHwnd)
						TTHwnd := A_LoopField
			}
		
		If (TTExists)
		{
			If (_TipText = "Remove All")
			{
				WinGet, ChildHwnds, ControlListHwnd, ahk_id %_CtrlHwnd%
			
				Loop, Parse, ChildHwnds, `n
					AddToolTip(A_LoopField, "", _Modify) ;Deletes the individual tooltip for a given control if it has one
				
				DllCall("DestroyWindow", Ptr, TTHwnd)
			}
			
			GuiHwnd := _CtrlHwnd
			; This sub removes 'GuiHwnd' and 'TTHwnd' from the cached list of Hwnds
			GoSub, RemoveCachedHwnd
		}
		
		Return
	}
	
	If (!GuiHwnd := DllCall("GetParent", Ptr, _CtrlHwnd, Ptr))
		Return "Invalid control Hwnd: """ _CtrlHwnd """. No parent GUI Hwnd found for control."
	
	; If this GUI is the same one as the potential previous one
	; else look through the list of previous GUIs this function
	; has operated on and find the existing TTHwnd if one exists.
	If (GuiHwnd = LastGuiHwnd)
		TTHwnd := LastTTHwnd
	Else
	{
		Loop, Parse, GuiHwnds, |
			If (A_LoopField = GuiHwnd)
			{
				TTHwnd := A_Index
				Loop, Parse, TTHwnds, |
					If (A_Index = TTHwnd)
						TTHwnd := A_LoopField
			}
	}
	
	; If the TTHwnd isn't owned by the controls parent it's not the correct window handle
	If (TTHwnd And GuiHwnd != DllCall("GetParent", Ptr, TTHwnd, Ptr))
	{
		;GoSub, RemoveCachedHwnd
		TTHwnd := ""
	}
	
	; Create a new tooltip window for the control's GUI - only one needs to exist per GUI.
	; The TTHwnd's are cached for re-use in any subsequent calls to this function.
	If (!TTHwnd)
	{
		TTHwnd := DllCall("CreateWindowEx"
						, "UInt", 0                             ;dwExStyle
						, "Str", "TOOLTIPS_CLASS32"             ;lpClassName
						, "UInt", 0                             ;lpWindowName
						, "UInt", WS_POPUP | BS_AUTOCHECKBOX    ;dwStyle
						, "UInt", CW_USEDEFAULT                 ;x
						, "UInt", 0                             ;y
						, "UInt", 0                             ;nWidth
						, "UInt", 0                             ;nHeight
						, "UInt", GuiHwnd                       ;hWndParent
						, "UInt", 0                             ;hMenu
						, "UInt", 0                             ;hInstance
						, "UInt", 0)                            ;lpParam
		
		; TTM_SETWINDOWTHEME
		DllCall("uxtheme\SetWindowTheme"
					, Ptr, TTHwnd
					, Ptr, 0
					, Ptr, 0)
		
		; Record the TTHwnd and GuiHwnd for re-use in any subsequent calls.
		TTHwnds .= (TTHwnds ? "|" : "") TTHwnd
		, GuiHwnds .= (GuiHwnds ? "|" : "") GuiHwnd
	}
	
	; Record the last-used GUIHwnd and TTHwnd for re-use in any immediate future calls.
	LastGuiHwnd := GuiHwnd
	, LastTTHwnd := TTHwnd
	
	, TInfoSize := 4 + 4 + ((A_PtrSize ? A_PtrSize : 4) * 2) + (4 * 4) + ((A_PtrSize ? A_PtrSize : 4) * 4)
	, Offset := 0
	, Varsetcapacity(TInfo, TInfoSize, 0)
	, Numput(TInfoSize, TInfo, Offset, "UInt"), Offset += 4                         ; cbSize
	, Numput(1 | 16, TInfo, Offset, "UInt"), Offset += 4                            ; uFlags
	, Numput(GuiHwnd, TInfo, Offset, Ptr), Offset += A_PtrSize ? A_PtrSize : 4      ; hwnd
	, Numput(_CtrlHwnd, TInfo, Offset, Ptr), Offset += A_PtrSize ? A_PtrSize : 4    ; UINT_PTR
	, Offset += 16                                                                  ; RECT (not a pointer but the entire RECT)
	, Offset += A_PtrSize ? A_PtrSize : 4                                           ; hinst
	, Numput(&_TipText, TInfo, Offset, Ptr)                                         ; lpszText
	
	
	; The _Modify flag can be used to skip unnecessary removal and creation if
	; the caller follows usage properly but it won't hurt if used incorrectly.
	If (!_Modify Or _Modify = -1)
	{
		If (_Modify = -1)
		{
			; Removes a tool tip if it exists - silently fails if anything goes wrong.
			DllCall("SendMessage"
					, Ptr, TTHwnd
					, "UInt", A_IsUnicode ? TTM_DELTOOLW : TTM_DELTOOLA
					, Ptr, 0
					, Ptr, &TInfo)
			
			Return
		}
		
		; Adds a tool tip and assigns it to a control.
		DllCall("SendMessage"
				, Ptr, TTHwnd
				, "UInt", A_IsUnicode ? TTM_ADDTOOLW : TTM_ADDTOOLA
				, Ptr, 0
				, Ptr, &TInfo)
		
		; Sets the preferred wrap-around width for the tool tip.
		 DllCall("SendMessage"
				, Ptr, TTHwnd
				, "UInt", TTM_SETMAXTIPWIDTH
				, Ptr, 0
				, Ptr, A_ScreenWidth)
	}
	
	; Sets the text of a tool tip - silently fails if anything goes wrong.
	DllCall("SendMessage"
		, Ptr, TTHwnd
		, "UInt", A_IsUnicode ? TTM_UPDATETIPTEXTW : TTM_UPDATETIPTEXTA
		, Ptr, 0
		, Ptr, &TInfo)
	
	Return
	
	
	RemoveCachedHwnd:
		Loop, Parse, GuiHwnds, |
			NewGuiHwnds .= (A_LoopField = GuiHwnd ? "" : ((NewGuiHwnds = "" ? "" : "|") A_LoopField))
		
		Loop, Parse, TTHwnds, |
			NewTTHwnds .= (A_LoopField = TTHwnd ? "" : ((NewTTHwnds = "" ? "" : "|") A_LoopField))
		
		GuiHwnds := NewGuiHwnds
		, TTHwnds := NewTTHwnds
		, LastGuiHwnd := ""
		, LastTTHwnd := ""
	Return
}
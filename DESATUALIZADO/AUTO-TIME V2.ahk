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
If !(SENHA_INSERIDA = "A") ; ESTA CONDICIONAL CHECA SE O USUÁRIO NÃO ESCREVEU ABACAXI NO CAMPO DE SENHA DA PRIMEIRA TELA. SE ELE NÃO ESCREVEU, EXIBE UM ERRO E RETORNA A EXECUÇÃO SEM PROSSEGUIR.
{
	msgbox, 0x10, Erro, A senha digitada esta incorreta! Tente novamente ou procure o suporte!
	Return
}
; SE A EXECUÇÃO CHEGAR AQUI, ISSO SIGNFICA QUE O USUÁRIO ESCREVEU A SENHA ABACAXI (POIS SE NÃO TIVESSE ESCRITO, A LINHA DE RETORNO TERIA SIDO EXECUTADA).
; ENTENDEMOS PORTANTO QUE O USUÁRIO ESCREVEU A SENHA CERTA E ASSIM CONTINUAMOS OS COMANDOS PARA ABRIR A AGENDA.
IniRead, MAXIMA_ENTRADA, %A_SCriptDir%/BD.bdgt, MAXIMA_ENTRADA, CODIGO
If (MAXIMA_ENTRADA = "ERROR") ; ESTA CONDICIONAL CHECA SE O ARQUIVO INI NÃO POSSUI UMA SEÇÃO COM A MÁXIMA ENTRADA. USAMOS ESSA INFORMAÇÃO PARA CONTROLE DOS CODIGOS DAS TAREFAS.
{
	; SE A EXECUÇÃO ENTRAR AQUI, O ARQUIVO INI NÃO POSSUI UMA SEÇÃO COM A MÁXIMA ENTRADA (MÁXIMO CÓDIGO DE TAREFA). ENTENDEMOS QUE SE ISSO ACONTECEU, ESTA PODE SER A PRIMEIRA VEZ QUE 
	; O PROGRAMA É EXECUTADO OU ENTÃO O ARQUIVO INI FOI CORROMPIDO.
	CAMINHO_DO_ARQUIVO_DB := A_SCriptDir . "/BD.bdgt"
	If !(FileExist(CAMINHO_DO_ARQUIVO_DB)) ; AQUI VERIFICAMOS SE EXISTE UM ARQUIVO INI NO CAMINHO QUE DEVERIA ESTAR (NA PASTA DO PROGRAMA).
	{
		Msgbox, 0x14, Erro, O sistema não detectou a presença de um arquivo de banco de dados na pasta principal. Deseja criar um novo arquivo de banco de dados em branco?
		IfMsgBox, no ; ESTA CONDICIONAL VERIFICA SE O USUARIO ESCOLHEU "NÃO" NA CAIXA DE TEXTO. SE ESCOLHEU, TERMINAMOS A EXECUÇÃO DO PROGRAMA, POIS ESTE NÃO PODE TRABALHAR SEM O ARQUIVO INI.
		{
			msgbox, 0x10, Erro, O sistema não pôde se comunicar com o banco de dados. Reinicie ou contacte o suporte.
			ExitApp
		}
		; SE A EXECUÇÃO CHEGAR AQUI, O USUÁRIO ESCOLHEU "SIM" NA CAIXA DE TEXTO (SABEMOS DISSO POR ELIMINAÇÃO, VEZ QUE O CÓDIGO DO "NÃO" NÃO FOI EXECUTADO).
		IniWrite, 0, %A_SCriptDir%/BD.bdgt, MAXIMA_ENTRADA, CODIGO ; ESCREVEMOS UM NOVO ARQUIVO INI COM A MAXIMA ENTRADA 0 (ZERO) PARA INICIO DE CONTROLE DE CODIGOS DE TAREFAS.
		Goto, Abrir_Agenda
		Return
	}
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
	;Gui, 2: Add, Tab2, x20 y20 w760 h560, 
	Gui, 2: Add, GroupBox, x40 y60 w720 h400, NOVA INCLUSAO
	Gui, 2: Add, Text, x60 y90, ASSTEC
	Gui, 2: Add, Edit, x60 y110 w600 UPPERCASE vASSTEC
	Gui, 2: Add, Text, x60 y150, Etapa
	Gui, 2: Add, Edit, x60 y170 w600 UPPERCASE vETAPA
	;Gui, 2: Add, Text, x60 y210, Lugares
	;Gui, 2: Add, Edit, x60 y230 w600 UPPERCASE vLUGARES
	Gui, 2: Add, Text, x60 y270, Ser Humaninho
	Gui, 2: Add, Edit, x60 y290 w600 UPPERCASE vPESSOA
	Gui, 2: Add, Button, x60 y420 gINICIAR_ENTRADA, CONFIRMAR
	Gui, 2: Show, w800 h600, Tarefas Atuais
	Gui, 2: Add, DateTime, x300 y380 vMyDateTime, LongDate
}
switch ETAPA
{
	case "P01": Send, {Tab}38 
}
Return
; ESTA LABEL É CHAMADA QUANDO O USUÁRIO CLICA NO BOTÃO "CONFIRMAR"
; ELA BASICAMENTE ESCREVE UMA NOVA SEÇÃO NO ARQUIVO INI, CUJO NÚMERO É O NÚMERO MÁXIMO ANTERIOR ADICIONADO DE 1 E AS INFORMAÇÕES SÃO AS QUE O USUÁRIO ESCREVEU NO FORMULÁRIO E AS QUE SÃO
;  COLETADAS AUTOMATICAMENTE (DATA DE INCLUSAO, POR EXEMPLO).
INICIAR_ENTRADA:
Msgbox, 0x04, Aviso, Confirma a inclusao do tempo?
IfMsgbox, No
{
	Msgbox, 0x10, Aviso, Inclusao da tarefa cancelada pelo usuario.
	Return
}
Gui, 2: Submit, nohide
Gui, 2: Default

WinMinimizeAll
WinActivate, SIGEWin - Entrada de Tempos - Asstec/OS
CoordMode, Mouse, Relative

MouseClick, left, 150,95 ;Asstec
Send, %ASSTEC%{Tab}
Send, %ETAPA%{Tab} ;Etapa
Send, %ETAPA%{Tab} ;Atividade
;Send, %LUGARES%{Tab} ;Máquina
switch ETAPA
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
	case "caio":   Send, 00562607
	case "japa":   Send, 00561297
	case "rafa":   Send, 00560078
	case "robson":   Send, 00561723
	case "victor":   Send, 00561419
	case "junior":   Send, 00560924
}
;MouseClick, left, 530,560 ;Início
Send, {F2}
Send, {Tab}
Send, {Enter}
WinActivate, Information
Sleep, 100
MouseClick, left, 184, 104 ;Asstec
;ENTRADA RETROATIVA
/*Send, ^h ;Acessar o ctrol H
MouseClick, left, 660,360
MouseClick, left, 660,417
Send, R
MouseClick, left, 660,385 
Send, r3170 ;Senha
MouseClick, left, 650,456 
Send, %MyDateTime%
*/
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
IfWinNotExist, Tarefas Atuais
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

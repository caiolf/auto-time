MODIFIED=20150111
;- menux with submenux
;- https://www.autohotkey.com/docs/commands/Menu.htm

Menu, FFFF, Add, &Notepad , 1F
Menu, FFFF, Add, &Calc    , 2F
Menu, AAAA, Add, &OPEN_2, :FFFF
Menu, AAAA, Add, &Charmap , 2A
Menu, AAAA, Add, &AHK_Version , 3A
Menu, BBBB, Add, &OPEN_1, :AAAA
Menu, BBBB, Add, &Print, FilePrint
Menu, BBBB, Add  ;- Separator line.
Menu, BBBB, Add, &Exit, FileExit
Menu, DDDD, Add, &About Test, Help
Menu, MyMenuBar, Add, &File, :BBBB
Menu, MyMenuBar, Add, &Help, :DDDD

Gui, 2: Menu, MyMenuBar
Gui, 2: show,x500 y250 h150 w200, ENTRADA DE TEMPO

Gui, 2: Add, Text, x10 y10, ASSTEC:
Gui, 2: add, edit, x70 y8 vASSTEC_INSERIDA

Gui, 2: Add, Text, x10 y35, ETAPA:
Gui, 2: add, edit, x70 y32 vETAPA_INSERIDA

Gui, 2: Add, Button, Default w80 gbuttom, Go! ; AQUI O BOTÃO CONFIRMAR FICA ATRELADO À ROTINA VERIFICA_SENHA (OPÇÃO g).
return

buttom:
{
    ;Run, \\servidor\sigewin\Arquivos de Programas\SIGEWin\TemposAsstec.exe
    ;WinWaitActive, Untitled - Database Login
    MouseClick, left,687, 448
    
    Sleep, 2000
    MouseClick, left, 687, 448
}



return
;-----------------------------------------
Help:
msgbox,This is an example
run,https://www.autohotkey.com/docs/commands/Menu.htm
return

1F:
Run,notepad
return

2F:
Run,calc
return

2A:
run,charmap
return

3A:
msgbox,AHKVERSION=%a_ahkversion%
return

Fileprint:
msgbox,Fileprint
return

2Guiclose:
Fileexit:
exitapp

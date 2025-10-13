#include "Rwmake.ch"
#include "Protheus.ch"

User Function IVisual()
	Private oDlg //Guarda um objeto
	Local cTitulo := "Aula MSDIALOG"
	Local cTexto := "CNPJ"
	Local cCGC := Space(13)
	Local nOpca := 0

	//Caixa de dialogo
	DEFINE MSDialog oDlg TITLE cTitulo from 000,000 To 080,300 Pixel
	@ 001,001 To 040, 150 oDlg Pixel
	@ 010,010 SAY/*exibe textp*/ cTexto SIZE 55, 07 OF oDlg PIXEL
	@ 010,010 MSGet /*pode inserir dados*/cCGC SIZE 55, 11 OF oDlg PIXEL
	PICTURE "@R 99.999.999/9999-99" Valid aCGC(cCGC)
	//PICTURE "@R 99.999.999/9999-99" Valid! Vazio() //formato que vai ser digitado
	DEFINE SBUTTON FROM 010, 120 TYPE 1 ACTION (nOpca := 1, oDlg:End()); //confirmar
	Enable Of oDlg
	DEFINE SBUTTON FROM 020, 120 TYPE 2 ACTION (nOpca := 2, oDlg:End()); //sair
	Enable Of oDlg
	ACTIVATE MSDialog oDlg CENTERED //centraliza

	if nOpca == 2
		Return
	Endif

	msgAlert("O CNPJ digitado foi :"+cCGC)




Return

Static Function aCGC(cCGC)
	if aCGC != "1111111111111"
		msgAlert("Erro CGC", "Atanção")
        oDlg:Refresh()
	Endif
Return

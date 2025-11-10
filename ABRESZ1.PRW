#include "protheus.ch"
#include "vkey.ch"
#include "Rwmake.ch"
#INCLUDE "JPEG.ch"
#include "msmgadd.ch"
//------------------------------------------------------------------------------------------
/*/{Protheus.doc} ABRESZ1
Manutenção de dados em SB1-Descricao Generica do Produto.

@author    paulo.bindo
@version   11.3.10.201812061821
@since     21/06/2019
/*/

User Function ABRESZ1()

	Private cCadastro := "Cadastro UM Cliente"

	Private aRotina := { {"Pesquisar","AxPesqui",0,1} ,;
		{"Visualizar","AxVisual",0,2} ,;
		{"Alterar","AxAltera",0,4} ,;
		{"Incluir","AxInclui",0,3} ,;
		{"Excluir","AxDeleta",0,5}}

	Private cDelFunc := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock

	Private cString := "SZ1"
	Private cCondicao	:= ""
	Private aIndSB1		:= {}
	Private cCampo
	Private aCampos := {}
	Private nNumero := 0

	Private lVerdadeiro := .F.

	Private dData := Ctod("")

	
	dbSelectArea("SZ1")
	dbSetOrder(1)






	//ASort(aCampos,,,{|x,y|x[1]<y[1]})


	dbSelectArea(cString) //ABRE A TABELA SZ1
	mBrowse( 6,1,22,75,cString,aCampos,cCampo)

	If !Empty(cCampo) .And. !Empty(cString);//ENTER
		.And. Len(aCampos) > 0

	EndIf

Return


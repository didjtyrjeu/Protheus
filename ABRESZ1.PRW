// #########################################################################################
// Projeto:
// Modulo :
// Fonte  : ABRESZ1.prw
// -----------+-------------------+---------------------------------------------------------
// Data       | Autor             | Descricao
// -----------+-------------------+---------------------------------------------------------
// 21/06/2019 | paulo.bindo       | Gerado com auxílio do Assistente de Código do TDS.
// -----------+-------------------+---------------------------------------------------------

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

Static nNum := 10

User Function ABRESZ1()

	//Escopo static e Private
	Public _nNumPub := 12
	Private cCadastro := "Cadastro UM Cliente"

	Private aRotina := { {"Pesquisar","AxPesqui",0,1} ,;
		{"Visualizar","AxVisual",0,2} ,;
		{"Alterar","AxAltera",0,4} ,;
		{"Incluir","AxInclui",0,3} ,;
		{"Excluir","AxDeleta",0,5}}

	aRotina[1,3]

	Private cDelFunc := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock
	Static nNum := 5
	Private cString := "SZ1"
	Private cCondicao	:= ""
	Private aIndSB1		:= {}
	Private cCampo
	Private aCampos := {}

	Private dData := Ctod("25/08/2025")
	alert(dtoc(dData))

	//Converção de valores
	cData := DtoC(dData)
	sData := DtoS(dData)
	dData2 := StoD(sData)
	cNumero := cValtoChar(nNumero)
	cNum2 := Str(nNumero, 5, 2)
	cNumeroStz := StrZero(nNumero,10)
	nNum2 := Val(cNum2)

	//Manipilação de string
	cNumeroStz := Str(nNum) //Ou cNumeroStz := AllTrin(Str(nNum, 10))
	cNum2 := AllTrin(cNum2)

	cAsc := Asc("A") //	retrona código do A
	cCht := Chr(cAsc) // retorna A

	cTexto := At("o","Rodrigo") //primeira letra
	cTexto := RAt("o","Rodrigo") // última

	nNumChar := Len(cTexto)
	cTexto2 := Lower(cTexto)
	cTexto2 := Upper(cTexto)
	cTexto2 := Capital(cTexto)
	cnNomeCli := "RODRIGO"

	if "Rodrigo" $ Capital(cnNomeCli)
	endif

	Stuff("PPQQQPP",3,2"SSS")// subustitui valores
	nNomeCli := Substr("Rodrigo Lombezzi", 1, 7)

	cnNomeCli := PadR("RODRIGO", 10, "*") //adiciona digitos na direita
	cNomeCli := PadC("RODRIGO", 9, "*") // dois lados
	cNomeCli := PadL("RODRIGO", 10, "*") // na esquerda

	cNomeCli := Replicate("*" 100)
	cNomeCli := SrtTran("Rodrigo", "o", "0")

	//Manipilação de variáveis numéricas
	ntotal  := ABS(100 - 1000) //retorna sempre positivo
	nNumero := Int(10.429) //retorna a parte inteira
	nNumero := Noround(10.429, 2) //retorna a quantidade casas desejadas
	nNumero := Round(10.429, 2) //arredoda o valor

	//Verificação e variável
	if ValType(nNumero) == "N"
	endif

	if Type("dDia") # "D"
		dDia := Date()
	endif

	if dDia == dDia2
	endif
	

	//Operador de atribuição
	nResul += 1
	nResul -= 1
	nResul *= 2
	nResul /= 2

	//Operadores matemáticos
	nResul := 1 + 1
	nResul := 1 - 3
	nResul := 2 * 11
	nResul := 2 / 3
	nResul := 2 ** 3
	nResul := 2 % 3

	//Operadores relacionais
	if nResul < 0
		alert("Maior 0")
	elseif nResul > 0
		alert("Menor 0")
	elseif nResul == 0
		alert("Igual 0")
	elseif nResul >= 0
		alert("Maior ou igual 0")
	elseif nResul <= 0
		alert("Menor ou igual 0")
	elseif nResul > 0
		alert("Menor 0")
	else nResul != 0
		alert("Diferente de 0")
	endif

	//Operadores lógicos e relacional
	if nResul > 0 .AND. "Teste" $ cBranco
		alert("Teste e ok")
	elseif nResul > 0 .OR. "Teste" $ cBranco
		alert("Teste ou ok")
	elseif nResul > 0 .OR. !("Teste" $ cBranco)
		alert("Teste ou ok")
	elseif !(nResul > 0 .AND. "Teste" $ cBranco)
		alert("Não aconteceu")
	endif

	//Operador string
	cBranco := "Teste" +Space(10)
	cBranco2 := cBranco - " Teste2"
	if "Teste" $ cBranco
		alert("found")
	else
		alert("not found")
	endif
	dbSelectArea("SZ1")
	dbSetOrder(1)


	//Atribuição em linha e em composta
	nCount2 := 10
	nCount := 0
	while nCount > 10

		nNumero +: 2
		nCalc +: 1
		nAcer +: 3
		nCount++
		nCount2--
	end

	Private nNumero := nCalc := nAcer :=0

	//Composta
	nResul += nCalc

	//Função
	Filha()

	u_filha(@nNumero) //valor com referência

	//Apelido
	SZ1 -> Z1_Campo



	//ASort(aCampos,,,{|x,y|x[1]<y[1]})
	dbSelectArea(cString)
	mBrowse( 6,1,22,75,cString,aCampos,cCampo)

	//Variável local e privada
	Private lLogica := .F.
	Private cCampo := "Teste"

	aIndSB1 := {0,0,0,"a"}

	alert("num de notas"+cValtoChar(nNumero))

	Local cCusto := "local"

Return

Static Function Filha()
	alert()
Return

User Function Aula()
	Private cTest := "aulaP"
	ABRESZ1()
Return


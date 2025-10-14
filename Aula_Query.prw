#INCLUDE 'Protheus.ch'
#INCLUDE 'TOPConn.ch'
#include "TbiConn.ch"
#include "TbiCode.ch"

#DEFINE ENTER Chr(13)+Chr(10)
//------------------------------------------------------------------------------------------
/*/{Protheus.doc} interface visual
leitura dados via query

@author    paulo.bindo
@version   11.3.10.201812061821
@since     21/06/2019
/*/


User Function  AQuery()

	Local cAliasFor
	Local cSql := ""
	Local nRec := 0

	If SELECT("SX6") >0
		ALERT("PROTHEUS ABERTO")
	Else
		RpcSetType(3)
		PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT"
	EndIf

	cAliasFor := GetNextAlias() //CRIA ALIAS TEMPORARIO

	//TEXTO QUERY
	cSql :=" Select A2_COD,  A2_LOJA, A2_NREDUZ, A2_EST, A2_MSBLQL,A2_ULTCOM "+ENTER
	cSql +=" FROM " + RetSQLName("SA2")+" "+ENTER
	cSql +=" Where A2_FILIAL = '" + xFilial("SA2") + "'"+ENTER
	cSql +=" AND D_E_L_E_T_ = ' ' "+ENTER

	//GERA ARQUIVO NA PASTA SYSTEM
	MemoWrite("AULA_QUERY.SQL",cSql)

	//TRATAMENTO ADEQUACAO QUERY
	cSql := ChangeQuery(cSql)

	//CRIA TABELA TEMPORARIA
	TCQUERY ( cSql ) ALIAS ( cAliasFor ) NEW

	//CONVERSAO TIPO DE DADO
	TCSetField(cAliasFor,"A2_ULTCOM","D" )

	//CONTA QUANTIDADE REGISTROS
	Count To nRec

	If nRec == 0
		Alert("NAO FORAM ENCONTRADOS DADOS, REFACA OS PARAMETROS","ATENCAO")
		DbSelectArea(cAliasFor)
		dbCloseArea()
		Return
	EndIf


	//ABRE TABELA TEMPORARIA
	DbSelectArea(cAliasFor)
	dbGoTop()

	While !Eof()

		Conout(A2_COD+" - "+A2_NREDUZ)


		DbSelectArea(cAliasFor)
		dbSkip()
	End

	//FECHA A TABELA TEMPORARIA
	DbSelectArea(cAliasFor)
	dbCloseArea()

	RESET ENVIRONMENT
Return

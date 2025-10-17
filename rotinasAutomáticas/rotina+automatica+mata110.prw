#INCLUDE "Protheus.ch"

#DEFINE ENTER Chr(13)+Chr(10)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRAMATA110  บ Autor ณ Paulo Bindo        บ Data ณ  15/02/22   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ ROTINA AUTOMATICA DE SOLICITACAO DE COMPRAS                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function RAMATA110()

	Local cItem  	:= "0001"
	Local cUser		:= RetCodUsr()
	Local aCab  := {}
	Local aItem := {}
	Local cNumero

//VERIFICA SE JA EXISTE UM SOLICITACAO GERADA, PARA OS CASOS DE UMA RE-IMPORTACAO DO ARQUIVO
	cQuery := " SELECT * FROM "+RetSqlName("SB1")+" "+ENTER
	cQuery += " WHERE D_E_L_E_T_ <> '*'"+ENTER
	cQuery += " AND NOT EXISTS(SELECT 'S' FROM "+RetSqlName("SC1")+" C1 WHERE C1_FILIAL =  '"+xFilial("SC1")+"' AND C1_PRODUTO = B1_COD AND C1.D_E_L_E_T_ <> '*' AND C1_EMISSAO = '"+Dtos(dDataBase)+"')"+ENTER
	cQuery += " AND B1_TIPO IN ('MP','ME')"+ENTER
	cQuery += " AND B1_FILIAL = '"+xFilial("SB1")+"'"+ENTER

	MEMOWRITE("QUERY\RAMATA110.SQL",cQuery)
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),"TRB1", .F., .T.)

	Count To nCount

	If nCount = 0
		MsgStop("Nใo existem dados para a consulta realizada!","Aten็ใo - RAMATA110")
		TRB1->(dbCloseArea())
		Return
	EndIf



	cTextoObs := "AULA ROTINA AUTOMATICA"
	nQuant := 1

	DbSelectArea("TRB1")
	dbGoTop()

	While !Eof()

//CABECALHO DA SOLICITACAO
		aCab := {{"C1_EMISSAO" ,dDataBase  	  ,Nil},;  // Data de Emissao
		{"C1_FORNECE" ,""			  ,Nil},; // Fornecedor
		{"C1_LOJA"    ,""			  ,Nil},;  // Loja do Fornecedor
		{"C1_SOLICIT" ,CriaVar("C1_SOLICIT"), Nil}}

//ITEM DA SOLICITACAO
		aItem:={{{"C1_ITEM"		,cItem						,Nil},; //Numero do Item
		{"C1_PRODUTO"	,TRB1->B1_COD					,Nil},; //Codigo do Produto
		{"C1_QUANT"  	,nQuant							,Nil},; //Quantidade
		{"C1_LOCAL"  	,TRB1->B1_LOCPAD					,Nil},; //Armazem
		{"C1_DATPRF" 	,dDataBase						,Nil},; //Data
		{"C1_TPOP"    	,"F"							,Nil},; // Tipo SC
		{"C1_CC"  		,TRB1->B1_CC    					,Nil},; //Centro de Custos
		{"C1_APROV"		,"L" 		   					,Nil},; //LIBERA SC
		{"C1_GRUPCOM"  	,MaRetComSC(TRB1->B1_COD,UsrRetGrp(),cUser),Nil},; //Grupo de Compras
		{"C1_OBS"  		,cTextoObs			 		   	,Nil},;  //Observacao
		{"AUTVLDCONT" ,"N", Nil}}}

		lMSErroAuto := .F.

		MSExecAuto({|v,x,y,z| MATA110(v,x,y,z)},aCab,aItem,3,.F.)

		IF ! lMSErroAuto
			cNumero := SC1->C1_NUM
			//LIBERA A SOLICITACAO AUTOMATICAMENTE APOS INCLUSAO
			DbSelectArea("SC1")
			DbSetOrder(1)
			If DbSeek(xFilial("SC1")+cNumero)
				While SC1->C1_NUM == cNumero
					RecLock("SC1",.F.)
					SC1->C1_APROV 		:= 'L'
					MsUnlock()
					DbSkip()
				EndDo
			EndIf

			Conout("Inclusao de Solicitacao de compras efetuada"+cNumero)
		Else
			Mostraerro()
		EndIF




		DbSelectArea("TRB1")
		dbSkip()
	END

	TRB1->(dbCloseArea())

Return




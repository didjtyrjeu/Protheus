#include "rwmake.ch"
#IFNDEF WINDOWS
	#DEFINE PSAY SAY
#ENDIF

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CORL001_AP5ºAutor  ³Paulo Bindo        º Data ³  10/01/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatorio de relacao de pedidos de compras                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CORL001()

SetPrvt("WNREL,CDESC1,CDESC2,CDESC3,AORD,TITULO")
SetPrvt("CPERG,CSTRING,ARETURN,NOMEPROG,NLASTKEY,ALINHA")
SetPrvt("LIMITE,TAMANHO,LEND,IMPRIME,CBTXT,NQUEBRA")
SetPrvt("CCABQUEBRA,CQUEBRANT,NQUANT_A_REC,NQUANT_T_REC,CBCONT,LI")
SetPrvt("M_PAG,NT_QTD_PED,NT_VL_IPI,NT_VL_TOTAL,NT_QTD_ENTR,NT_SD_RECEB")
SetPrvt("NT_DESC,NPEDIDA,NVALIPI,NTOTAL,NQUANT,NSALDO")
SetPrvt("NFLAG,NITEMIPI,NSALIPI,NFRETE,NDESC,CABEC1")
SetPrvt("NORDEM,CCAMPO,CTEXQUEBRA,CABEC2,_CFONE,_CCONTATO")
SetPrvt("_CEMAIL,ATAM,J,CCONTATO,NC1,NC2")
SetPrvt("NC3,NC4,NC5,NC6,CTOTAL,NTOTIPI")
SetPrvt("NTOTAL1,NSALIPI1,NVALOR,NSALDO1,NTOTDESC,NREST")


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR120  ³ Autor ³ Sergio Compain        ³ Data ³ 05.10.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao da Relacao de Pedidos de Compras                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ OBS      ³ Programa trans.p/ RDMAKE em 05/10/99                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
wnrel    := "CORL001"
cDesc1   := "Emissao da Relacao de  Pedidos de Compras."
cDesc2   := "Sera solicitado em qual Ordem, qual o Intervalo para"
cDesc3   := "a emissao dos pedidos de compras."

aOrd     := { " Por Numero         "," Por Produto        "," Por Fornecedor   "}

titulo   := "Relacao de Pedidos de Compras"
cPerg    := "MTR120"
cString  := "SC7"
aReturn  := { "Zebrado", 1,"Compras", 1, 2, 1, "",1 }
nomeprog := "CORL001"
nLastKey := 0
aLinha   :={ }
LIMITE   :=220
tamanho  :="G"
lEnd     := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Imprime  := .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte("MTR120",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01       // do produto                                 ³
//³ mv_par02       // ate o produto                              ³
//³ mv_par03       // data de emissao de                         ³
//³ mv_par04       // data de emissao ate                        ³
//³ mv_par05       // data de entrega inicial                    ³
//³ mv_par06       // data de entrega final                      ³
//³ mv_par07       // todas ou em aberto ou residuos ou atendidos³
//³ mv_par08       // pedido inicial                             ³
//³ mv_par09       // pedido final                               ³
//³ mv_par10       // Listar  PC    AE    Ambos                  ³
//³ mv_par11       // Pedidos Liberados  Bloqueados Ambos        ³
//³ mv_par12       // Impr. SC's Firmes, Previstas ou Ambas      ³
//³ mv_par13       // Tipo de Moeda - 1, 2, 3, 4 ou 5            ³
//³ mv_par14       // Descricao do Produto                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.f.,Tamanho)

If Lastkey()==27 .or. nlastkey==27
	Return(Nil)
EndIF

SetDefault(aReturn,cString)

If LastKey() == 27 .OR. nLastKey == 27
	
	Return(Nil)
Endif


RptStatus({||M120IP()})


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ M120IP   ³ Autor ³ Sergio Compain        ³ Data ³ 05.10.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR120                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function M120IP()

cbtxt        := SPACE(10)
nQuebra      := 0
cCabQuebra   := " "
cQuebrant    := " "
nQuant_a_Rec := 0
nQuant_t_Rec := 0
CbCont       := 00
li           := 80
m_pag        := 01

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Totalizar os valores do relatorio  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nT_qtd_ped   := 0         // qtde pedida
nT_vl_ipi    := 0         // valor do ipi
nT_vl_total  := 0         // valor total do pedido
nT_qtd_entr  := 0         // qtde entregue
nT_sd_receb  := 0         // saldo a receber
nT_desc      := 0         // total de desconto

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Totalizar os valores p/ item de acordo com a ordem ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nPedida      := 0         // qtde pedida
nValIpi      := 0         // valor do ipi
nTotal       := 0         // valor total do pedido
nQuant       := 0         // qtde entregue
nSaldo       := 0         // saldo a receber
nFlag        := 0         // flag que indica se imprime totais por item ou nao
nITemIpi     := 0
nSalIpi      := 0
nFrete       := 0         // valor do frete
nDesc        := 0         // valor do desconto
nREST		 := 0         // valor a ser entregue
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os Cabecalhos de acordo com os parametros              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

// cabec1    := "RELACAO DOS PEDIDOS DE COMPRAS"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Localiza o ponto inicial para a impressao                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//nOrdem := aReturn[8]


If aReturn[8] > 2
	nOrdem := 9    // 14    Por ordem de fornecedor
Else
	nOrdem := aReturn[8]
Endif


dbSelectArea("SC7")
dbSetOrder(nOrdem)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica qual ordem foi selecionada                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If nOrdem == 1
	dbSeek(xFilial()+mv_par08,.T.)
	cCampo     := C7_NUM
	
	If mv_par10 == 2
		cTexQuebra := "AUTOR. N. : "
	Else
		cTexQuebra := "PEDIDO N. : "
	EndIf
	
	titulo := "RELACAO DOS PEDIDOS DE COMPRAS - POR NUMERO"
	cabec1 :=    "IT CODIGO          DESCRICAO                      GRP  CODIGO RAZAO SOCIAL                        DATA DE  ENTREGA   QUANTIDADE  UM      VALOR        VALOR         VALOR TOTAL  QUANT.      QUANT. A          SALDO   RES."
	cabec2 :=    "   PRODUTO         DO PRODUTO                           FORN.                                     EMISSAO  PREVISTA      PEDIDA           UNIT.         IPI            (C/IPI)   ENTREGUE    RECEBER         RECEBER  ELIM."
	//            0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	//                      1         2         3         4         5         6         7         8         9        10        11        12        13   X    14        X5        16   X    17        18        19        20        10
	
ElseIf nOrdem == 2
	
	dbSeek(xFilial()+mv_par01,.T.)
	cCampo     := C7_PRODUTO
	cTexQuebra := "PRODUTO : "
	titulo     := "RELACAO DOS PEDIDOS DE COMPRAS - POR PRODUTO"
	cabec1 :=    "PEDIDO IT DATA     CODIGO    QUANTIDADE QUANTIDADE    QUANT.A CODIGO                               FONE            DESCRICAO            ENTREGA          VALOR       VALOR       VALOR        TOTAL   CONTATO      RESIDUOS"
	cabec2 :=    "NUMERO    EMISSAO  PRODUTO       PEDIDA   ENTREGUE    RECEBER FORNEN.                              FORN.           PRODUTO              PREVISTA      UNITARIO      SIMPLES       IPI        (C/IPI)               ELIMIN. "
	//            999999 99 99/99/99 123456789 999.999,99 999.999,99 999.999,99 999999 1234567890123456789012345678  123456789012345 12345678901234567890 99/99/99  99.999,99999   99.999,99999   9.999,99 99.999,99 123456789012345   XXX
	//            0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	//                      1         2         3         4         5         6         7         8         9        T0        11        12        13   X    14        X5        16   X    17        18        19        20        10
	
Else    // Ordem == 3
	dbSeek(xFilial())
	cCampo     := C7_FORNECE
	cTexQuebra := "FORNECEDOR : "
	titulo     := "RELACAO DOS PEDIDOS DE COMPRAS - POR FORNECEDOR"
	cabec1     :=    "PEDIDO ITEM  DATA     CODIGO           DESCRICAO DO PRODUTO           GRUPO  ENTREGA        QUANTIDADE        PRECO     PRECO          VALOR      PRECO TOTAL        QUANTIDADE      QUANT. A       SALDO     RESIDUOS"
	cabec2     :=    "NUMERO       EMISSAO  PRODUTO                                                PREVISTA           PEDIDA     UNITARIO   SIMPLES           IPI        (C/IPI)            ENTREGUE      RECEBER        RECEBER   ELIMINADOS"
	//               0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	//                         1         2         3         4         5         6         7         8         9        10        11        12        13   X    14        X5        16   X    17        18        19        20
Endif

If mv_par07==1
	titulo := titulo + ", Todos"
Elseif mv_par07==2
	If nOrdem == 1
		titulo := "RELACAO DOS PEDIDOS DE COMPRAS - POR NUMERO"
		cabec1 := "IT CODIGO          DESCRICAO                      GRP  CODIGO RAZAO SOCIAL                        DATA DE  ENTREGA  ENTREGA  QUANTIDADE UM         VALOR      VALOR     VALOR TOTAL     QUANT.   QUANT. A        SALDO  RES."
		cabec2 := "   PRODUTO         DO PRODUTO                           FORN.                                     EMISSAO  PREVISTA ORIGINAL     PEDIDA            UNIT.        IPI         (C/IPI)   ENTREGUE    RECEBER      RECEBER ELIM."
		//         99 123456789012345 123456789012345678901234567890 1234                                            99/99/99 99/99/99 99/99/99 999.999,99 99 99.999.999,99 1234567,99 123456789012,99 1234567,99 1234567,99 123456789,99   SIM
		//         0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
		//                   1         2         3         4         5         6         7         8         9        10        11        12        13   X    14        X5        16   X    17        18        19        20        10
	ElseIf nOrdem == 2
		titulo := "RELACAO DOS PEDIDOS DE COMPRAS - POR PRODUTO"
		cabec1 := "PEDIDO IT DATA     CODIGO    QUANTIDADE QUANTIDADE    QUANT.A CODIGO                              FONE  DESCRICAO                      ENTREGA  ENTREGA         VALOR        VALOR    VALOR        TOTAL  CONTATO        RES."
		cabec2 := "NUMERO    EMISSAO  PRODUTO       PEDIDA   ENTREGUE    RECEBER FORNEN.                             FORN. PRODUTO                        PREVISTA ORIGINAL     UNITARIO      SIMPLES      IPI       (C/IPI)               ELIM."
		//         999999 99 99/99/99 123456789 999.999,99 999.999,99 999.999,99 999999 123456789012345678 123456789012345 123456789012345678901234567890 99/99/99 99/99/99 99.999,99999 99.999,99999 9.999,99 99.999.999,99 123456789012345 XXX
		//         0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
		//                   1         2         3         4         5         6         7         8         9        T0        11        12        13   X    14        X5        16   X    17        18        19        20        10
	Else    // Ordem == 3
		titulo := "RELACAO DOS PEDIDOS DE COMPRAS - POR FORNECEDOR"
		cabec1 := "PEDIDO ITEM  DATA     CODIGO           DESCRICAO DO PRODUTO           GRUPO  ENTREGA  ENTREGA       QUANTIDADE       PRECO    PRECO         VALOR     PRECO TOTAL        QUANTIDADE    QUANT. A            SALDO     RESIDUOS"
		cabec2 := "NUMERO       EMISSAO  PRODUTO                                                PREVISTA ORIGINAL          PEDIDA    UNITARIO  SIMPLES           IPI         (C/IPI)          ENTREGUE     RECEBER          RECEBER   ELIMINADOS"
		//         999999  99   99/99/99 123456789012345  123456789012345678901234567890  1234  99/99/99 99/99/99 123456789012,99 12345678901 12345678 1234567890,99 123456789012,99   123456789012,99  999.999,99  123456789012,99       XXX
		//         0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
		//                   1         2         3         4         5         6         7         8         9        10        11        12        13   X    14        X5        16   X    17        18        19        20
	Endif
	titulo := titulo + ", Em Abertos"
Elseif mv_par07==3
	titulo := titulo + ", Residuos"
Elseif mv_par07==4
	titulo := titulo + ", Atendidos"
Endif

#IFNDEF WINDOWS
	SetRegua(RecCount())
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia a leitura do arquivo SC7                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Do While !Eof() .And. C7_FILIAL == xFilial()
	
	#IFNDEF WINDOWS
		IncRegua()
	#ENDIF
	
	#IFNDEF WINDOWS
		If LastKey() = 286    //ALT_A
			lEnd := .t.
		EndIf
	#ENDIF
	
	If lEnd
		@PROW()+1,001 PSAY "CANCELADO PELO OPERADOR"
		Exit
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste este item. POR PEDIDO                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If C7_NUM < mv_par08 .Or. C7_NUM > mv_par09
		dbSkip()
		Loop
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste este item. POR PRODUTO                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
	If C7_PRODUTO < mv_par01 .Or. C7_PRODUTO > mv_par02
		dbSkip()
		Loop
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste este item. POR EMISSAO                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If C7_EMISSAO < mv_par03 .Or. C7_EMISSAO > mv_par04
		dbSkip()
		Loop
	Endif
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste se o pedidos esta liberado.                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If (C7_CONAPRO == "B" .And. mv_par11 == 1) .Or.;
		(C7_CONAPRO != "B" .And. mv_par11 == 2)
		dbSkip()
		Loop
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste este item. EM ABERTO                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If mv_par07 == 2
		If C7_QUANT-C7_QUJE <= 0 .Or. !EMPTY(C7_RESIDUO)
			dbSkip()
			Loop
		Endif
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste este item. RESIDUOS                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If mv_par07 == 3
		If EMPTY(C7_RESIDUO)
			dbSkip()
			Loop
		Endif
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste este item. ATENDIDOS                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If mv_par07 == 4
		If C7_QUANT > C7_QUJE
			dbSkip()
			Loop
		Endif
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste Tipo	de Pedido  1-PC    2-AE    3-Ambos             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If mv_par10 == 1 .And. C7_TIPO != 1
		dbSkip()
		Loop
	ElseIf mv_par10 == 2 .And.	C7_TIPO !=2
		dbSkip()
		Loop
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtra Tipo de SCs Firmes ou Previstas                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If !MtrAValOP(mv_par12, 'SC7')
		dbSkip()
		Loop
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se e nova pagina                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If li > 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
		li := li-1
	Endif
	
	If nOrdem == 1
		cCampo  := C7_NUM
	ElseIf nOrdem == 2
		cCampo  := C7_PRODUTO
	Else
		cCampo  := C7_FORNECE
	Endif
	
	If nQuebra == 0
		cQuebrant := cCampo
		li := li+1
		If li > 60
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
			li := li-1
		Endif
		If nOrdem == 1
			cCabQuebra := " "
		ElseIf nOrdem == 2
			dbSelectArea("SB1")
			dbSeek(xFilial()+SC7->C7_PRODUTO)
			cCabQuebra := B1_DESC
		ElseIf nOrdem == 3
			dbSelectArea("SA2")
			dbSeek(xFilial()+SC7->C7_FORNECE)
			cCabQuebra := A2_NOME
			_cFone     := A2_TEL
			_cContato  := A2_CONTATO
			_cEmail    := A2_EMAIL
		Endif
		
		 @ li,013 PSAY cTexQuebra + cCampo + " " + Substr(cCabQuebra,1,30)
		
		if nOrdem == 1 .or. nOrdem > 2
			dbSelectArea("SA2")
			If dbSeek(xFilial()+SC7->C7_FORNECE+SC7->C7_LOJA)
				If nOrdem == 1
					@ li,068 PSAY SC7->C7_FORNECE
					@ li,075 PSAY Substr(SA2->A2_NOME,1,30)
					@ li,111 PSAY "Fone.:"+SA2->A2_TEL
				Else
//					@ li,010 PSAY "Fornecedor:"+ SA2->A2_NREDUZ
					@ li,035 PSAY SA2->A2_NREDUZ
					@ li,065 PSAY "Fone.:"+Substr(SA2->A2_TEL,1,15) + "Fax:" + SA2->A2_FAX + "Contato:" + SA2->A2_CONTATO + " Email: " + SA2->A2_EMAIL
				Endif
			Endif
			dbSelectArea("SC7")
		Endif
		nQuebra := 1
		nFlag:=0
	Endif
	
	dbSelectArea("SC7")
	If cQuebrant != cCampo
		nQuebra := 0
		li:=li+1
		If li > 60
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
			li:=li-1
		Endif
		If nFlag > 1 .Or. nOrdem == 1
			Impitem()
			nFlag:=0
		EndIf
		nPedida:=0
		nValIpi:=0
		nTotal:=0
		nQuant:=0
		nSaldo:=0
		nQuant_a_Rec :=0
		nQuant_t_Rec :=0 
		nREST := 0
		@ li,000 PSAY Replicate("-",limite)
		Loop
	Endif
	li:=li+1
	If li > 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
		li:=li-1
	Endif
	nItemIpi := 0
	nSalIpi := 0
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica ordem a ser impressa           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If mv_par07<>2
		If nOrdem == 1
			ImpOrd1()
		ElseIf nOrdem == 2
			ImpOrd2()
		Else
			ImpOrd3()
		Endif
	Else
		If nOrdem == 1
			ImpOrd1A()
		ElseIf nOrdem == 2
			ImpOrd2A()
		Else
			ImpOrd3A()
		Endif
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Soma as variaveis dos totais p/item     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	nPedida := nPedida + C7_QUANT
	nValIpi := nValIpi + nItemIPI
	nTotal  := nTotal  + (C7_QUANT * IIf(Empty(C7_REAJUSTE),C7_PRECO,Formula(C7_REAJUSTE))) + nItemIPI
	nQuant  := nQuant  + C7_QUJE
	nQuant_a_Rec := If(Empty(C7_RESIDUO),IIF(C7_QUANT-C7_QUJE<0,0,C7_QUANT-C7_QUJE),0)
	nQuant_t_Rec:= nQuant_t_Rec1 + nQuant_a_Rec
	nSaldo  := nSaldo  + (nQuant_a_Rec * IIf(Empty(C7_REAJUSTE),C7_PRECO,Formula(C7_REAJUSTE))) + nSalIPI
	nREST   := nREST +  (nQuant_a_Rec * IIf(Empty(C7_REAJUSTE),C7_PRECO,Formula(C7_REAJUSTE)))+nSalIPI 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valor do Frete         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	nFrete := C7_FRETE
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valor do Desconto         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If C7_DESC1 != 0 .or. C7_DESC2 != 0 .or. C7_DESC3 != 0
		nDesc := nDesc + CalcDesc(C7_TOTAL,C7_DESC1,C7_DESC2,C7_DESC3)
	Else
		nDesc := nDesc + C7_VLDESC
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Soma as variaveis dos totais gerais     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	nT_vl_ipi   := nT_vl_ipi   + nItemIPI
	nT_vl_total := nT_vl_total +;
	(C7_QUANT * IIf(Empty(C7_REAJUSTE),C7_PRECO,Formula(C7_REAJUSTE)))+ nItemIPI
	nT_sd_receb := nT_sd_receb + (nQuant_a_Rec * IIf(Empty(C7_REAJUSTE),C7_PRECO,Formula(C7_REAJUSTE))) + nSalIPI
	
	dbSelectArea("SC7")
	dbSkip()
EndDo

If nFlag > 1 .Or. nOrdem == 1
	If li > 60 .And. li != 80
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
		li:=li-1
	Endif
	If li != 80
		Impitem()
	Endif
	nFlag:=0
EndIf

If nT_qtd_ped > 0 .Or. nT_vl_ipi > 0 .Or.;
	nT_vl_total > 0 .Or. nT_qtd_entr > 0 .Or. nT_sd_receb > 0
	Imptot(limite)
Endif

IF li != 80
	li:=li+1
	If li > 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
		li:=li-1
	Endif
	@ li,000 PSAY Replicate("-",limite)
	roda(CbCont,"PEDIDOS","G")
EndIF

dbSelectArea("SC7")
dbSetOrder(1)

Set device to Screen

If aReturn[5] == 1
	Set Printer TO
	Commit
	ourspool(wnrel)
Endif

MS_FLUSH()

Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ IMPORD1  ³ Autor ³ Claudinei M. Benzi    ³ Data ³ 05.09.91 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do relatorio na 1a ordem                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR120                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 25/05/01 ==> Function ImpOrd1
Static Function ImpOrd1()

nQuant_a_Rec:=0
aTam:=TamSx3("C7_PRECO")

dbSelectArea("SC7")
@ li,000 PSAY C7_ITEM
@ li,003 PSAY C7_PRODUTO
nFlag:=nFlag+1
@ li,019 PSAY C7_DESCRI //Subs(C7_DESCRI,1,30)
dbSelectArea("SB1")
dbSeek(xFilial("SB1")+SC7->C7_PRODUTO)
If Found()
	@ li,050 PSAY B1_GRUPO
Endif

dbSelectArea("SC7")
@ li,098 PSAY C7_EMISSAO
@ li,107 PSAY C7_DATPRF
@ li,118 PSAY C7_QUANT Picture Tm(C7_QUANT,10,2)
@ li,129 PSAY C7_UM
If !Empty(C7_REAJUSTE)
	@ li,132 PSAY Formula(C7_REAJUSTE) Picture tm(Formula(C7_REAJUSTE),10,2)
Else
	@ li,132 PSAY C7_PRECO Picture tm(C7_PRECO,13,aTam[2])
Endif
CalcIPI()
nItemIPI := nTotIPI
nSalIPI := nSalIPI1
@ li,145 PSAY nItemIPI  Picture tm(nItemIPI,15,2)
@ li,161 PSAY (C7_QUANT * IIf(Empty(C7_REAJUSTE),C7_PRECO,Formula(C7_REAJUSTE)))+nItemIPI Picture tm(C7_TOTAL,15,2)
@ li,176 PSAY C7_QUJE Picture tm(C7_QUJE,10,2)
nQuant_a_Rec := If(Empty(C7_RESIDUO),IIF(C7_QUANT-C7_QUJE<0,0,C7_QUANT-C7_QUJE),0)
@ li,187 PSAY nQuant_a_Rec Picture tm(C7_QUANT-C7_QUJE,10,2)
@ li,199 PSAY (nQuant_a_Rec * IIf(Empty(C7_REAJUSTE),C7_PRECO,Formula(C7_REAJUSTE)))+nSalIPI Picture tm(C7_TOTAL,15,2)
@ li,217 PSAY If(Empty(C7_RESIDUO),"Nao","Sim")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao da Descricao Adicional do Produto (se houver)      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For j:=31 TO Len(Trim(C7_DESCRI)) Step 30
	If !empty(Subs(C7_DESCRI,j,40))
		li:=li+1
		If li > 60
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
			li:=li-1
		Endif
		@ li,21 PSAY SubStr(C7_DESCRI,j,40)
	Endif
Next j

Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ IMPORD2  ³ Autor ³ Claudinei M. Benzi    ³ Data ³ 05.09.91 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do relatorio na 2a ordem                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR120                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 25/05/01 ==> Function ImpOrd2
Static Function ImpOrd2()

nQuant_a_Rec := 0
aTam:=TamSx3("C7_PRECO")

dbSelectArea("SC7")
@ li,000 PSAY C7_NUM
@ li,007 PSAY C7_ITEM
nFlag:=nFlag+1
@ li,010 PSAY C7_EMISSAO
@ li,019 PSAY Subs(C7_PRODUTO,1,9)
@ li,029 PSAY C7_QUANT Picture "@R 999,999.99"  //tm(C7_QUANT,10,2)
@ li,040 PSAY C7_QUJE  Picture "@R 999,999.99"  //tm(C7_QUJE,15,2)
nQuant_a_Rec := If(Empty(C7_RESIDUO),IIF(C7_QUANT-C7_QUJE<0,0,C7_QUANT-C7_QUJE),0)
@ li,051 PSAY nQuant_a_Rec Picture "@R 999,999.99" //tm(C7_QUANT-C7_QUJE,10,2)
@ li,062 PSAY C7_FORNECE
dbSelectArea("SA2")
If dbSeek(xFilial("SA2")+SC7->C7_FORNECE+SC7->C7_LOJA)
	@ li,069 PSAY Subs(A2_NOME,1,18)
	@ li,089 PSAY Subs(A2_TEL,1,15)
	cContato := SA2->A2_CONTATO
Endif
Select SC7
@ li,105 PSAY Subs(cCabQuebra,1,30)  // descricao do produto
@ li,136 PSAY C7_DATPRF
If !Empty(C7_REAJUSTE)
	@ li,146 PSAY Formula(C7_REAJUSTE) Picture "@R 99,999.99999" //tm(Formula(C7_REAJUSTE),14)
Else
	@ li,146 PSAY C7_PRECO  Picture "@R 99,999.99999" //tm(C7_PRECO,13,aTam[2]) 
Endif
CalcIPI()
nItemIPI := nTotIPI
nSalIPI := nSalIPI1
@ li,174 PSAY nSalIPI Picture "@E 9,999.99" //tm(nItemIPI,15,2)
@ li,182 PSAY (nQuant_a_Rec * IIf(Empty(C7_REAJUSTE),C7_PRECO,Formula(C7_REAJUSTE)))+nSalIPI Picture tm(C7_TOTAL*(1+(C7_IPI/100)),15,2)
@ li,199 PSAY Subs(cContato,1,15)
//@ li,187 PSAY (nQuant_a_Rec * IIf(Empty(C7_REAJUSTE),C7_PRECO,Formula(C7_REAJUSTE)))+nSalIPI Picture tm(C7_TOTAL,15,2)
@ li,215 PSAY If(Empty(C7_RESIDUO),"Nao","Sim")

Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ IMPORD3  ³ Autor ³ Claudinei M. Benzi    ³ Data ³ 05.09.91 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do relatorio na 3a ordem                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR120                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ImpOrd3()

nQuant_a_Rec:=0
aTam:=TamSx3("C7_PRECO")

dbSelectArea("SC7")
@ li,000 PSAY C7_NUM
@ li,008 PSAY C7_ITEM
nFlag:=nFlag+1
@ li,013 PSAY C7_EMISSAO
@ li,022 PSAY C7_PRODUTO
@ li,039 PSAY Subs(C7_DESCRI,1,40)
dbSelectArea("SB1")
if dbSeek(xFilial()+SC7->C7_PRODUTO)
	@ li,071 PSAY B1_GRUPO
Endif
dbSelectArea("SC7")
@ li,077 PSAY C7_DATPRF
@ li,088 PSAY C7_QUANT Picture tm(C7_QUANT,15,2)
If !Empty(C7_REAJUSTE)
	@ li,104 PSAY Formula(C7_REAJUSTE) Picture tm(Formula(C7_REAJUSTE),15,2)
Else
	@ li,104 PSAY C7_PRECO 		Picture tm(C7_PRECO,11,aTam[2])    
Endif

CalcIPI()
nItemIPI := nTotIPI
nSalIPI := nSalIPI1
@ li,124 PSAY nItemIPI   Picture tm(C7_TOTAL*(C7_IPI/100),15,2)
@ li,140 PSAY (C7_QUANT * IIf(Empty(C7_REAJUSTE),C7_PRECO,Formula(C7_REAJUSTE)))+nItemIPI Picture tm(C7_TOTAL*(1+(C7_IPI/100)),15,2)
@ li,158 PSAY C7_QUJE	Picture tm(C7_QUJE,15,2)
nQuant_a_Rec := If(Empty(C7_RESIDUO),IIF(C7_QUANT-C7_QUJE<0,0,C7_QUANT-C7_QUJE),0)
@ li,175 PSAY nQuant_a_Rec Picture tm(C7_QUANT-C7_QUJE,10,2)
@ li,187 PSAY (nQuant_a_Rec * IIf(Empty(C7_REAJUSTE),C7_PRECO,Formula(C7_REAJUSTE)))+nSalIPI Picture tm(C7_TOTAL,15,2)
@ li,203 PSAY If(Empty(C7_RESIDUO),"Nao","Sim")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao da Descricao Adicional do Produto (se houver)      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For j:=31 TO Len(Trim(C7_DESCRI)) Step 30
	If !empty(Subs(C7_DESCRI,j,40))
		li:=li+1
		If li > 60
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
			li:=li-1
		Endif
		@ li,39 PSAY SubStr(C7_DESCRI,j,40)
	Endif
Next j

Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ IMPTOT   ³ Autor ³ Cristina M. Ogura     ³ Data ³ 03.02.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao dos totais do relatorio                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR120                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ImpTot()

nc1 := 0
nc2 := 0
nc3 := 0
nc4 := 0
nc5 := 0
nc6 := 0

If nOrdem == 1
	nc3:= 145
	nc4:= 161
	nc6:= 199
ElseIf nOrdem == 2
	nc3:= 167
	nc4:= 182
	nc6:= 200
Else
	nc3:= 124
	nc4:= 140
	nc6:= 187
Endif
li:=li+2
@ li,000 PSAY "Total Geral "
@ li,nc3 PSAY nT_vl_ipi    Picture tm(nT_vl_ipi,15,2)
@ li,nc4 PSAY nT_vl_total  Picture tm(nT_vl_total,15,2)


Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ IMPITEM  ³ Autor ³ Rodrigo de A. Sartorio³ Data ³ 08.05.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao dos totais p/ item de acordo com a ordem         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR120                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ImpItem()

nc1 := 0
nc2 := 0
nc3 := 0
nc4 := 0
nc5 := 0
nc6 := 0


If nOrdem == 1
	nc1:= 118
	nc2:= 176
	nc5:= 187
	nc3:= 145
	nc4:= 161
	nc6:= 199
	cTotal:="Total dos Itens "
ElseIf nOrdem == 2
	nc1:= 29
	nc2:= 40
	nc5:= 51
	nc3:= 172
	nc4:= 187
	nc6:= 203
	cTotal:="Total do Produto"
Else
	nc1:= 80
	nc2:= 158
	nc5:= 175
	nc3:= 130
	nc4:= 146
	nc6:= 193
	cTotal:="Total do Fornecedor"
Endif

li:=li+1
@ li,000 PSAY cTotal
@ li,nc1 PSAY nPedida  Picture tm(nPedida,10,2)
@ li,nc2 PSAY nQuant   Picture tm(nQuant,10,2)
@ li,nc5 PSAY nQuant_t_Rec  Picture tm(nQuant_t_Rec,10,2)
@ li,nc3 PSAY nValIpi  Picture tm(nValIpi,10,2)
@ li,nc4 PSAY nTotal   Picture tm(nTotal,10,2)
If nOrdem #2
@ li,nc6 PSAY nREST    Picture tm(nREST,10,2)
EndIf

li:=li+1
If li > 60
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
	li:=li-1
Endif

If nOrdem == 1
	li:=li+1
	If li > 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
		li:=li-1
	Endif
	@ li,003 PSAY "Valor Total.......:"
	@ li,028 PSAY nTotal	Picture tm(nTotal,15,2)
	li:=li+1
	If li > 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
		li:=li-1
	Endif
	@ li,003 PSAY "Frete.............:"
	@ li,028 PSAY nFrete	Picture tm(nFrete,15,2)
	li:=li+1
	If li > 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
		li:=li-1
	Endif
	@ li,003 PSAY "Desconto..........:"
	@ li,028 PSAY nDesc   Picture tm(nDesc,15,2)
	nT_desc := nT_desc+nDesc
	li:=li+1
	If li > 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
		li:=li-1
	Endif
	@ li,003 PSAY "Total do Pedido...:"
	@ li,028 PSAY nTotal - nDesc + nFrete 	Picture tm(nTotal,15,2)
	li:=li+2
EndIf
nDesc:=0
Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CALCIPI  ³ Autor ³ Marcos Bregantim      ³ Data ³ 30.08.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calculo do IPI                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR120                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function CalcIPI()

nToTIPI   := 0
nTotal1   := 0
nSalIPI1   := 0
nValor    := (C7_QUANT) * IIf(Empty(C7_REAJUSTE),C7_PRECO,Formula(C7_REAJUSTE))
nSaldo1   := (C7_QUANT-C7_QUJE) * IIf(Empty(C7_REAJUSTE),C7_PRECO,Formula(C7_REAJUSTE))
nTotDesc  := C7_VLDESC

If nTotDesc == 0
	nTotDesc := CalcDesc(nValor,SC7->C7_DESC1,SC7->C7_DESC2,SC7->C7_DESC3)
EndIF
nTotal1 := nValor - nTotDesc
nTotIPI := IIF(SC7->C7_IPIBRUT == "L",nTotal1, nValor) * ( SC7->C7_IPI / 100 )
nTotal1 := nSaldo1 - nTotDesc
nSalIPI1 := IIF(SC7->C7_IPIBRUT == "L",nTotal1, nSaldo1) * ( SC7->C7_IPI / 100 )

Return




////////////////////////////////////////////////////////////////

Static Function ImpOrd1A()

nQuant_a_Rec:=0
aTam:=TamSx3("C7_PRECO")

dbSelectArea("SC7")
@ li,000 PSAY C7_ITEM
@ li,003 PSAY C7_PRODUTO
nFlag:=nFlag+1
@ li,019 PSAY C7_DESCRI
dbSelectArea("SB1")
dbSeek(xFilial("SB1")+SC7->C7_PRODUTO)
If Found()
	@ li,050 PSAY B1_GRUPO
Endif

dbSelectArea("SC7")
@ li,098 PSAY C7_EMISSAO
@ li,107 PSAY C7_DATPRF
@ li,116 PSAY C7_DTANT
@ li,125 PSAY C7_QUANT Picture Tm(C7_QUANT,10,2)
@ li,136 PSAY C7_UM
If !Empty(C7_REAJUSTE)
	@ li,142 PSAY Formula(C7_REAJUSTE) Picture tm(Formula(C7_REAJUSTE),10,2)
Else
	@ li,139 PSAY C7_PRECO Picture tm(C7_PRECO,13,aTam[2])
Endif
CalcIPI()
nItemIPI := nTotIPI
nSalIPI := nSalIPI1
@ li,153 PSAY nItemIPI  Picture tm(nItemIPI,10,2)
@ li,164 PSAY (C7_QUANT * IIf(Empty(C7_REAJUSTE),C7_PRECO,Formula(C7_REAJUSTE)))+nItemIPI Picture tm(C7_TOTAL,15,2)
@ li,180 PSAY C7_QUJE Picture tm(C7_QUJE,10,2)
nQuant_a_Rec := If(Empty(C7_RESIDUO),IIF(C7_QUANT-C7_QUJE<0,0,C7_QUANT-C7_QUJE),0)
@ li,191 PSAY nQuant_a_Rec Picture tm(C7_QUANT-C7_QUJE,10,2)
@ li,202 PSAY (nQuant_a_Rec * IIf(Empty(C7_REAJUSTE),C7_PRECO,Formula(C7_REAJUSTE)))+nSalIPI Picture tm(C7_TOTAL,12,2)
@ li,217 PSAY If(Empty(C7_RESIDUO),"Nao","Sim")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao da Descricao Adicional do Produto (se houver)      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For j:=31 TO Len(Trim(C7_DESCRI)) Step 30
	If !empty(Subs(C7_DESCRI,j,40))
		li:=li+1
		If li > 60
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
			li:=li-1
		Endif
		@ li,21 PSAY SubStr(C7_DESCRI,j,40)
	Endif
Next j

Return


Static Function ImpOrd2A()

nQuant_a_Rec := 0
aTam:=TamSx3("C7_PRECO")

dbSelectArea("SC7")
@ li,000 PSAY C7_NUM
@ li,007 PSAY C7_ITEM
nFlag:=nFlag+1
@ li,010 PSAY C7_EMISSAO
@ li,019 PSAY Subs(C7_PRODUTO,1,9)
@ li,029 PSAY C7_QUANT Picture "@R 999,999.99"  //tm(C7_QUANT,10,2)
@ li,040 PSAY C7_QUJE  Picture "@R 999,999.99"  //tm(C7_QUJE,15,2)
nQuant_a_Rec := If(Empty(C7_RESIDUO),IIF(C7_QUANT-C7_QUJE<0,0,C7_QUANT-C7_QUJE),0)
@ li,051 PSAY nQuant_a_Rec Picture "@R 999,999.99" //tm(C7_QUANT-C7_QUJE,10,2)
@ li,062 PSAY C7_FORNECE
dbSelectArea("SA2")
If dbSeek(xFilial("SA2")+SC7->C7_FORNECE+SC7->C7_LOJA)
	@ li,069 PSAY Subs(A2_NOME,1,18)
	@ li,088 PSAY Subs(A2_TEL,1,15)
	cContato := SA2->A2_CONTATO
Endif

Select SC7
@ li,104 PSAY Subs(cCabQuebra,1,30)  // descricao do produto
@ li,135 PSAY C7_DATPRF
@ li,144 PSAY C7_DTANT
If !Empty(C7_REAJUSTE)
	@ li,153 PSAY Formula(C7_REAJUSTE) Picture "@R 99,999.99999" //tm(Formula(C7_REAJUSTE),14)	
Else
	@ li,153 PSAY C7_PRECO  Picture "@R 99,999.99999" //tm(C7_PRECO,13,aTam[2]) 	
Endif
CalcIPI()
nItemIPI := nTotIPI
nSalIPI := nSalIPI1
@ li,179 PSAY nSalIPI Picture "@E 9,999.99" //tm(nItemIPI,15,2)
@ li,188 PSAY (nQuant_a_Rec * IIf(Empty(C7_REAJUSTE),C7_PRECO,Formula(C7_REAJUSTE)))+nSalIPI Picture tm(C7_TOTAL*(1+(C7_IPI/100)),13,2)
@ li,202 PSAY Subs(cContato,1,15)
@ li,218 PSAY If(Empty(C7_RESIDUO),"N","S")

Return


Static Function ImpOrd3A()

nQuant_a_Rec:=0
aTam:=TamSx3("C7_PRECO")

dbSelectArea("SC7")
@ li,000 PSAY C7_NUM
@ li,008 PSAY C7_ITEM
nFlag:=nFlag+1
@ li,013 PSAY C7_EMISSAO
@ li,022 PSAY C7_PRODUTO
@ li,039 PSAY Subs(C7_DESCRI,1,40)
dbSelectArea("SB1")
if dbSeek(xFilial()+SC7->C7_PRODUTO)
	@ li,071 PSAY B1_GRUPO
Endif
dbSelectArea("SC7")
@ li,077 PSAY C7_DATPRF
@ li,086 PSAY C7_DTANT
@ li,095 PSAY C7_QUANT Picture tm(C7_QUANT,15,2)
If !Empty(C7_REAJUSTE)
	@ li,111 PSAY Formula(C7_REAJUSTE) Picture tm(Formula(C7_REAJUSTE),15,2)
Else
	@ li,111 PSAY C7_PRECO 		Picture tm(C7_PRECO,11,aTam[2])    
Endif
CalcIPI()
nItemIPI := nTotIPI
nSalIPI := nSalIPI1
@ li,132 PSAY nItemIPI   Picture tm(C7_TOTAL*(C7_IPI/100),15,2)
@ li,146 PSAY (C7_QUANT * IIf(Empty(C7_REAJUSTE),C7_PRECO,Formula(C7_REAJUSTE)))+nItemIPI Picture tm(C7_TOTAL*(1+(C7_IPI/100)),15,2)
@ li,164 PSAY C7_QUJE	Picture tm(C7_QUJE,15,2)
nQuant_a_Rec := If(Empty(C7_RESIDUO),IIF(C7_QUANT-C7_QUJE<0,0,C7_QUANT-C7_QUJE),0)
@ li,181 PSAY nQuant_a_Rec Picture tm(C7_QUANT-C7_QUJE,10,2)
@ li,193 PSAY (nQuant_a_Rec * IIf(Empty(C7_REAJUSTE),C7_PRECO,Formula(C7_REAJUSTE)))+nSalIPI Picture tm(C7_TOTAL,15,2)
@ li,215 PSAY If(Empty(C7_RESIDUO),"Nao","Sim")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao da Descricao Adicional do Produto (se houver)      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For j:=31 TO Len(Trim(C7_DESCRI)) Step 30
	If !empty(Subs(C7_DESCRI,j,40))
		li:=li+1
		If li > 60
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
			li:=li-1
		Endif
		@ li,39 PSAY SubStr(C7_DESCRI,j,40)
	Endif
Next j

Return

/*
Numero
99 123456789012345 123456789012345678901234567890 1234                                            99/99/99 99/99/99   999.999,99 99 999.999,99   123456789012,99 123456789012,991234567,99 1234567,99  123456789012,99   SIM
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2

Produto
999999 99 99/99/99 123456789 999.999,99 999.999,99 999.999,99 999999 123456789012345678 123456789012345  123456789012345678901234567890 99/99/99  99.999,99999  99.999,99999  9.999,99123456789012,99  123456789012345 XXX
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2

Fornecedor
999999  99   99/99/99 123456789012345  123456789012345678901234567890  1234  99/99/99   123456789012,99 123456789012,99     123456789012,99 123456789012,99   123456789012,99  999.999,99  123456789012,99 XXX
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
*/

/*
IT CODIGO          DESCRICAO                      GRP  CODIGO RAZAO SOCIAL                        DATA DE  ENTREGA  ENTREGA  QUANTIDADE UM         VALOR      VALOR     VALOR TOTAL     QUANT.   QUANT. A        SALDO  RES."
   PRODUTO         DO PRODUTO                           FORN.                                     EMISSAO  PREVISTA ORIGINAL     PEDIDA            UNIT.        IPI         (C/IPI)   ENTREGUE    RECEBER      RECEBER ELIM."
99 123456789012345 123456789012345678901234567890 1234                                            99/99/99 99/99/99 99/99/99 999.999,99 99 99.999.999,99 1234567,99 123456789012,99 1234567,99 1234567,99 123456789,99   SIM
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2


PEDIDO IT DATA     CODIGO    QUANTIDADE QUANTIDADE    QUANT.A CODIGO                              FONE  DESCRICAO                      ENTREGA  ENTREGA         VALOR        VALOR    VALOR        TOTAL  CONTATO        RES."
NUMERO    EMISSAO  PRODUTO       PEDIDA   ENTREGUE    RECEBER FORNEN.                             FORN. PRODUTO                        PREVISTA ORIGINAL     UNITARIO      SIMPLES      IPI       (C/IPI)               ELIM."
999999 99 99/99/99 123456789 999.999,99 999.999,99 999.999,99 999999 123456789012345678 123456789012345 123456789012345678901234567890 99/99/99 99/99/99 99.999,99999 99.999,99999 9.999,99 99.999.999,99 123456789012345 XXX
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2

PEDIDO ITEM  DATA     CODIGO           DESCRICAO DO PRODUTO           GRUPO  ENTREGA  ENTREGA       QUANTIDADE       PRECO    PRECO         VALOR     PRECO TOTAL        QUANTIDADE    QUANT. A            SALDO     RESIDUOS"
NUMERO       EMISSAO  PRODUTO                                                PREVISTA ORIGINAL          PEDIDA    UNITARIO  SIMPLES           IPI         (C/IPI)          ENTREGUE     RECEBER          RECEBER   ELIMINADOS"
999999  99   99/99/99 123456789012345  123456789012345678901234567890  1234  99/99/99 99/99/99 123456789012,99 12345678901 12345678 1234567890,99 123456789012,99   123456789012,99  999.999,99  123456789012,99       XXX
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
*/

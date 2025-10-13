#include "protheus.ch"

User Function XCadSZ1()
	Local cAlias := "SZ1"
	Local cTitulo := "Cadastro de UM por Cliente"
	Local cVldExc := ".T."
	Local cVldAlt := "U_VldAlt()"

	dbSelectArea(cAlias)
	dbSetOrder(1)
	AxCadastro(cAlias,cTitulo,cVldExc,cVldAlt)

Return Nil

User Function VldAlt(cAlias,nReg,nOpc)
	Local lRet := .T.
	Local aArea := GetArea()
	Local nOpcao:= 0

	iF RetCodUsr() # "000000" .Or. INCLUI
		nOpcao := AxAltera(cAlias,nReg,nOpc)
	ELSE
		msgstop("usuario nao autorizado","atencao")
        lRet := .F.
	eNDif


	If nOpcao == 1
		MsgInfo("Altera��o conclu�da com sucesso!")
	Endif

	RestArea(aArea)
Return lRet

User Function VldExc(cAlias,nReg,nOpc)
	Local lRet := .T.
	Local aArea := GetArea()
	Local nOpcao := 0

	nOpcao := AxExclui(cAlias,nReg,nOpc)

	If nOpcao == 1
		MsgInfo("Exclus�o conclu�da com sucesso!")
	Endif

	RestArea(aArea)
Return lRet

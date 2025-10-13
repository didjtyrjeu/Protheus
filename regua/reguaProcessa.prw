#include "protheus.ch"

User Function PBRpt()

	Local aSay := {}
	Local aButton := {}
	Local nOpc := 0
	Local cTitulo := "Exemplo de fun��es"
	Local cDesc1 := "Este programa exemplificado a utiliza��o de fun��o Processa() em conjunto"
	Local cDesc2 := "Com as fun�oes de incremento ProcRegua() e IncProc()"

	AADD( aSay, cDesc1)
	AADD( aSay, cDesc2)
	AADD( aButton, {1, .T.{|| nOpc := 1, FechaBatch() }} )
	AADD( aButton, {2, .T.{|| FechaBatch() }} )

	FormaBatch( cTitulo, aSay, aButton )
	if nOpc <> 1
		Return
	Endif
	Processa({|lEnd|RunProc(@lEnd)}, "Aguarde...", "Executando rotina.", .T.) // Pode retornar mansagem

Return


Static Function RunProc(lEnd)
	Local nCnt := 0
	Local cCancel := "Cancelado pelo usu�rio"

	dbSelectArea("SX5")
	dbSetOrder(1)
	dbSeek(xFilial("SX5")+"01",.T.)
	dbEval( {|x| nCnt++} ,, {||X5_FILIAL==xFilial("SX5").AND.X5_TABELA<="99"})

	ProcRegua(nCnt)
	while !Eof() .AND. X5_FILIAL == xFilial("SX5") .AND. X5_TABELA <= 99
		incProc("Processando tabela: " + X5->X5_CHAVE)
		if lEnd
			MsgInfo(cCancel,"Fim")
			Exit
		Endif
		dbSkip()
	end

Return

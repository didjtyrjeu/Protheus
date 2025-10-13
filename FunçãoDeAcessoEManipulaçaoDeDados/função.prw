//bloco de cÃ³digo
#include "protheus.ch"
#include "TbiConn.ch"
#include "TbiCode.ch"

User Function Bloco()

	Local cCliente := "000001"
	Local cLoja := "01"
	Local cProd := "000001"

	RpcSetType(3)
	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT"
	dbSelectArea("SA3")
	dbCloseArea("SA3") //fecha a tabela
	dbSelectArea("SZ1") //abre uma tabela no banco
	//dbSetOrder(1) //índice de busca
	dbOrderNickName("Z1Client")
	dbGoTop() //volta para o primeiro
	//dbGoBotton() //vai para o utimo
	//dbGoTo(3) //vai no registro diretamente

	if dbSeek(xFilial()+cCliente+cLoja)
		alert("Achou")
		RecLock("SZ1", .F.) //trava a tebela alterar ou excluir um registro

		while !Eof()//enquanto não for o fim do arquivo
			//Estrutura para alterar um registro
			Z1_FATOR := 100
			MsUnlock()// destrava a tela
			//caso executeo dbSelectArea de outra tabela voltar para a primera
			SZ1->(dbSkip())//Pula para o proxímo
		end

	else
		RecLock("SZ1", .T.) //trava a tebela incluir um registro

		//Estrutura para incluir um registro
		Z1_FILIAL := xFilial()
		Z1_CLIENT := "000001"
		Z1_LOJA := "01"
		Z1_ PRODUT := "000001"
		Z1_UM := "PC"
		Z1_UMCLI := "CX"
		Z1_TIPO := "M"
		Z1_FATOR := 10
		MsUnlock()// destrava a tela
	Endif
    
    dbSelectArea("SZ1") 
    dbOrderNickName("Z1_PRODUCT")
    _cFiltro := "Z1_PRODUCT == 000001"
    _cFiltro := iif(_cFiltro == Nil, "",_cFiltro)

    if !empty(_cFiltro)
        SZ1->(dbSetFilter({|| &(_cFiltro)}, _cFiltro))
    Endif

	if dbSeek(xFilial()+cCliente+cLoja)
		alert("Achou")
		RecLock("SZ1", .F.) //trava a tebela alterar ou excluir um registro
	
		dbDelete() //apaga registro
		alert("Sem registro")
		MsUnlock()// destrava a tela
	Endif

	RESET ENVIRONMENT
	//dbUnlockAll(); libera todas as tabelas
	//dbLock(); exclusividade
    //softlock("SX6") trava a tabela para não ter alterações
    //select("SX6") verifica se uma tabela está sendo usada
Return

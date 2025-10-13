#include "protheus.ch"

User Function softl()
	RESET ENVIRONMENT

	Local i := 0
	Local cNumero

    if Select("SX6")
        Alert("Protheus Aberto")
    else
        RpcSetType(3)
        PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT"
    Endif
	

    //Pegar os dados de parâmetros
    GetMV("MV_1DUP") // Mais seguro no geral
    GetNewPar("MV_1DUP", "Teste", xFilial("SC5")) //Considere que não pode existir
    SuperGetMV("MV_1DUP", .T., "Teste",xFilial("SC5")) // Caso o parâmetro não exista pode exibir o Help

    //Gravar dados de parãmetros
    PutMv("MV_1DUP", "b") // PutMv("Parâmetro","Conteudo")


	dbSelectArea("SA1")
	dbSetOrder(3)

	RESET ENVIRONMENT
Return

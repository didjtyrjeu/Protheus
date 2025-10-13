#include "protheus.ch"

User Function softl()
	RESET ENVIRONMENT
	RpcSetType(3)
	Local i := 0
	Local cNumero
	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT"
	dbSelectArea("SA1")
	dbSetOrder(3)

	//Semáforo
	LockByName("TESTE", .F., .T.)

	UnLockByName("TESTE", .T., .T.)

	BeginTran()
	//Begin Transaction

	//Controle de numeração
	for i := 1 to 10
		cNumero := GetXNum("SA1","A1_COD")

		/*if cNumero $ "000003|000007"
			RollBackSXE()
		else*/

			A1_FILIAL := xFilial()
			RecLock("SA1", .T.) //trava a tebela incluir um registro
			A1_COD := GetXNum("SA1","A1_COD")
			A1_LOJA := "01"
			A1_NOME := "TESTE ENUMERAÇÃO"+cValToChar(i)
			A1_PESSOA := "F"
			A1_NREDUZ := "TESTE"+cValToChar(i)
			A1_END := "RUA"
			A1_BAIRRO := "TESTE"
			A1_TIPO := "F"
			A1_EST := "SP"
			A1_COD_MIM := "00105"
			A1_MUM := "ADAMAN"
			A1_NATUREZ := "1.00001"
			MsUnlock()// destrava a tela
			if cNumero == "000010"
 				DisarmTransaction() //cansela
			Endif
			/*if __lSX8
				ConfirmSx8()
			Endif*/
		//Endif

	Next

	EndTran()
	MsUnlockAll()
	//End Transaction


	/*
	if LockByName("TESTE", .F., .T.)
		msgAlert("Já usado","Lock")
	else

		UnLockByName("TESTE", .T., .T.)
	Endif*/
	RESET ENVIRONMENT
Return

//bloco de código
#include "protheus.ch"
#include "TbiConn.ch"
#include "TbiCode.ch"

User Function Bloco()

	//eval
	Local nItem := 100
	bBloco := {|x| y:=5, z:= x * y, k := z - y - x}

	nValor := Eval(bBloco, nItem) //executa o comando


	//dbeval
	Local nCnt := 0
	Local c_tab := "12"
	RpcSeType(3)
	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT"
	dbSelectArea("SX5") //abre uma tabela no banco
	dbSetOrder(1) //abre o �ndice

	dbGotop() //vai para o inicio do aquivo
	While !Eof() .AND. X5_FILIAL == xFilial("SX5") .AND. X5_TABELA <= c_tab //outra maneira de fazer
		nCnt++
		dbSkip()
	Enddo

	dbSelectArea("SX5")
	dbGotop()
    //permite que todos os registro de tabela sejam analisados e seja executado o bloco de codigo 
	dbEval( {|x| nCnt++},, {|| X5_FILIAL == xFilial("SX5"); .AND. X5_TABELA <=c_tab})


	RESET ENVIRONMENT

    //aEval + função
    RpcSetType(3)
	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT"
	
    Filha()

    RESET ENVIRONMENT
Return


//Função filha
Static Function Filha() // não funciona no menu, apenas dentro do próprio rdMake

    //aEval
	Local nx := 0
	Local aCampos := {}
	Local aTitulos := {}

	AADD(aCampos,"C5_FILIAL")
	AADD(aCampos,"C5_NUM")

	//Sem o aEval
	SC3->(dbSetOrder(2))
	for nX:=1 To Len(aCampos)
		SX3->(dbSeek(aCampos[nx]))
		aAdd(aTitulos,AllTrim(SX3->X2_TITULO))
	Next nX

	//O mesmo pode ser re-escrito com o uso da função aEval
	aTitulos:= {}
	Sx3->(dbGotop())
	aEval(aCampos,{|x| SX3->(dbSeek(x)),AAdd(aTitulos,AllTrim(SX3->X3_TITULO))}) 
    //Coloca os 2 itens dentro do acampos
	//e coloca no x(nomeCampo), adiciona dentro de aTitulos o nome do título
    //permitindo que seja analisado todo o conteudo do vetor e seja executado o codigo definido
Return 

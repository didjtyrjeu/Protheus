//função
#include "protheus.ch"

#DEFINE ENTER Ch(13)+Ch(10)

User Function Funcoes()

    cMens := "Teste de diretiva"+ENTER
    cMens2 := "Tem que dar um ENTER"
    alert(cMens+cMens2+ENTER)


    //Funções
    Local nValor := 10
    Local nQuant := 5
    Local nConta := 0
	
    nConta := u_Filha(@nValor, nCont)
    //nConta := u_Filha(@nValor)

Return
/*
Static Function Filha(nValor, nCont)

    local nTotal =: 0
    Default nQuant := 20 //define valor padrão se não tier nada

    if ValType(nQuant) != "N" //verifica se o valor existe
        nQuant :=0
    endif
    
    nValor := 2 

    nTotal := nValor * nConta

Return (ntotal)*/

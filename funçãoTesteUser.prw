//função
#include "protheus.ch"

User Function Funcoes()

    //Funções
    Local nValor := 10
    Local nQuant := 5
    Local nConta := 0
	
    //nConta := Filha(@nValor, nCont)
    //nConta := u_Filha(@nValor)

Return

User Function Filha(nValor, nCont)

    local nTotal =: 0
    Default nQuant := 20 //define valor padrão se não tier nada

    if ValType(nQuant) != "N" //verifica se o valor existe
        nQuant :=0
    endif
    
    nValor := 2 

    nTotal := nValor * nConta

Return (ntotal)

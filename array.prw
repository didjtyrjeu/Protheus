//array
#include "protheus.ch"

User Function array()

    //array
	Private aRotina := {,;
        {"Pesquisar","AxPesqui",0,1} ,;
		{"Visualizar","AxVisual",0,2} ,;
		{"Alterar","AxAltera",0,4} ,;
		{"Incluir","AxInclui",0,3} ,;
		{"Excluir","AxDeleta",0,5}
        }

    Private aArray := {}
    //NOME - MARCA - COR - SOM - PREÇO - ANO - VENDIDO
    aArray := {"nome1", "marca1","cor1",,.F., 123, 2012 }
    alert("nome"+aArray[1])

    aArray[1] := "nomeLegal" //alterar
    aArray[5] += 7 

    aSize(aArray, 7) //adiciona um campo
    aArray[1] := .T.

    //aDel(aArray, 7) remove um campo ou uma linha(matriz)

    //matriz
    AADD(aArray,{"nome2", "marca2","cor2",,.F., 123, 2012}) //adiciona um vetor na matriz
    AADD(aArray,{"nome3", "marca3","cor3",,.F., 123, 2012}) //adiciona um vetor na matriz

    for i := 1 Len(aArray)
        aArray[i, 7] := .F.
    Next

        aArrayCln := aClone(aArray) //copia os dados para outro vetor
        nPos := Ascan(aArrayCln,{|x|, x[1] == "nome3"}) //pro
        aArrayCln[nPos, 7] := .T.

    for i := 1 Len(aArrayCln)
        if aArrayCln[i, 7]
            aDel(aArrayCln[i])
            Asize(aArrayCln, Len(aArrayCln)-1)
        endif
    Next

    aArrayCln := aSort(aArrayCln,,,{|x,y| x[1] < |y[1]| })


Return

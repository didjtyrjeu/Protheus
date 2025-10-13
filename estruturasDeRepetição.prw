//estrutura de repetição
#include "protheus.ch"

User Function Teste()

	Local nNum := 0

	//For
	for nNum := 0 to 9 Step 3
		Conout(cToVarchar(nNum))
		if nNum == 5
			Loop
		elseif nNum ==9
			Exit
		else
			nNum--
		endif
		Conout("Passou"+cToVarchar(nNum)+" Vezes")
	next

	//While
	nNum := 0
	while nNum <= 10
		if nNum == 5
			nNum ++
			Loop
		elseif nNum ==9
			Exit
			nNum ++
		endif
	End

	//Estrutura de decisão
	Private nIPVA := .F.
	Private lReview := .F.
	Private cNewCarro
	Private nKm := 0

	while !Eof()
		if cCarro == "Novo"
			nIPVA := .T.
			if nKm >= 1000 .AND. nKm >= 1999
				lReview := .T.
			endif
		elseif cCarro == "Velho" .AND. cNewCarro == "Novo"
			nIPVA := .T.
		else
			nIPVA := .F.

			if nIPVA
				uGerar()
			endif
		endif
	end
	Do Case
	Case cCarro == "Novo"
		nIPVA := .T.
	Case cCarro == "Velho" .AND. cNewCarro == "Novo"
		nIPVA := .T.
	OtherWise
		nIPVA := .F.
	EndCase
	dbSkip()

Return

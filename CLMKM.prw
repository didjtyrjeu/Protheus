//Bibliotecas
#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'

//Variï¿½veis Estï¿½ticas
Static cTitulo := "Gestï¿½o de frota"

/*/{Protheus.doc} CLMKM
Funï¿½ï¿½o para Gestï¿½o de frota
@type function
@author Bryan Malheiros
@since 14/04/2025
@version 1.0.0
@return character, Nulo
/*/
User Function CLMKM()
	Local aArea   := GetArea()
	Local oBrowse

	//Setando nome da funï¿½ï¿½o
	SetFunName("CLMKM")

	//Cria um browse para a Z17
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias("Z17")
	oBrowse:SetDescription(cTitulo)

	//Desabilitando os detalhes do Browse
	oBrowse:DisableDetails()
	//incluir na legenda e o status Cancelar
	oBrowse:AddLegend( "Z17->Z17_STATUS=='A'", "GREEN" , "Aberto"      )
	oBrowse:AddLegend( "Z17->Z17_STATUS=='E'", "RED"   , "Encerrado"   )
	oBrowse:AddLegend( "Z17->Z17_STATUS=='C'", "BLACK" , "Cancelado"   )

	oBrowse:Activate()

	RestArea(aArea)

Return Nil

/*/{Protheus.doc} MenuDef
Montagem do menu de opï¿½ï¿½es
@type function
@author Bryan Malheiros
@since 14/v4/2025
@version 1.0.0
@return array, Array com as opï¿½ï¿½es do menu
/*/
Static Function MenuDef()
	Local aRotina := {}

	//Adicionando opï¿½ï¿½es
	ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.CLMKM' OPERATION MODEL_OPERATION_VIEW   ACCESS 0 //OPERATION 1
	ADD OPTION aRotina TITLE 'Incluir'      ACTION 'VIEWDEF.CLMKM' OPERATION MODEL_OPERATION_INSERT ACCESS 0 //OPERATION 3
	ADD OPTION aRotina TITLE 'Alterar'      ACTION 'VIEWDEF.CLMKM' OPERATION MODEL_OPERATION_UPDATE ACCESS 0 //OPERATION 4
	//ADD OPTION aRotina TITLE 'Excluir'      ACTION 'VIEWDEF.CLMKM' OPERATION MODEL_OPERATION_DELETE ACCESS 0 //OPERATION 5
	//Adicionar a rotina para cancelar o registro
	ADD OPTION aRotina TITLE 'Copiar'       ACTION 'VIEWDEF.CLMKM' OPERATION 9 ACCESS 0
	ADD OPTION aRotina TITLE 'Cancelar'     ACTION 'VIEWDEF.CLMKM' OPERATION 6 ACCESS 0
	ADD OPTION aRotina TITLE 'Legenda'      ACTION 'U_zAKMLEG()'   OPERATION 9 ACCESS 0
	ADD OPTION aRotina TITLE 'Conhecimento' ACTION 'U_CLMAKM()'    OPERATION 7 ACCESS 0
	/*'Pesquisar' 1 / 'Visualizar' 2 / 'Incluir' 3 / 'Alterar' 4 / 'Excluir' 5 / 'Cancelar' 6 / 'Conhecimento' 7 / 'Imprimir' 8 / 'Legenda' 9 */
	
Return aRotina

/*/{Protheus.doc} ModelDef
Montagem do modelo de dados em MVC
@type function
@author Bryan Malheiros
@since 14/04/2025
@version 1.0.0
@return object, Objeto do modelo de dados
/*/
Static Function ModelDef()
	Local oModel    := NIL
	Local oStruCab  := FWFormStruct(1, 'Z17')
	Local bCancelar := {|| fCancelar()}
	Local bVldPre   := {|| zVlPre()}
	Local bVldPos   := {|| zVlPos()}

	oModel := MPFormModel():New('CLMKMTVM', bVldPre, bVldPos, bCancelar, /*bCommit*/, /*bCancel*/ )

	oModel:AddFields('Z17MASTER', , oStruCab)

	oModel:SetDescription(cTitulo)

	oModel:SetPrimaryKey({"Z17_FILIAL", "Z17_NUM"})

	//Ativa o modelo
	oModel:SetVldActivate( { |oModel| fAlterar( oModel )/*, fCancelar( oModel )*/ })
	//oModel:SetVldActivate( { |oModel| fCancelar( oModel ) } )

Return oModel

/*/{Protheus.doc} fCancelar
Define se pode abrir o Modelo de Dados
@type function
@version 1.0.0 
@author Rodrigo Lombezzi
@since 12/17/2023
@return variant, Retorna um valor nulo
/*/
Static Function fCancelar()
	Local lRet       := .T.
	Local nOperation := oModel:GetOperation()

	/*'Pesquisar' 1 / 'Visualizar' 2 / 'Incluir' 3 / 'Alterar' 4 / 'Excluir' 5 / 'Cancelar' 6 / 'Conhecimento' 7 / 'Imprimir' 8 / 'Legenda' 9 */
	//Se for exclusï¿½o
	alert(Z17->Z17_STATUS)
	alert(nOperation)
	If nOperation == 6 .and. Z17->Z17_STATUS # 'A'
		lRet := .F.
		Help( , , 'Nï¿½o Permitido' , , 'O registro nï¿½o pode ser cancelado!', 1, 0, , , , , , {"Entre em contato com o setor de TI."})
	EndIf

Return lRet

/*/{Protheus.doc} ViewDef
Montagem da visualizaï¿½ï¿½o em MVC
@type function
@author Bryan Malheiros
@since 14/04/2025
@version 1.0.0
@return object, Objeto da visualizaï¿½ï¿½o
/*/
Static Function ViewDef()
	//Na montagem da estrutura da visualizaï¿½ï¿½o de dados, vamos chamar o modelo criado anteriormente, no cabeï¿½alho vamos mostrar somente 2 campos, e na grid vamos carregar conforme a funï¿½ï¿½o fViewStruct
	Local oView     := NIL
	Local oModel    := FWLoadModel('CLMKM')
	Local oStruCab  := FWFormStruct(2, "Z17")

	//Define que no cabeï¿½alho nï¿½o terï¿½ separaï¿½ï¿½o de abas (SXA)
	oStruCab:SetNoFolder()

	//Cria o View
	oView:= FWFormView():New()

	oView:SetModel(oModel)

	oView:AddField('VIEW_Z17', oStruCab, 'Z17MASTER')

	oView:CreateHorizontalBox("TELA", 100)

	oView:SetOwnerView('VIEW_Z17', 'TELA')

	oView:SetCloseOnOk({||.T.})

Return oView

/*/{Protheus.doc} fModStruct
Funï¿½ï¿½o chamada para montar o modelo de dados da Grid
@type function
@author Bryan Malheiros
@since 14/04/2025
@version 1.0.0
@return object, Estrutura do modelo de dados
/*/
Static Function fModStruct()
	Local oStruct
	oStruct := FWFormStruct(1, 'Z17')
Return oStruct

/*/{Protheus.doc} fViewStruct
Funï¿½ï¿½o para montar a estrutura do modelo de dados
@type function
@author Bryan Malheiros
@since 14/04/2025
@version 1.0.0
@return object, Estrutura do modelo de dados
/*/
Static Function fViewStruct()
	//Irï¿½ filtrar, e trazer todos os campos, menos os que tiverem na variï¿½vel cCampoCom
	oStruct := FWFormStruct(2, "Z17")
Return oStruct

/*/{Protheus.doc} fAlterar
Define se pode abrir o Modelo de Dados
@type function
@version 1.0.0 
@author helder
@since 12/17/2023
@return variant, Retorna um valor lï¿½gico True ou False
/*/
Static Function fAlterar( oModel )
	Local lRet       := .T.
	Local nOperation := oModel:GetOperation()

	/*'Pesquisar' 1 / 'Visualizar' 2 / 'Incluir' 3 / 'Alterar' 4 / 'Excluir' 5 / 'Cancelar' 6 / 'Conhecimento' 7 / 'Imprimir' 8 / 'Legenda' 9 */
	//Se for exclusï¿½o
	if Z17->Z17_STATUS # 'A'
		If nOperation == 4 
			lRet := .F.
			Help( , , 'Nï¿½o Permitido' , , 'O registro nï¿½o pode ser alterado!', 1, 0, , , , , , {"Entre em contato com o setor de TI."})
		Elseif nOperation == 6  
			lRet := .F.
			Help( , , 'Nï¿½o Permitido' , , 'O registro não pode ser cancelado.', 1, 0, , , , , , {"Entre em contato com o setor de TI."})
		EndIf
	EndIf
	/*
	If nOperation == 5 .and. Z17->Z17_STATUS $ 'EC'
		lRet := .F.
		Help( , , 'Nï¿½o Permitido' , , 'O registro nï¿½o pode ser excluï¿½do!', 1, 0, , , , , , {"Entre em contato com o setor de TI."})
	EndIf
	*/

Return lRet

/*/{Protheus.doc} U_zATVLEG
Funï¿½ï¿½o para exibir legenda de status dos equipamentos
@type function
@author Bryan Malheiros
@since 14/04/2025
@version 1.0
@return character, Nulo
/*/
User Function zAKMLEG()
	Local oLegenda as object

	oLegenda := FWLegend():New()

	//Monta as cores
	//add nova legenda cancelado padrado de cor Preto BLACK
	oLegenda:Add("","GREEN" ,   "Aberto"   	 )
	oLegenda:Add("","RED"   ,   "Encerrado"  )
	oLegenda:Add("","BLACK" ,   "Cancelado"  )

	oLegenda:Activate()
	oLegenda:View()
	oLegenda:Deactivate()
	FreeObj(oLegenda)

Return nil

/*/{Protheus.doc} CLMAKM
Verifica se o chamada nï¿½o estï¿½ Encerrada para alterar o conhecimento
@type function
@version 1.0.0 
@author Bryan Malheiros
@since 16/04/2025
@return variant, True ou False
/*/
User Function CLMAKM()
	Local nRecNo := Z17->(RecNo())

	If Z17->Z17_STATUS $ ('AEC')
		MsDocument("Z17", nRecNo, 4)
	Else
		MsDocument("Z17", nRecNo, 2)
	EndIf

Return nil

/*/{Protheus.doc} zCLMPRE
Pre validaï¿½ï¿½o dos dados no Model, se pode Alterar,Cancelar ou Excluir Chamado
@type function
@version 1.0.0 
@author helder
@since 12/17/2023
@return variant, Retorna valor logico True ou False
/*/
Static Function zVlPre()
	Local lRet          := .T.
	Local oModelPre     := FWModelActive()
	Local nOperation    := oModelPre:GetOperation()

    /*'Pesquisar' 1 / 'Visualizar' 2 / 'Incluir' 3 / 'Alterar' 4 / 'Excluir' 5 / 'Cancelar' 6 / 'Conhecimento' 7 / 'Imprimir' 8 / 'Legenda' 9 */
	If nOperation == 4
		If Z17->Z17_STATUS == 'E' //.and. !(cUserId $ cUsersID)

			lRet := .F.
			Help( , , 'Nï¿½o Permitido' , , 'O registro já está encerrado.', 1, 0, , , , , , {"Entre em contato com o setor de TI."})
	
		Elseif Z17->Z17_STATUS == 'C' 
			lRet := .F.
			Help( , , 'Nï¿½o Permitido' , , 'O registro já está cancelado.', 1, 0, , , , , , {"Entre em contato com o setor de TI."})
		
		EndIf
	EndIf

		If nOperation == 6
			If Z17->Z17_STATUS $ 'EC' //.and. !(cUserId $ cUsersID)

			lRet := .F.
			Help( , , 'Nï¿½o Permitido' , , 'O registro não pode ser cancelado.', 1, 0, , , , , , {"Entre em contato com o setor de TI."})
		EndIf

	EndIf
	/*
	If nOperation == 5
		If Z17->Z17_STATUS $ 'E' //.and. !(cUserId $ cUsersID)

			lRet := .F.
			Help( , , 'Nï¿½o Permitido' , , 'A gestï¿½o da frota nï¿½o pode ser excluida.', 1, 0, , , , , , {"Entre em contato com o setor de TI."})
		EndIf
	EndIf
	*/

Return lRet

/*/{Protheus.doc} zVlPos
Pï¿½s validaï¿½ï¿½o dos dados no Model, validaï¿½ï¿½o de patrimï¿½nio
@type function
@version 1.0.0
@author helder
@since 12/17/2023
@return variant, Retorna valor logico True ou False
/*/
Static Function zVlPos()
	Local lRet      := .T.
	Local oModelPos := FWModelActive()
	Local nOperation:= oModelPos:GetOperation()
	Local cNum  := oModelPos:GetValue("Z17MASTER","Z17_NUM")

	//Se for inclusï¿½o
	If nOperation == 3 .or. nOperation == 9
		//Se nï¿½o for o Administrador
		If MsSeek(xFilial("Z17") + cNum)
			lRet := .F.
			Help( , , 'Nï¿½o Permitido' , , 'Cï¿½digo de sequencia jï¿½ cadastrado!', 1, 0, , , , , , {"Entre em contato com o setor de TI."})
		EndIf
	EndIf

Return lRet

//Bibliotecas
#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'

//Variáveis Estáticas
Static cTitulo := "Controle de Equipamentos"

/*/{Protheus.doc} CLMATIVO
Função para controle de equipamentos
@type function
@author Bryan Malheiros
@since 14/04/2025
@version 1.0.0
@return character, Nulo
/*/
User Function CLMATIVO()
	Local aArea   := GetArea()
	Local oBrowse

	//Setando nome da função
	SetFunName("CLMATIVO")

	//Cria um browse para a Z15
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias("Z15")
	oBrowse:SetDescription(cTitulo)

	//Desabilitando os detalhes do Browse
	oBrowse:DisableDetails()

	oBrowse:AddLegend( "Z15->Z15_STATUS=='1'", "GREEN"  , "Estoque"     )
	oBrowse:AddLegend( "Z15->Z15_STATUS=='2'", "BLUE"   , "Em uso"      )
	oBrowse:AddLegend( "Z15->Z15_STATUS=='3'", "ORANGE" , "Manutencao"  )
	oBrowse:AddLegend( "Z15->Z15_STATUS=='4'", "RED"    , "Baixado"     )

	oBrowse:Activate()

	RestArea(aArea)

Return Nil

/*/{Protheus.doc} MenuDef
Montagem do menu de opções
@type function
@author Bryan Malheiros
@since 14/04/2025
@version 1.0.0
@return array, Array com as opções do menu
/*/
Static Function MenuDef()
	Local aRotina := {}

	//Adicionando opções
	ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.CLMATIVO' OPERATION MODEL_OPERATION_VIEW   ACCESS 0 //OPERATION 1
	ADD OPTION aRotina TITLE 'Incluir'      ACTION 'VIEWDEF.CLMATIVO' OPERATION MODEL_OPERATION_INSERT ACCESS 0 //OPERATION 3
	ADD OPTION aRotina TITLE 'Alterar'      ACTION 'VIEWDEF.CLMATIVO' OPERATION MODEL_OPERATION_UPDATE ACCESS 0 //OPERATION 4
	ADD OPTION aRotina TITLE 'Excluir'      ACTION 'VIEWDEF.CLMATIVO' OPERATION MODEL_OPERATION_DELETE ACCESS 0 //OPERATION 5
	ADD OPTION aRotina TITLE 'Copiar'       ACTION 'VIEWDEF.CLMATIVO' OPERATION 9 ACCESS 0
	ADD OPTION aRotina TITLE 'Legenda'      ACTION 'U_zATVLEG()'      OPERATION 6 ACCESS 0
	ADD OPTION aRotina TITLE 'Conhecimento' ACTION 'U_CLMATV()'       OPERATION 6 ACCESS 0

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
	Local oStruCab  := FWFormStruct(1, 'Z15')
	Local bVldPre   := {|| zVlPre()}
	Local bVldPos   := {|| zVlPos()}

	oModel := MPFormModel():New('CLMATVM', bVldPre, bVldPos, /*bCommit*/, /*bCancel*/ )

	oModel:AddFields('Z15MASTER', , oStruCab)

	oModel:SetDescription(cTitulo)

	oModel:SetPrimaryKey({"Z15_FILIAL", "Z15_PATRIM"})

	//Ativa o modelo
	oModel:SetVldActivate( { |oModel| fAlterar( oModel ) } )

Return oModel

/*/{Protheus.doc} ViewDef
Montagem da visualização em MVC
@type function
@author Bryan Malheiros
@since 14/04/2025
@version 1.0.0
@return object, Objeto da visualização
/*/
Static Function ViewDef()
	//Na montagem da estrutura da visualização de dados, vamos chamar o modelo criado anteriormente, no cabeçalho vamos mostrar somente 2 campos, e na grid vamos carregar conforme a função fViewStruct
	Local oView        := NIL
	Local oModel    := FWLoadModel('CLMATIVO')
	Local oStruCab  := FWFormStruct(2, "Z15")

	//Define que no cabeçalho não terá separação de abas (SXA)
	oStruCab:SetNoFolder()

	//Cria o View
	oView:= FWFormView():New()

	oView:SetModel(oModel)

	oView:AddField('VIEW_Z15', oStruCab, 'Z15MASTER')

	oView:CreateHorizontalBox("TELA", 100)

	oView:SetOwnerView('VIEW_Z15', 'TELA')

	oView:SetCloseOnOk({||.T.})

Return oView

/*/{Protheus.doc} fModStruct
Função chamada para montar o modelo de dados da Grid
@type function
@author Bryan Malheiros
@since 14/04/2025
@version 1.0.0
@return object, Estrutura do modelo de dados
/*/
Static Function fModStruct()
	Local oStruct
	oStruct := FWFormStruct(1, 'Z15')
Return oStruct

/*/{Protheus.doc} fViewStruct
Função para montar a estrutura do modelo de dados
@type function
@author Bryan Malheiros
@since 14/04/2025
@version 1.0.0
@return object, Estrutura do modelo de dados
/*/
Static Function fViewStruct()
	//Irá filtrar, e trazer todos os campos, menos os que tiverem na variável cCampoCom
	oStruct := FWFormStruct(2, "Z15")
Return oStruct

/*/{Protheus.doc} fAlterar
Define se pode abrir o Modelo de Dados
@type function
@version 1.0.0 
@author helder
@since 12/17/2023
@return variant, Retorna um valor lógico True ou False
/*/
Static Function fAlterar( oModel )
	Local lRet       := .T.
	Local nOperation := oModel:GetOperation()

	/*'Pesquisar' 1 / 'Visualizar' 2 / 'Incluir' 3 / 'Alterar' 4 / 'Excluir' 5 / 'Cancelar' 6 / 'Conhecimento' 7 / 'Imprimir' 8 / 'Legenda' 9 */
	//Se for exclusão
	If nOperation == 5
		If Z15->Z15_STATUS $ '234'
			lRet := .F.
			Help( , , 'Não Permitido' , , 'O equipamento não pode ser excluído!', 1, 0, , , , , , {"Entre em contato com o setor de TI."})
		EndIf
	EndIf

Return lRet

/*/{Protheus.doc} U_zATVLEG
Função para exibir legenda de status dos equipamentos
@type function
@author Bryan Malheiros
@since 14/04/2025
@version 1.0
@return character, Nulo
/*/
User Function zATVLEG()
	Local oLegenda as object

	oLegenda := FWLegend():New()

	//Monta as cores
	oLegenda:Add("","GREEN" ,   "Estoque"   )
	oLegenda:Add("","BLUE"  ,   "Em uso"    )
	oLegenda:Add("","ORANGE",   "Manutencao")
	oLegenda:Add("","RED"   ,   "Baixado"   )


	oLegenda:Activate()
	oLegenda:View()
	oLegenda:Deactivate()
	FreeObj(oLegenda)

Return nil

/*/{Protheus.doc} CLMATV
Verifica se o chamada não está Baixado para alterar o conhecimento
@type function
@version 1.0.0 
@author Bryan Malheiros
@since 16/04/2025
@return variant, True ou False
/*/
User Function CLMATV()
	Local nRecNo := Z15->(RecNo())

	If Z15->Z15_STATUS $ ('123')
		MsDocument("Z15", nRecNo, 4)
	Else
		MsDocument("Z15", nRecNo, 2)
	EndIf
Return nil

/*/{Protheus.doc} zCLMPRE
Pre validação dos dados no Model, se pode Alterar,Cancelar ou Excluir Chamado
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
		If Z15->Z15_STATUS == '4' //.and. !(cUserId $ cUsersID)

			lRet := .F.
			Help( , , 'Não Permitido' , , 'O equipamento já está Baixado.', 1, 0, , , , , , {"Entre em contato com o setor de TI."})
		EndIf

	EndIf

	If nOperation == 5
		If Z15->Z15_STATUS $ '234' //.and. !(cUserId $ cUsersID)

			lRet := .F.
			Help( , , 'Não Permitido' , , 'Equipamento nao pode ser excluido.', 1, 0, , , , , , {"Entre em contato com o setor de TI."})

		EndIf

	EndIf

Return lRet

/*/{Protheus.doc} zVlPos
Pós validação dos dados no Model, validação de patrimônio
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
	Local cNumPatr  := oModelPos:GetValue("Z15MASTER","Z15_PATRIM")

	//Se for inclusão
	If nOperation == 3 .or. nOperation == 9
		//Se não for o Administrador
		If MsSeek(xFilial("Z15") + cNumPatr)
			lRet := .F.
			Help( , , 'Não Permitido' , , 'Código de patrimônio já cadastrado!', 1, 0, , , , , , {"Entre com outro código de patrimônio."})
		EndIf
	EndIf

Return lRet

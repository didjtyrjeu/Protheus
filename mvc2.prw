//Bibliotecas
#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'

//Variáveis Estáticas
Static cTitulo := "Transferencia entre Unidades/Armazens Itens"

/*/{Protheus.doc} ClmTrUIt
Montagem da tela de Transferencia entre Unidades
@type function
@version 1.0.0 
@author Lucas Pinheiro
/*/ 
User Function ClmTrUIt()
    Local aArea   := GetArea()
    Local oBrowse 

    oBrowse := FWMBrowse():New()
    oBrowse:SetMenuDef( 'ClmTrUIt' )
    oBrowse:SetAlias("Z22")
    oBrowse:SetDescription(cTitulo)
    
    //Legendas
    oBrowse:AddLegend( "Z22_STATUS=='A'" , "GREEN"  , "Aberto"    )
    oBrowse:AddLegend( "Z22_STATUS=='P'" , "ORANGE" , "Pendente"  )
    oBrowse:AddLegend( "Z22_STATUS=='E'" , "RED"    , "Encerrado" )

    oBrowse:Activate()
       
    RestArea(aArea)
Return Nil
  
Static Function MenuDef()
    Local aRotina := {}
       
    // Importante: O ACTION deve ser VIEWDEF.NomeDoFonte
    ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.ClmTrUIt' OPERATION 2 ACCESS 0 
    ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.ClmTrUIt' OPERATION 3 ACCESS 0 
    ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.ClmTrUIt' OPERATION 4 ACCESS 0 
    ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.ClmTrUIt' OPERATION 5 ACCESS 0 
    ADD OPTION aRotina TITLE 'Legenda'    ACTION 'u_ClmLeg'         OPERATION 6 ACCESS 0

Return aRotina
  
Static Function ModelDef()
    Local oModel    := Nil
    // Estrutura do Cabeçalho (Filtra campos específicos)
    Local oStruCab  := FWFormStruct(1, 'Z22', {|cCampo| AllTRim(cCampo) $ "Z22_FILIAL;Z22_NUM;Z22_DTINI;Z22_CODUSR;Z22_NOMUSR;Z22_IDETI1;"})
    Local oStruGrid := fModStruct()
  
    oModel := MPFormModel():New('ClmTrUItM', /*bPre*/, {|oModel| fValidGrid(oModel)}, /*bPost*/, /*bCancel*/ )
  
    oModel:AddFields('FieldZ22', NIL, oStruCab)
    oModel:AddGrid('GridZ22', 'FieldZ22', oStruGrid)
  
    // Relacionamento Grid -> Cabeçalho
    oModel:SetRelation('GridZ22', {;
            {'Z22_FILIAL', 'xFilial("Z22")'},;
            {'Z22_NUM'   , 'Z22_NUM'       },;
            {'Z22_DTINI' , 'Z22_DTINI'     },;
            {'Z22_CODUSR', 'Z22_CODUSR'    },;
            {'Z22_NOMUSR', 'Z22_NOMUSR'    },;
            {'Z22_IDETI1', 'Z22_IDETI1'    },}, Z22->(IndexKey(2)))
            
    oModel:GetModel("GridZ22"):SetMaxLine(9999)
    oModel:SetDescription(cTitulo)
    
    // CORREÇÃO: SetPrimaryKey deve ser um Array de Strings, sem ";"
    oModel:SetPrimaryKey({"Z22_FILIAL", "Z22_NUM", "Z22_DTINI", "Z22_CODUSR", "Z22_NOMUSR", "Z22_IDETI1"})
  
Return oModel
  
Static Function ViewDef()
    Local oView      := Nil
    Local oModel     := FWLoadModel('ClmTrUIt')
    Local oStruCab   := FWFormStruct(2, "Z22", {|cCampo| AllTRim(cCampo) $ "Z22_FILIAL;Z22_NUM;Z22_DTINI;Z22_CODUSR;Z22_NOMUSR;Z22_IDETI1;"})
    Local oStruGRID  := fViewStruct()
  
    oView:= FWFormView():New() 
    oView:SetModel(oModel)              
  
    oView:AddField('VIEW_CAB', oStruCab, 'FieldZ22')
    oView:AddGrid('VIEW_GRID', oStruGRID, 'GridZ22')
  
    // CRIAÇÃO DOS BOXES - OBRIGATÓRIO PARA A TELA ABRIR
    oView:CreateHorizontalBox('TELA_TODA', 100)
    oView:CreateVerticalBox('BOX_CAB', 30, 'TELA_TODA')
    oView:CreateVerticalBox('BOX_GRID', 70, 'TELA_TODA')

    // AMARRAÇÃO DA VIEW AO BOX
    oView:SetOwnerView('VIEW_CAB', 'BOX_CAB')
    oView:SetOwnerView('VIEW_GRID', 'BOX_GRID')
  
Return oView

// Função para estrutura do Modelo da Grid
Static Function fModStruct()
    Local oStruGrid := FWFormStruct(1, 'Z22') 
    // Aqui você pode remover campos da grid se desejar com oStruGrid:RemoveField('CAMPO')
Return oStruGrid

// Função para estrutura da View da Grid
Static Function fViewStruct()
    Local oStruGrid := FWFormStruct(2, 'Z22')
Return oStruGrid

// Função de Validação (Exemplo simples para não dar erro)
Static Function fValidGrid(oModel)
    Local lRet := .T.
Return lRet

// Função de Legenda (Necessária pois está no MenuDef)
User Function ClmLeg()
    Local aLegenda := {}
    AAdd(aLegenda, {"BR_VERDE" , "Aberto"})
    AAdd(aLegenda, {"BR_LARANJA", "Pendente"})
    AAdd(aLegenda, {"BR_VERMELHO", "Encerrado"})
    BrwLegenda(cTitulo, "Legenda", aLegenda)
Return Nil
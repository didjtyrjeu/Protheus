#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

//-------------------------------------------------------------------
/*/{Protheus.doc} MARK_MVC
Exemplo de montagem da modelo e interface de marcacao para uma
tabela em MVC

@author PAULO BINDO
@since 05/11/2021
@version P12
/*/
//-------------------------------------------------------------------
User Function MARK_MVC()
Private oMark

oMark := FWMarkBrowse():New()
oMark:SetAlias('SZ1')
oMark:SetSemaphore(.T.)
oMark:SetDescription('Cadastro UM x Cliente')
oMark:SetFieldMark( 'Z1_OK' )
oMark:SetAllMark( { || oMark:AllMark() } )
oMark:AddLegend( "Z1_TIPO=='D'", "YELLOW", "Divide"       )
oMark:AddLegend( "Z1_TIPO=='M'", "BLUE"  , "Multiplica"  )
oMark:Activate()

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} MenuDef
MONTA MENU
@author PAULO BINDO
@since 05/11/2021
@version P12
/*/
//-------------------------------------------------------------------
Static Function MenuDef()
Local aRotina := {}

ADD OPTION aRotina TITLE 'Pesquisar'  ACTION 'PesqBrw'             OPERATION 1 ACCESS 0
ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.MARK_MVC'  OPERATION 2 ACCESS 0
ADD OPTION aRotina TITLE 'Marca Tudo' ACTION 'U_MARKTUDO()'      OPERATION 4 ACCESS 0
ADD OPTION aRotina TITLE 'Contar'     ACTION 'U_MARKPROC()'      OPERATION 2 ACCESS 0


Return aRotina


//-------------------------------------------------------------------
/*/{Protheus.doc} ModelDef
MONTA MODELO DE DADOS
@author PAULO BINDO
@since 05/11/2021
@version P12
/*/
//-------------------------------------------------------------------
Static Function ModelDef()
// Utilizo um model que ja existe
Return FWLoadModel( 'MOD1_MVC' )


//-------------------------------------------------------------------
/*/{Protheus.doc} ViewDef
MONTA TELA
@author PAULO BINDO
@since 05/11/2021
@version P12
/*/
//-------------------------------------------------------------------

Static Function ViewDef()
// Utilizo uma View que ja existe
Return FWLoadView( 'MOD1_MVC' )
 

//-------------------------------------------------------------------
/*/{Protheus.doc} MARKPROC
MARCA TODOS OS REGISTROS
@author PAULO BINDO
@since 05/11/2021
@version P12
/*/
//-------------------------------------------------------------------

User Function MARKTUDO()
Local aArea    := GetArea()
Local cMarca   := oMark:Mark()
Local lInverte := oMark:IsInvert()
Local nCt      := 0

SZ1->( dbGoTop() )
While !SZ1->( EOF() )
	If !oMark:IsMark(cMarca)
		nCt++
		    //Limpando a marca
            RecLock('SZ1', .F.)
                Z1_OK := cMarca
            SZ1->(MsUnlock())	
	else
		    //Limpando a marca
            RecLock('SZ1', .F.)
                Z1_OK := ""
            SZ1->(MsUnlock())	

	EndIf
	
	SZ1->( dbSkip() )
End

ApMsgInfo( 'Foram marcados ' + AllTrim( Str( nCt ) ) + ' registros.' )

RestArea( aArea )

Return NIL



//-------------------------------------------------------------------
/*/{Protheus.doc} MARK_MVC
CONTA TODOS OS REGISTROS MARCADOS
@author PAULO BINDO
@since 05/11/2021
@version P12
/*/
//-------------------------------------------------------------------
User Function MARKPROC()
Local aArea    := GetArea()
Local cMarca   := oMark:Mark()
Local lInverte := oMark:IsInvert()
Local nCt      := 0

SZ1->( dbGoTop() )
While !SZ1->( EOF() )
	If oMark:IsMark(cMarca)
		nCt++
	EndIf
	
	SZ1->( dbSkip() )
End

ApMsgInfo( 'Foram marcados ' + AllTrim( Str( nCt ) ) + ' registros.' )

RestArea( aArea )

Return NIL

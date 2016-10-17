#include "tbiconn.ch"
#include "protheus.ch"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEXECFUN   บAutor  ณJackson E. de Deus  บ Data ณ  21/11/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExecucao de funcoes ADVPL com tratamento de erros           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function EXECFUN()
 
Local oDlg
Local oFont := TFont():New('Arial',,-12,.T.,.T.)   
Local cProgram := Space(100)                    
Local aArea := GetArea()

If Empty(funName())
	prepare environment empresa "01" filial "01"
EndIf                  

oDlg := MSDialog():New( 0,0,200,300,"Execu็ใo de programas",,,.F.,,,,,,.T.,,,.T. )	

	oGet1 := TGet():New( 002,005,{ |u|If(Pcount()>0,cProgram:=u,cProgram) },oDlg,120,010,'@!',{ || },CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,,,,,,"Programa",1,oFont,CLR_BLACK)
	
	// tempo total execucao                                                                        
	oFunc := TSay():New( 030,005,{ || ""},oDlg,,oFont,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,300,015)
	oSTime := TSay():New( 050,005,{ || ""},oDlg,,oFont,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,300,015)
				
	oPanel2 := TPanelCss():New(0,0,"",oDlg,,.F.,.F.,,,0,020,.T.,.F.)
	cStyle := "Q3Frame{ border-style:solid; border-width:1px; border-color:#263238; background-color:#607d8b }"
	oPanel2:setCSS( cStyle ) 
	oPanel2:align := CONTROL_ALIGN_BOTTOM
	                                                                                                      
	oBtn1 := TBtnBmp2():New( 0, 0, 40, 40, 'OK'		, , , ,{ || Exec(cProgram) } , oPanel2, "Executar" , ,)
	oBtn2 := TBtnBmp2():New( 0, 0, 40, 40, 'CANCEL'	, , , ,{ || oDlg:End() } , oPanel2, "Sair" , ,)

	oBtn2:Align := CONTROL_ALIGN_RIGHT
	oBtn1:Align := CONTROL_ALIGN_RIGHT
	
oDlg:Activate(,,,.T.,,,)

If Empty(funName())
	Reset Environment  
EndIf

RestArea(aArea)

Return
      

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณExec  บAutor  ณJackson E. de Deus      บ Data ณ  21/11/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExecuta a funcao					                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function Exec(cProgram)

Local bError         := { |e| oError := e , Break(e) }
Local bErrorBlock    := ErrorBlock( bError )
Local oError
Local cHrIni := ""
Local cHrFim := ""
Local cHrTot := ""

cHrIni := Time()

BEGIN SEQUENCE
	Eval( &( "{||"+cProgram+"}" ) )  	
RECOVER
	MsgAlert( ProcName() +CRLF + Str(ProcLine()) +CRLF +oError:ErrorStack )            
	CONOUT( ProcName() +CRLF + Str(ProcLine()) +CRLF +oError:ErrorStack )            
END SEQUENCE

cHrFim := Time()
cHrTot := ElapTime(cHrIni,cHrFim)

oFunc:SetText("Fun็ใo: " +cProgram)
oSTime:SetText("Tempo total de execu็ใo: " +cHrTot)


Return
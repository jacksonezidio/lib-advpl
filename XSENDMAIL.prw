#include "protheus.ch"
#include 'Ap5Mail.ch'
#include "totvs.ch"

/*/{Protheus.doc} XSENDMAIL
// Funcao para envio de emails
@author Jackson Ezidio de Deus
@since 09/06/2015
@version 1.0
@return ${return}, ${return_description}
@param cFrom, characters, Remetente
@param cTo, characters, Destinatario
@param cSubject, characters, Assunto
@param cBody, characters, Corpo
@param aAttach, array, Anexos
@param lConfirm, logical, Confirmacao de leitura
@param cCC, characters, Copia
@param cBCC, characters, Copia oculta
@type function
/*/
User Function XSENDMAIL(cFrom,cTo,cSubject,cBody,aAttach,lConfirm,cCC,cBCC)

Local lRet			:= .F.
Local oServer
Local oMessage
Local cMailServer	:= ""
Local cSmtpServer	:= GETMV("MV_RELSERV")
Local cAccount		:= GETMV("MV_RELAUSR")
Local cPassword		:= GETMV("MV_RELAPSW")
Local lAuth			:= GETMV("MV_RELAUTH")
Local nMailPort		:= 0
Local nSmtpPort		:= 25
Local nI			:= 0
Local nErro			:= 0
Local cAttach		:= ""
Local cContent		:= ""
Default cFrom		:= ""
Default cTo			:= ""
Default cCC			:= ""
Default cBCC		:= ""
Default cSubject	:= ""
Default cBody		:= ""
Default aAttach		:= {}
Default lConfirm	:= .F.


If Empty(cFrom) .Or. Empty(cTo) .Or. Empty(cSubject)
	Conout("#XSENDMAIL: PARAMETROS DE ENTRADA INVALIDOS")
	Return lRet
EndIf

If Empty(cSmtpServer) .Or. Empty(cAccount) .Or. Empty(cPassword)
	Conout("#XSENDMAIL: ERRO NOS PARAMETROS DE CONFIGURACAO DO EMAIL -> REVISAR MV_RELSERV/MV_RELAUSR/MV_RELAPSW")
	Return lRet
EndIf

// Cria a conexão com o server STMP ( Envio de e-mail )
oServer := TMailManager():New()

oServer:Init( cMailServer, cSmtpServer, cAccount, cPassword, nMailPort, nSmtpPort )

// seta um tempo de time out com servidor de 1min
If oServer:SetSmtpTimeOut( 120 ) != 0
	Conout( "#XSENDMAIL: FALHA AO SETAR TIMEOUT" )
	Return lRet
EndIf

// realiza a conexao SMTP
If oServer:SmtpConnect() != 0
	Conout( "#XSENDMAIL: FALHA AO CONECTAR" )
	Return lRet
EndIf

// autentica no servidor SMTP
If lAuth
	nErro := oServer:SMTPAuth( cAccount, cPassword )
	If nErro != 0
		Conout( "#XSENDMAIL: ERRO AO AUTENTICAR -> ", oServer:GetErrorString( nErro ) )
		Return lRet
	EndIf
EndIf


// Apos a conexão, cria o objeto da mensagem
oMessage := TMailMessage():New()

// Limpa o objeto
oMessage:Clear()

// Popula com os dados de envio
oMessage:cFrom		:= cFrom
oMessage:cTo		:= cTo
oMessage:cCc		:= cCC
oMessage:cBcc		:= cBcc
oMessage:cSubject	:= cSubject
oMessage:cBody		:= cBody
oMessage:MsgBodyType( "text/html" )

// Adiciona um attach
For nI := 1 To Len(aAttach)
	cAttach := aAttach[nI][1]
	cContent := aAttach[nI][2]
	If File(cAttach)
		If oMessage:AttachFile( cAttach ) < 0
			Conout( "#XSENDMAIL: ERRO AO ATTACHAR O ARQUIVO" )
		Else
			//adiciona uma tag informando que é um attach e o nome do arq
			oMessage:AddAtthTag( cContent+";filename=" +cAttach )
		EndIf
	Else
		Conout( "#XSENDMAIL: ARQUIVO ANEXO NAO ENCONTRADO -> " +cAttach )
	EndIf
Next nI

// confirmacao de leitura
If lConfirm
	oMessage:SetConfirmRead( .T. )
EndIf

// Envia o e-mail
nErro := oMessage:Send( oServer )
If nErro <> 0
	Conout( "#XSENDMAIL: ERRO AO ENVIAR O EMAIL -> ", oServer:GetErrorString( nErro ) )
Else
	lRet := .T.
EndIf

// Desconecta do servidor
If oServer:SmtpDisconnect() != 0
	Conout( "#XSENDMAIL: ERRO AO DESCONECTAR DO SERVIDOR SMTP" )
EndIf

Return lRet
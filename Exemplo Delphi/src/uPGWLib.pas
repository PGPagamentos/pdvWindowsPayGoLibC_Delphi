//************************************************************************************
  {
     unit:   PGWLib
     Classe: TPGWLib

     Data de criação  : 20/05/2019
     Autor            :
     Descrição        : Classe contendo Todos os Metodos de Operabilidade
   }
//************************************************************************************
unit uPGWLib;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.StrUtils, system.AnsiStrings,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Types, System.TypInfo,uEnums, uLib;



Type


  //========================================================
  // Record que descreve cada membro da estrutura PW_GetData:
  //========================================================
     TPW_GetData = record
          wIdentificador : Word;
          bTipoDeDado : Byte;
          szPrompt: Array[0..83] of AnsiChar;
          bNumOpcoesMenu: Byte;
          vszTextoMenu: Array[0..39] of Array[0..40] of AnsiChar;
          vszValorMenu: Array[0..39] of Array[0..255] of AnsiChar;
          szMascaraDeCaptura: Array[0..40] of AnsiChar;
          bTiposEntradaPermitidos: Byte;
          bTamanhoMinimo: Byte;
          bTamanhoMaximo: Byte;
          ulValorMinimo : UInt32;
          ulValorMaximo : UInt32;
          bOcultarDadosDigitados: Byte;
          bValidacaoDado: Byte;
          bAceitaNulo: Byte;
          szValorInicial: Array[0..40] of AnsiChar;
          bTeclasDeAtalho: Byte;
          szMsgValidacao: Array[0..83] of AnsiChar;
          szMsgConfirmacao: Array[0..83] of AnsiChar;
          szMsgDadoMaior: Array[0..83] of AnsiChar;
          szMsgDadoMenor: Array[0..83] of AnsiChar;
          bCapturarDataVencCartao: Byte;
          ulTipoEntradaCartao: UInt32;
          bItemInicial: Byte;
          bNumeroCapturas: Byte;
          szMsgPrevia: Array[0..83] of AnsiChar;
          bTipoEntradaCodigoBarras: Byte;
          bOmiteMsgAlerta: Byte;
          bIniciaPelaEsquerda: Byte;
          bNotificarCancelamento: Byte;
          bAlinhaPelaDireita: Byte;
       end;

       PW_GetData = Array[0..10] of TPW_GetData;



       TPZ_GetData = record
            pszDataxx: Array[0..40] of AnsiChar;
       end;

       PSZ_GetData = Array[0..40] of TPZ_GetData;


       TPZ_GetDisplay = record
            szDspMsg: Array[0..127] of AnsiChar;
            szAux:    Array[0..1023] of AnsiChar;
            szMsgPinPad: Array[0..33] of AnsiChar;
       end;

       PSZ_GetDisplay = Array[0..100] of TPZ_GetDisplay;


  //====================================================================
  // Estrutura para armazenamento de dados para Tipos de Operação
  //====================================================================
     TPW_Operations = record
         bOperType: Byte;
         szText: Array[0..21] of char;
         szValue: Array[0..21] of char;
     end;

     PW_Operations = Array[0..9] of TPW_Operations;


 //====================================================================
 // Estrutura para armazenamento de dados para confirmação de transação
 //====================================================================
    TConfirmaData = record
        szReqNum: Array[0..10] of AnsiChar;
        szExtRef: Array[0..50] of AnsiChar;
        szLocRef: Array[0..50] of AnsiChar;
        szVirtMerch: Array[0..18] of AnsiChar;
        szAuthSyst: Array[0..20] of AnsiChar;
    end;

   ConfirmaData = Array[0..0] of TConfirmaData;


{   TConfirmaDataR = record
       szReqNum: Array[0..10] of AnsiChar;
   end;
   ConfirmaDataR = Array[0..0] of TConfirmaDataR;

   TConfirmaDataE = record
        szExtRef: Array[0..50] of AnsiChar;
   end;
   ConfirmaDataE = Array[0..0] of TConfirmaDataE;

   TConfirmaDataL = record
        szLocRef: Array[0..50] of AnsiChar;
   end;
   ConfirmaDataL = Array[0..0] of TConfirmaDataL;

   TConfirmaDataV = record
        szVirtMerch: Array[0..18] of AnsiChar;
   end;
   ConfirmaDataV = Array[0..0] of TConfirmaDataV;

   TConfirmaDataA = record
        szAuthSyst: Array[0..20] of AnsiChar;
   end;
   ConfirmaDataA = Array[0..0] of TConfirmaDataA;
 }


  TPGWLib = class
  //private
    { private declarations }
  protected
    { protected declarations }
  public


    constructor Create;
    Destructor  Destroy; Override; // declaração do metodo destrutor

    procedure GetVersao;

    function Count: Integer;

    function Init:Integer;

    function TestaInit(iparam:Integer):Integer;

    function Instalacao:Integer;

    function venda:Integer;

    function iExecGetData( vstGetData:PW_GetData; iNumParam:Integer):Integer;

    function ConfirmaTrasacao:integer;

    function GetParamConfirma():Integer;

  end;


  Const


    // Auxiliar
    PWINFO_AUTHMNGTUSER = '314159';
    PWINFO_POSID  = '60376';
    PWINFO_MERCHCNPJCPF = '20726059000179';
    PWINFO_DESTTCPIP = 'app.tpgw.ntk.com.br:17502';
    PWINFO_USINGPINPAD = '1';
    PWINFO_PPCOMMPORT = '0';





  //=====================================================================================*/
  //  Função Auxiliar
  //=====================================================================================*/
    function tbKeyIsDown(const Key: Integer):Boolean;

  //=====================================================================================*/
  // Parametros que devem ser informados obrigatoriamente a cada transação
  //=====================================================================================*/
    procedure AddMandatoryParams;


  //========================================================================================================================================
    { Esta função é utilizada para inicializar a biblioteca, e retorna imediatamente.
     Deve ser garantido que uma chamada dela retorne PWRET_OK antes de chamar qualquer outra função.

         Entradas:
         pszWorkingDir Diretório de trabalho (caminho completo, com final nulo) para uso exclusivo do Pay&Go Web

         Saídas: Nenhuma.

        Retorno: PWRET_OK .................................. Operação bem sucedida.
                 PWRET_WRITERR ....................... Falha de gravação no diretório informado.
                 PWRET_INVCALL ......................... Já foi efetuada uma chamada à função PW_iInit após o carregamento da biblioteca.
                 Outro ..................................Outro erro de execução (ver “10. Códigos de retorno”, página 78 do Manual).
                                                       Uma mensagem de erro pode ser obtida através da função PW_iGetResult (PWINFO_RESULTMSG).
    }
  //============================================================================================================================================
    function PW_iInit(pszWorkingDir:AnsiString):SmallInt; StdCall; External 'PGWebLib.dll';



  //=============================================================================================================================================
    { Esta função deve ser chamada para iniciar uma nova transação através do Pay&Go Web, e retorna imediatamente.

     Entradas:
     iOper Tipo de transação a ser realizada (PWOPER_xxx, conforme tabela).

     Saídas: Nenhuma

     Retorno:
               PWRET_OK .................................. Transação inicializada.
               PWRET_DLLNOTINIT ................... Não foi executado PW_iInit.
               PWRET_NOTINST ........................ É necessário efetuar uma transação de Instalação.
               Outro ................................ Outro erro de execução (ver “10. Códigos de retorno”, página 78 Manual).
                                                      Uma mensagem de erro pode ser obtida através da função PW_iGetResult (PWINFO_RESULTMSG).
    }
  //==============================================================================================================================================
    function PW_iNewTransac(iOper:byte):SmallInt; StdCall; External 'PGWebLib.dll';


  //=============================================================================================================================================
    {  Esta função é utilizada para alimentar a biblioteca com as informações da transação a ser realizada,
      e retorna imediatamente. Estas informações podem ser:
        - Pré-fixadas na Automação;
        - Capturadas do operador pela Automação antes do acionamento do Pay&Go Web;
        - Capturadas do operador após solicitação pelo Pay&Go Web (retorno PW_MOREDATA por PW_iExecTransac).


       Entradas:
       wParam Identificador do parâmetro (PWINFO_xxx, ver lista completa em “9. Dicionário de dados”, página 72).
       pszValue Valor do parâmetro (string ASCII com final nulo).

     Saídas: Nenhuma

     Retorno:
               PWRET_OK .................................. Parametro Acrescentado com sucesso.
               PWRET_INVPARAM .................... O valor do parâmetro é inválido
               PWRET_DLLNOTINIT ................... Não foi executado PW_iInit
               PWRET_TRNNOTINIT .................. Não foi executado PW_iNewTransac (ver página 14).
               PWRET_NOTINST ........................ É necessário efetuar uma transação de Instalação
               Outro ........................................... Outro erro de execução (ver “10. Códigos de retorno”, página 78). Uma
                                                                 mensagem de erro pode ser obtida através da função PW_iGetResult
                                                                 (PWINFO_RESULTMSG).
     }
  //==============================================================================================================================================
    function PW_iAddParam(wParam:SmallInt; szValue:AnsiString):Int16; StdCall; External 'PGWebLib.dll';


//=============================================================================================================================================
  {  Esta função tenta realizar uma transação através do Pay&Go Web, utilizando os parâmetros
    previamente definidos através de PW_iAddParam. Caso algum dado adicional precise ser informado,
    o retorno será PWRET_MOREDATA e o parâmetro pvstParam retornará informações dos dados que
    ainda devem ser capturados.

    Esta função, por se comunicar com a infraestrutura Pay&Go Web, pode demorar alguns segundos
    para retornar.


    Entradas:
      piNumParam Quantidade máxima de dados que podem ser capturados de uma vez, caso o retorno
      seja PW_MOREDATA. (Deve refletir o tamanho da área de memória apontada por
      pvstParam.) Valor sugerido: 9.

    Saídas:
      pvstParam  Lista e características dos dados que precisam ser informados para executar a transação.
      Consultar “8.Captura de dados” (página 65) para a descrição da estrutura
      e instruções para a captura de dados adicionais. piNumParam Quantidade de dados adicionais que precisam ser capturados
      (quantidade de ocorrências preenchidas em pvstParam

      Retorno:
          PWRET_OK .................................. Transação realizada com sucesso. Os resultados da transação devem ser obtidos através da função PW_iGetResult.
          PWRET_NOTHING ....................... Nada a fazer, fazer as validações locais necessárias e chamar a função PW_iExecTransac novamente.
          PWRET_MOREDATA ................... Mais dados são requeridos para executar a transação.
          PWRET_DLLNOTINIT ................... Não foi executado PW_iInit.
          PWRET_TRNNOTINIT .................. Não foi executado PW_iNewTransac (ver página 14).
          PWRET_NOTINST ........................ É necessário efetuar uma transação de Instalação.
          PWRET_NOMANDATORY ........... Algum dos parâmetros obrigatórios não foi adicionado (ver página 17).
          Outro ........................................... Outro erro de execução (ver “10. Códigos de retorno”, página 78 Manual).
                                                            Uma mensagem de erro pode ser obtida através da função PW_iGetResult (PWINFO_RESULTMSG).
   }
//=============================================================================================================================================
  function PW_iExecTransac(var pvstParam: PW_GetData; piNumParam : pointer) : Int16; stdCall; External 'PGWebLib.dll';




//=========================================================================================================*\
  {  Funcao     :  PW_iGetResult

     Descricao  :  Esta função pode ser chamada para obter informações que resultaram da transação efetuada,
                   independentemente de ter sido bem ou mal sucedida, e retorna imediatamente.

     Entradas   :  iInfo:	   Código da informação solicitada sendo requisitada (PWINFO_xxx, ver lista completa
                               em “9. Dicionário de dados”, página 36).
                   ulDataSize:	Tamanho (em bytes) da área de memória apontada por pszData. Prever um tamanho maior
                               que o máximo previsto para o dado solicitado.


     Saidas     :  pszData:	   Valor da informação solicitada (string ASCII com terminador nulo).

     Retorno    :  PWRET_OK	         Sucesso. pszData contém o valor solicitado.
                   PWRET_NODATA	   A informação solicitada não está disponível.
                   PWRET_BUFOVFLW 	O valor da informação solicitada não cabe em pszData.
                   PWRET_DLLNOTINIT	Não foi executado PW_iInit.
                   PWRET_TRNNOTINIT	Não foi executado PW_iNewTransac (ver página 10).
                   PWRET_NOTINST	   É necessário efetuar uma transação de Instalação.
                   Outro	            Outro erro de execução (ver “10. Códigos de retorno”, página 40). Uma mensagem
                                     de erro pode ser obtida através da função PW_iGetResult (PWINFO_RESULTMSG).
  }
//=========================================================================================================*/
  function PW_iGetResult(iInfo:Int16; var pszData: PSZ_GetData;   ulDataSize: UInt32):Int16; StdCall; External 'PGWebLib.dll';


//=========================================================================================================
{
 Funcao     :  PW_iConfirmation

 Descricao  :  Esta função informa ao Pay&Go Web o status final da transação em curso (confirmada ou desfeita).
               Consultar “7. Confirmação de transação” (página 28) para informações adicionais.

 Entradas   :  ulStatus:   	Resultado da transação (PWCNF_xxx, ver lista abaixo).
               pszReqNum:  	Referência local da transação, obtida através de PW_iGetResult (PWINFO_REQNUM).
               pszLocRef:  	Referência da transação para a infraestrutura Pay&Go Web, obtida através de PW_iGetResult (PWINFO_AUTLOCREF).
               pszExtRef:  	Referência da transação para o Provedor, obtida através de PW_iGetResult (PWINFO_AUTEXTREF).
               pszVirtMerch:	Identificador do Estabelecimento, obtido através de PW_iGetResult (PWINFO_VIRTMERCH).
               pszAuthSyst:   Nome do Provedor, obtido através de PW_iGetResult (PWINFO_AUTHSYST).

 Saidas     :  não há.

 Retorno    :  PWRET_OK	         O status da transação foi atualizado com sucesso.
               PWRET_DLLNOTINIT	Não foi executado PW_iInit.
               PWRET_NOTINST	   É necessário efetuar uma transação de Instalação.
               Outro	            Outro erro de execução (ver “10. Códigos de retorno”, página 40). Uma mensagem
                                 de erro pode ser obtida através da função PW_iGetResult (PWINFO_RESULTMSG).
}
//=========================================================================================================
  function PW_iConfirmation(ulResult:Uint32; pszReqNum: AnsiString; pszLocRef:AnsiString ; pszExtRef:AnsiString;
                                             pszVirtMerch:AnsiString; pszAuthSyst:AnsiString):Int16; StdCall; External 'PGWebLib.dll';


//=========================================================================================================*\
{   Funcao     :  PW_iIdleProc

    Descricao  :  Para o correto funcionamento do sistema, a biblioteca do Pay&Go Web precisa de tempos em tempos
                  executar tarefas automáticas enquanto não está realizando nenhuma transação a pedido da Automação.

    Entradas   :  não há.

    Saidas     :  não há.

    Retorno    :  PWRET_OK	         Operação realizada com êxito.
                  PWRET_DLLNOTINIT	Não foi executado PW_iInit.
                  PWRET_NOTINST	   É necessário efetuar uma transação de Instalação.
                  Outro	            Outro erro de execução (ver “10. Códigos de retorno”, página 40). Uma mensagem
                                    de erro pode ser obtida através da função PW_iGetResult (PWINFO_RESULTMSG).
}
//=========================================================================================================*/
  function PW_iIdleProc():Int16; StdCall; External 'PGWebLib.dll';




//=========================================================================================================
{
 Funcao     :  PW_iGetOperations

 Descricao  :  Esta função pode ser chamada para obter quais operações o Pay&Go WEB disponibiliza no momento,
               sejam elas administrativas, de venda ou ambas.

 Entradas   :              bOperType	      Soma dos tipos de operação a serem incluídos na estrutura de
                                             retorno (PWOPTYPE_xxx).
                           piNumOperations	Número máximo de operações que pode ser retornado. (Deve refletir
                                             o tamanho da área de memória apontada por pvstOperations).

 Saídas     :              piNumOperations	Número de operações disponíveis no Pay&Go WEB.
                           vstOperations	   Lista das operações disponíveis e suas características.


 Retorno    :  PWRET_OK	         Operação realizada com êxito.
               PWRET_DLLNOTINIT	Não foi executado PW_iInit.
               PWRET_NOTINST	   É necessário efetuar uma transação de Instalação.
               Outro	            Outro erro de execução (ver “10. Códigos de retorno”, página 40). Uma mensagem
                                 de erro pode ser obtida através da função PW_iGetResult (PWINFO_RESULTMSG).
}
//=========================================================================================================
  function PW_iGetOperations(bOperType:Byte; var vstOperatios: PW_Operations; piNumOperations:Int16):Int16; StdCall; External 'PGWebLib.dll';


//=========================================================================================================*\
  { Funcao     :  PW_iPPAbort

   Descricao  :  Esta função pode ser utilizada pela Automação para interromper uma captura de dados no PIN-pad
                 em curso, e retorna imediatamente.

   Entradas   :  não há.

   Saidas     :  não há.

   Retorno    :  PWRET_OK	         Operação interrompida com sucesso.
                 PWRET_PPCOMERR	   Falha na comunicação com o PIN-pad.
                 PWRET_DLLNOTINIT	Não foi executado PW_iInit.
                 Outro	            Outro erro de execução (ver “10. Códigos de retorno”, página 40). Uma mensagem
                                   de erro pode ser obtida através da função PW_iGetResult (PWINFO_RESULTMSG).
   }
//=========================================================================================================*/
  function PW_iPPAbort():Int16; StdCall; External 'PGWebLib.dll';




//=========================================================================================================*\
  { Funcao     :  PW_iPPEventLoop

   Descricao  :  Esta função deverá ser chamada em “loop” até que seja retornado PWRET_OK (ou um erro fatal). Nesse
                 “loop”, caso o retorno seja PWRET_DISPLAY o ponto de captura deverá atualizar o “display” com as
                 mensagens recebidas da biblioteca.

   Entradas   :  ulDisplaySize	Tamanho (em bytes) da área de memória apontada por pszDisplay.
                                Tamanho mínimo recomendado: 100 bytes.

   Saidas     :  pszDisplay	   Caso o retorno da função seja PWRET_DISPLAY, contém uma mensagem de texto
                                (string ASCII com terminal nulo) a ser apresentada pela Automação na interface com
                                o usuário principal. Para o formato desta mensagem, consultar “4.3.Interface com o
                                usuário”, página 8.

   Retorno    :  PWRET_NOTHING	   Nada a fazer, continuar aguardando o processamento do PIN-pad.
                 PWRET_DISPLAY	   Apresentar a mensagem recebida em pszDisplay e continuar aguardando o processamento do PIN-pad.
                 PWRET_OK	         Captura de dados realizada com êxito, prosseguir com a transação.
                 PWRET_CANCEL	   A operação foi cancelada pelo Cliente no PIN-pad (tecla [CANCEL]).
                 PWRET_TIMEOUT	   O Cliente não realizou a captura no tempo limite.
                 PWRET_FALLBACK	   Ocorreu um erro na leitura do cartão, passar a aceitar a digitação do número do cartão, caso já não esteja aceitando.
                 PWRET_PPCOMERR	   Falha na comunicação com o PIN-pad.
                 PWRET_DLLNOTINIT	Não foi executado PW_iInit.
                 PWRET_INVCALL	   Não há captura de dados no PIN-pad em curso.
                 Outro	            Outro erro de execução (ver “10. Códigos de retorno”, página 40). Uma mensagem
                                   de erro pode ser obtida através da função PW_iGetResult (PWINFO_RESULTMSG).
   }
//=========================================================================================================*/
  function PW_iPPEventLoop(var pszDisplay; ulDisplaySize:UInt32):Int16; StdCall; External 'PGWebLib.dll';

//=========================================================================================================*\
  { Funcao     :  PW_iPPGetCard

   Descricao  :  Esta função é utilizada para realizar a leitura de um cartão (magnético, com chip com contato,
                 ou sem contato) no PIN-pad.

   Entradas   :  uiIndex	Índice (iniciado em 0) do dado solicitado na última execução de PW_iExecTransac
                          (índice do dado no vetor pvstParam).

   Saidas     :  não há.

   Retorno    :  PWRET_OK	         Captura iniciada com sucesso, chamar PW_iPPEventLoop para obter o resultado.
                 PWRET_INVPARAM	   O valor de uiIndex informado não corresponde a uma captura de dados deste tipo.
                 PWRET_DLLNOTINIT	Não foi executado PW_iInit.
                 Outro	            Outro erro de execução (ver “10. Códigos de retorno”, página 40). Uma mensagem
                                   de erro pode ser obtida através da função PW_iGetResult (PWINFO_RESULTMSG).
   }
//=========================================================================================================*/
  function PW_iPPGetCard(uiIndex:UInt16):Int16; StdCall; External 'PGWebLib.dll';



//=========================================================================================================*\
  { Funcao     :  PW_iPPGetPIN

   Descricao  :  Esta função é utilizada para realizar a captura no PIN-pad da senha (ou outro dado criptografado)
                 do Cliente.

   Entradas   :  uiIndex	Índice (iniciado em 0) do dado solicitado na última execução de PW_iExecTransac
                          (índice do dado no vetor pvstParam).

   Saidas     :  não há.

   Retorno    :  PWRET_OK	         Captura iniciada com sucesso, chamar PW_iPPEventLoop para obter o resultado.
                 PWRET_INVPARAM	   O valor de uiIndex informado não corresponde a uma captura de dados deste tipo.
                 PWRET_DLLNOTINIT	Não foi executado PW_iInit.
                 Outro	            Outro erro de execução (ver “10. Códigos de retorno”, página 40). Uma mensagem
                                   de erro pode ser obtida através da função PW_iGetResult (PWINFO_RESULTMSG).
   }
//=========================================================================================================*/
  function PW_iPPGetPIN(uiIndex:UInt16):Int16; StdCall; External 'PGWebLib.dll';



//=========================================================================================================*\
  { Funcao     :  PW_iPPGetData

   Descricao  :  Esta função é utilizada para fazer a captura no PIN-pad de um dado não sensível do Cliente..

   Entradas   :  uiIndex	Índice (iniciado em 0) do dado solicitado na última execução de PW_iExecTransac
                          (índice do dado no vetor pvstParam).

   Saidas     :  nao ha.

   Retorno    :  PWRET_OK	         Captura iniciada com sucesso, chamar PW_iPPEventLoop para obter o resultado.
                 PWRET_INVPARAM	   O valor de uiIndex informado não corresponde a uma captura de dados deste tipo.
                 PWRET_DLLNOTINIT	Não foi executado PW_iInit.
                 Outro	            Outro erro de execução (ver “10. Códigos de retorno”, página 40). Uma mensagem
                                   de erro pode ser obtida através da função PW_iGetResult (PWINFO_RESULTMSG).
   }
//=========================================================================================================*/
  function PW_iPPGetData(uiIndex:UInt16):Int16; StdCall; External 'PGWebLib.dll';




//=========================================================================================================*\
  { Funcao     :  PW_iPPGoOnChip

   Descricao  :  Esta função é utilizada para realizar o processamento off-line (antes da comunicação com o Provedor)
                 de um cartão com chip no PIN-pad.

   Entradas   :  uiIndex	Índice (iniciado em 0) do dado solicitado na última execução de PW_iExecTransac
                          (índice do dado no vetor pvstParam).

   Saidas     :  não há.

   Retorno    :  PWRET_OK	         Captura iniciada com sucesso, chamar PW_iPPEventLoop para obter o resultado.
                 PWRET_INVPARAM	   O valor de uiIndex informado não corresponde a uma captura de dados deste tipo.
                 PWRET_DLLNOTINIT	Não foi executado PW_iInit.
                 Outro	            Outro erro de execução (ver “10. Códigos de retorno”, página 40). Uma mensagem
                                   de erro pode ser obtida através da função PW_iGetResult (PWINFO_RESULTMSG).
   }
//=========================================================================================================*/
  function PW_iPPGoOnChip(uiIndex:UInt16):Int16; StdCall; External 'PGWebLib.dll';



//=========================================================================================================*\
  { Funcao     :  PW_iPPFinishChip

   Descricao  :  Esta função é utilizada para finalizar o processamento on-line (após comunicação com o Provedor)
                 de um cartão com chip no PIN-pad.

   Entradas   :  uiIndex	Índice (iniciado em 0) do dado solicitado na última execução de PW_iExecTransac
                          (índice do dado no vetor pvstParam).

   Saidas     :  não há.

   Retorno    :  PWRET_OK	         Captura iniciada com sucesso, chamar PW_iPPEventLoop para obter o resultado.
                 PWRET_INVPARAM	   O valor de uiIndex informado não corresponde a uma captura de dados deste tipo.
                 PWRET_DLLNOTINIT	Não foi executado PW_iInit.
                 Outro	            Outro erro de execução (ver “10. Códigos de retorno”, página 40). Uma mensagem
                                   de erro pode ser obtida através da função PW_iGetResult (PWINFO_RESULTMSG).
   }
//=========================================================================================================*/
  function PW_iPPFinishChip(uiIndex:UInt16):Int16; StdCall; External 'PGWebLib.dll';




//=========================================================================================================*\
  { Funcao     :  PW_iPPConfirmData

   Descricao  :  Esta função é utilizada para obter do Cliente a confirmação de uma informação no PIN-pad.

   Entradas   :  uiIndex	Índice (iniciado em 0) do dado solicitado na última execução de PW_iExecTransac
                          (índice do dado no vetor pvstParam).

   Saidas     :  não há.

   Retorno    :  PWRET_OK	         Captura iniciada com sucesso, chamar PW_iPPEventLoop para obter o resultado.
                 PWRET_INVPARAM	   O valor de uiIndex informado não corresponde a uma captura de dados deste tipo.
                 PWRET_DLLNOTINIT	Não foi executado PW_iInit.
                 Outro	            Outro erro de execução (ver “10. Códigos de retorno”, página 40). Uma mensagem
                                   de erro pode ser obtida através da função PW_iGetResult (PWINFO_RESULTMSG).
   }
//=========================================================================================================*/
  function PW_iPPConfirmData(uiIndex:UInt16):Int16; StdCall; External 'PGWebLib.dll';



//=========================================================================================================*\
  { Funcao     :  PW_iPPRemoveCard

   Descricao  :  Esta função é utilizada para fazer uma remoção de cartão do PIN-pad.

   Entradas   :  não há.

   Saidas     :  não há.

   Retorno    :  PWRET_OK	         Captura iniciada com sucesso, chamar PW_iPPEventLoop para obter o resultado.
                 PWRET_INVPARAM	   O valor de uiIndex informado não corresponde a uma captura de dados deste tipo.
                 PWRET_DLLNOTINIT	Não foi executado PW_iInit.
                 Outro	            Outro erro de execução (ver “10. Códigos de retorno”, página 40). Uma mensagem
                                   de erro pode ser obtida através da função PW_iGetResult (PWINFO_RESULTMSG).
   }
//=========================================================================================================*/
  function PW_iPPRemoveCard():Int16; StdCall; External 'PGWebLib.dll';



//=========================================================================================================*\
  { Funcao     :  PW_iPPDisplay

   Descricao  :  Esta função é utilizada para apresentar uma mensagem no PIN-pad

   Entradas   :  pszMsg   Mensagem a ser apresentada no PIN-pad. O caractere ‘\r’ (0Dh) indica uma quebra de linha.

   Saidas     :  não há.

   Retorno    :  PWRET_OK	         Captura iniciada com sucesso, chamar PW_iPPEventLoop para obter o resultado.
                 PWRET_DLLNOTINIT	Não foi executado PW_iInit.
                 Outro	            Outro erro de execução (ver “10. Códigos de retorno”, página 40). Uma mensagem
                                   de erro pode ser obtida através da função PW_iGetResult (PWINFO_RESULTMSG).
   }
//=========================================================================================================*/
  function PW_iPPDisplay(const pszMsg:Char):Int16; StdCall; External 'PGWebLib.dll';



//=========================================================================================================*\
  { Funcao     :  PW_iPPWaitEvent

   Descricao  :  Esta função é utilizada para aguardar a ocorrência de um evento no PIN-pad.

   Entradas   :  não há.

   Saidas     :  pulEvent	         Evento ocorrido.

   Retorno    :  PWRET_OK	         Captura iniciada com sucesso, chamar PW_iPPEventLoop para obter o resultado.
                 PWRET_DLLNOTINIT	Não foi executado PW_iInit.
                 Outro	            Outro erro de execução (ver “10. Códigos de retorno”, página 40). Uma mensagem
                                   de erro pode ser obtida através da função PW_iGetResult (PWINFO_RESULTMSG).
   }
//=========================================================================================================*/
  function PW_iPPWaitEvent(pulEvent:UInt32):Int16; StdCall; External 'PGWebLib.dll';




//===========================================================================*\
  { Funcao   : PW_iPPGenericCMD

   Descricao  :  Realiza comando genérico de PIN-pad.

   Entradas   :  uiIndex	Índice (iniciado em 0) do dado solicitado na última execução de PW_iExecTransac
                          (índice do dado no vetor pvstParam).

   Saidas     :  Não há.

   Retorno    :  PWRET_xxx.
   }
//===========================================================================*/
  function PW_iPPGenericCMD(uiIndex:UInt16):Int16; StdCall; External 'PGWebLib.dll';



//===========================================================================*\
  { Funcao     : PW_iTransactionInquiry

   Descricao  :  Esta função é utilizada para realizar uma consulta de transações
                 efetuadas por um ponto de captura junto ao Pay&Go WEB.

   Entradas   :  pszXmlRequest	Arquivo de entrada no formato XML, contendo as informações
                                necessárias para fazer a consulta pretendida.
                 ulXmlResponseLen Tamanho da string pszXmlResponse.

   Saidas     :  pszXmlResponse	Arquivo de saída no formato XML, contendo o resultado da consulta
                                efetuada, o arquivo de saída tem todos os elementos do arquivo de entrada.

   Retorno    :  PWRET_xxx.
   }
//===========================================================================*/
  function PW_iTransactionInquiry (const pszXmlRequest:Char; pszXmlResponse:Char; ulXmlResponseLen:UInt32):Int16; StdCall; External 'PGWebLib.dll';



//=========================================================================================================*\
  { Funcao     :  PW_iGetUserData

   Descricao  :  Esta função é utilizada para obter um dado digitado pelo portador do cartão no PIN-pad.

   Entradas   :  uiMessageId : Identificador da mensagem a ser exibida como prompt para a captura.
                 bMinLen     : Tamanho mínimo do dado a ser digitado.
                 bMaxLen     : Tamanho máximo do dado a ser digitado.
                 iToutSec    : Tempo limite para a digitação do dado em segundos.

   Saídas     :  pszData     : Dado digitado pelo portador do cartão no PIN-pad.

   Retorno    :  PWRET_OK	         Operação realizada com êxito.
                 PWRET_DLLNOTINIT	Não foi executado PW_iInit.
                 PWRET_NOTINST	   É necessário efetuar uma transação de Instalação.
                 PWRET_CANCEL	   A operação foi cancelada pelo Cliente no PIN-pad (tecla [CANCEL]).
                 PWRET_TIMEOUT	   O Cliente não realizou a captura no tempo limite.
                 PWRET_PPCOMERR	   Falha na comunicação com o PIN-pad.
                 PWRET_INVCALL	   Não é possível capturar dados em um PIN-pad não ABECS.
                 Outro	            Outro erro de execução (ver “10. Códigos de retorno”, página 40). Uma mensagem
                                   de erro pode ser obtida através da função PW_iGetResult (PWINFO_RESULTMSG).
   }
//=========================================================================================================*/
  function PW_iPPGetUserData(uiMessageId:UInt16; bMinLen:Byte; bMaxLen:Byte; iToutSec:Int16; pszData:Char):Int16; StdCall; External 'PGWebLib.dll';




//=========================================================================================================*\
  { Funcao     :  PW_iPPGetPINBlock

   Descricao  :  Esta função é utilizada para obter o PIN block gerado a partir de um dado digitado pelo usuário no PIN-pad.

   Entradas   :  bKeyID	      : Índice da Master Key (para chave PayGo, utilizar o índice “12”).
                 pszWorkingKey	: Sequência 32 caracteres utilizados para a geração do PIN block (dois valores iguais digitados pelo usuário com duas pszWorkingKey diferentes irão gerar dois PIN block diferentes.
                 bMinLen	      : Tamanho mínimo do dado a ser digitado (a partir de 4).
                 bMaxLen     	: Tamanho máximo do dado a ser digitado.
                 iToutSec    	: Tempo limite para a digitação do dado em segundos.
                 pszPrompt	   : Mensagem de 32 caracteres (2 linhas com 16 colunas) para apresentação no momento do pedido do dado do usuário.


   Saídas     :  pszData        : PIN block gerado com base nos dados fornecidos na função combinados com o dado digitado pelo usuário no PIN-pad.

   Retorno    :  PWRET_OK	         Operação realizada com êxito.
                 PWRET_DLLNOTINIT	Não foi executado PW_iInit.
                 PWRET_NOTINST	   É necessário efetuar uma transação de Instalação.
                 PWRET_CANCEL	   A operação foi cancelada pelo Cliente no PIN-pad (tecla [CANCEL]).
                 PWRET_TIMEOUT	   O Cliente não realizou a captura no tempo limite.
                 PWRET_PPCOMERR	   Falha na comunicação com o PIN-pad.
                 Outro	            Outro erro de execução (ver “10. Códigos de retorno”, página 40).
   }
//=========================================================================================================*/
  function PW_iPPGetPINBlock(bKeyID:Byte; const pszWorkingKey:Char; bMinLen:Byte;
                                    bMaxLen:Byte; iToutSec:Int16; const pszPrompt:Char; pszData:Char):Int16; StdCall; External 'PGWebLib.dll';


//  end;




  //published
    { published declarations }
  //end;



implementation


uses Principal;


  var

    xpszData: Array[0..20] of char;
    iRetorno: SmallInt;
    PWRET_OK: SmallInt;
    vGetdataArray : PW_GetData;
    vstGetData : PW_GetData;
    vGetpszData : PSZ_GetData;

    vGetpszDisplay : PSZ_GetDisplay;
   	xNumParam : int16;
    xSzValue: AnsiString;
    pvstParam:PW_GetData;


    gstConfirmData: ConfirmaData;


{    gstConfirmDataR: ConfirmaDataR;
    gstConfirmDataE: ConfirmaDataE;
    gstConfirmDataL: ConfirmaDataL;
    gstConfirmDataV: ConfirmaDataV;
    gstConfirmDataA: ConfirmaDataA;
}


    iNumParam: Int16;
    iRet: Int16;


    PWEnums : TCEnums;




//============================================================================
  {
    Busca Parametros para confirmação automatica da Ultima Transação de Venda.
  }
//============================================================================
function TPGWLib.GetParamConfirma: Integer;
var
  I:Integer;

begin

      iRetorno := PW_iGetResult(PWEnums.PWINFO_REQNUM, vGetpszData, SizeOf(vGetpszData));
      for I := 0 to 10 do
        begin
          gstConfirmData[0].szReqNum[I] := vGetpszData[0].pszDataxx[I];
        end;

      iRetorno := PW_iGetResult(PWEnums.PWINFO_AUTEXTREF, vGetpszData, SizeOf(vGetpszData));
      for I := 0 to 50 do
        begin
          gstConfirmData[0].szExtRef[I] := vGetpszData[0].pszDataxx[I];
        end;

      iRetorno := PW_iGetResult(PWEnums.PWINFO_AUTLOCREF, vGetpszData, SizeOf(vGetpszData));
      for I := 0 to 50 do
        begin
          gstConfirmData[0].szLocRef[I] := vGetpszData[0].pszDataxx[I];
        end;

      iRetorno := PW_iGetResult(PWEnums.PWINFO_VIRTMERCH, vGetpszData, SizeOf(vGetpszData));
      for I := 0 to 18 do
        begin
          gstConfirmData[0].szVirtMerch[I] := vGetpszData[0].pszDataxx[I];
        end;

      iRetorno := PW_iGetResult(PWEnums.PWINFO_AUTHSYST, vGetpszData, SizeOf(vGetpszData));
      for I := 0 to 20 do
        begin
          gstConfirmData[0].szAuthSyst[I] := vGetpszData[0].pszDataxx[I];
        end;


      Result := iRetorno;


end;

procedure  TPGWLib.GetVersao();
var
    iParam : Int16;
    Volta : String;
    vRetorno: Integer;
    winfo:Integer;
    wvolta: PChar;
    wxyvolta : string;
    xNumParam : integer;
begin


    PPrincipal.Memo1.Lines.Clear;
    PPrincipal.Memo1.Visible := False;



    xNumParam := 10;

    //AddMandatoryParams();
    winfo := PWEnums.PWINFO_RESULTMSG;

    // Nova Transação para PWOPER_VERSION
    iparam := PW_iNewTransac(PWEnums.PWOPER_VERSION);

    // Executa Transação
    vRetorno := PW_iExecTransac(vGetdataArray, @xNumParam);
    // Captura Informação
    iRet := PW_iGetResult(winfo, vGetpszData, SizeOf(vGetpszData));
    wxyvolta := vGetpszData[0].pszDataxx;
    Application.MessageBox(PChar(wxyvolta),'Versão da DLL',mb_OK+mb_IconInformation);

    PPrincipal.Label1.Visible := False;
    Application.ProcessMessages;



end;



{ TPGWLib }



//=====================================================================================
  {
   Funcao     :  ConfirmaTransacao

   Descricao  : Esta função informa ao Pay&Go Web o status final da transação
                em curso (confirmada ou desfeita).Confirmação de transação”
 }
//=====================================================================================*/
function TPGWLib.ConfirmaTrasacao: integer;
var
  strTagNFCe : String;
  strTagOP   : AnsiString;
  falta : string;
  iRet : Integer;
  iRetorno : Integer;
  ulStatus:Integer;
  Menu:Byte;
  Volta : String;
  winfo:Integer;
  I:Integer;
  iRetI:Integer;
  Cont:string;
  tamanho:Integer;
  passou:Integer;
  testeNum: Array[0..10] of Char;

begin



  {

      Descrição das Confirmações:

   ' 1 - PWCNF_CNF_AUT         A transação foi confirmada pelo Ponto de Captura, sem intervenção do usuário '
   ' 2 - PWCNF_CNF_MANU_AUT    A transação foi confirmada manualmente na Automação
   ' 3 - PWCNF_REV_MANU_AUT    A transação foi desfeita manualmente na Automação
   ' 4 - PWCNF_REV_PRN_AU      A transação foi desfeita pela Automação, devido a uma falha na impressão
                                 do comprovante (não fiscal). A priori, não usar.
                                 Falhas na impressão não devem gerar desfazimento,
                                 deve ser solicitada a reimpressão da transaçã '
   ' 5 - PWCNF_REV_DISP_AUT    A transação foi desfeita pela Automação, devido a uma falha no
                                 mecanismo de liberação da mercadoria
   ' 6 - PWCNF_REV_COMM_AUT    A transação foi desfeita pela Automação, devido a uma falha de
                                 comunicação/integração com o ponto de captura (Cliente Pay&Go Web'
   ' 7 - PWCNF_REV_ABORT       A transação não foi finalizada, foi interrompida durante a captura de dados'
   ' 8 - PWCNF_REV_OTHER_AUT   A transação foi desfeita a pedido da Automação, por um outro motivo não previsto.
   ' 9 - PWCNF_REV_PWR_AUT     A transação foi desfeita automaticamente pela Automação,
                                 devido a uma queda de energia (reinício abrupto do sistema).
   '10 - PWCNF_REV_FISC_AUT    A transação foi desfeita automaticamente pela Automação,
                                 devido a uma falha de registro no sistema fiscal (impressora S@T, on-line, etc.).
}



   falta :=
   ' 1 - PWCNF_CNF_AUT       '  + chr(13) +
   ' 2 - PWCNF_CNF_MANU_AUT  '  + chr(13) +
   ' 3 - PWCNF_REV_MANU_AUT  '  + chr(13) +
   ' 4 - PWCNF_REV_PRN_AU    '  + chr(13) +
   ' 5 - PWCNF_REV_DISP_AUT  '  + chr(13) +
   ' 6 - PWCNF_REV_COMM_AUT  '  + chr(13) +
   ' 7 - PWCNF_REV_ABORT     '  + chr(13) +
   ' 8 - PWCNF_REV_OTHER_AUT '  + chr(13) +
   ' 9 - PWCNF_REV_PWR_AUT   '  + chr(13) +
   '10 - PWCNF_REV_FISC_AUT  '  + chr(13);



    StrTagNFCe:= vInputBox('Escolha Confirmação: ',falta,'',550,220);
    Menu := StrToInt(strTagNFCe);



    case Menu of

         1:
           begin
             ulStatus := PWEnums.PWCNF_CNF_AUTO;
           end;

         2:
           begin
            ulStatus  := PWEnums.PWCNF_CNF_MANU_AUT;
           end;
         3:
           begin
            ulStatus := PWEnums.PWCNF_REV_MANU_AUT;
           end;
         4:
           begin
            ulStatus := PWEnums.PWCNF_REV_DISP_AUT;
           end;

         5:
           begin
            ulStatus := PWEnums.PWCNF_REV_DISP_AUT;
           end;

         6:
           begin
            ulStatus := PWEnums.PWCNF_REV_COMM_AUT;
           end;

         7:
           begin
            ulStatus := PWEnums.PWCNF_REV_ABORT;
           end;

         8:
           begin
            ulStatus := PWEnums.PWCNF_REV_OTHER_AUT;
           end;

         9:
           begin
            ulStatus := PWEnums.PWCNF_REV_PWR_AUT;
           end;

         10:
           begin
            ulStatus := PWEnums.PWCNF_REV_FISC_AUT;
           end;


    end;



     falta := '0 - Confirmar Ultima Transação ' + chr(13) +
              '1 - Informar Dados Manualmente ';

     while (X < 5) do
     begin

          strTagNFCe:= vInputBox('Escolha Opção: ',falta,'',550,220);

          if  (StrToInt(strTagNFCe) = 0) or (StrToInt(strTagNFCe) = 1)  then
               begin
                 Break;
               end
          else
               begin
                 ShowMessage('Opção Invalida');
                 Continue
               end;


     end;




    if (strTagNFCe = '1') then
       begin

          falta := '';

          strTagOP:= vInputBox('Digite valor de PWINFO_REQNUM: ',falta,'',550,220);
          StrLCopy(@gstConfirmData[0].szReqNum, PChar(strTagOP), SizeOf(gstConfirmData[0].szReqNum));        // 11

          strTagOP:= vInputBox('Digite valor de PWINFO_AUTLOCREF: ',falta,'',550,220);
          StrLCopy(@gstConfirmData[0].szLocRef, PChar(strTagOP), SizeOf(gstConfirmData[0].szLocRef));      //11

          strTagOP:= vInputBox('Digite valor de PWINFO_AUTEXTREF: ',falta,'',550,220);
          StrLCopy(@gstConfirmData[0].szExtRef, PChar(strTagOP), SizeOf(gstConfirmData[0].szExtRef));   // 50

          strTagOP:= vInputBox('Digite valor de PWINFO_VIRTMERCH: ',falta,'',550,220);
          StrLCopy(@gstConfirmData[0].szVirtMerch, PChar(strTagOP), SizeOf(gstConfirmData[0].szVirtMerch));  // 18

          strTagOP:= vInputBox('Digite valor de PWINFO_AUTHSYST: ',falta,'',550,220);
          StrLCopy(@gstConfirmData[0].szAuthSyst, PChar(strTagOP), SizeOf(gstConfirmData[0].szAuthSyst));  // 20

       end
    else
       begin
         GetParamConfirma();
       end;



    iRet := PW_iConfirmation(ulStatus, gstConfirmData[0].szReqNum,gstConfirmData[0].szLocRef,gstConfirmData[0].szExtRef,gstConfirmData[0].szVirtMerch,gstConfirmData[0].szAuthSyst);


    if (iRet <> PWRET_OK) then
       begin


          // Verifica se Foi inicializada a biblioteca
          if (iRet = PWEnums.PWRET_DLLNOTINIT)  then
              begin
                  iRetorno := PW_iGetResult(PWEnums.PWINFO_RESULTMSG, vGetpszData, SizeOf(vGetpszData));
                  Volta := vGetpszData[0].pszDataxx;
                  if (PPrincipal.Memo1.Visible = False) then
                     begin
                       PPrincipal.Memo1.Visible := True;
                     end;
                       PPrincipal.Memo1.Lines.Add(Volta);
                       PPrincipal.Memo1.Lines.Add(' ');
              end;

          // verifica se foi feito instalação
          if (iRet = PWEnums.PWRET_NOTINST)  then
              begin
                  iRetorno := PW_iGetResult(PWEnums.PWINFO_RESULTMSG, vGetpszData, SizeOf(vGetpszData));
                  Volta := vGetpszData[0].pszDataxx;
                  if (PPrincipal.Memo1.Visible = False) then
                     begin
                       PPrincipal.Memo1.Visible := True;
                     end;
                       PPrincipal.Memo1.Lines.Add(Volta);
                       PPrincipal.Memo1.Lines.Add(' ');
              end;


              // Verificar Outros erros

              Exit;

       end;





    iRetorno := PW_iGetResult(PWEnums.PWINFO_RESULTMSG, vGetpszData, SizeOf(vGetpszData));
    volta := vGetpszData[0].pszDataxx;



    if (PPrincipal.Memo1.Visible = False) then
       begin
         PPrincipal.Memo1.Visible := True;
       end;
      PPrincipal.Memo1.Lines.Add(Volta);
      PPrincipal.Memo1.Lines.Add(' ');





end;

function TPGWLib.Count: Integer;
begin

end;

constructor TPGWLib.Create;
begin

 inherited Create;
  PWEnums := TCEnums.Create

end;

destructor TPGWLib.Destroy;
begin
  inherited;
end;



//=====================================================================================
  {
   Funcao     :  AddMandatoryParams

   Descricao  :  Esta função adiciona os parâmetros obrigatórios de toda mensagem para o
                 Pay&Go Web.
  }
//=====================================================================================*/
procedure AddMandatoryParams;
begin

  PW_iAddParam(PWEnums.PWINFO_AUTDEV,PWEnums.PGWEBLIBTEST_AUTDEV);
  PW_iAddParam(PWEnums.PWINFO_AUTVER, PWEnums.PGWEBLIBTEST_VERSION);
  PW_iAddParam(PWEnums.PWINFO_AUTNAME, PWEnums.PGWEBLIBTEST_AUTNAME);
  PW_iAddParam(PWEnums.PWINFO_AUTCAP, PWEnums.PGWEBLIBTEST_AUTCAP);
  PW_iAddParam(PWEnums.PWINFO_AUTHTECHUSER, PWEnums.PGWEBLIBTEST_AUTHTECHUSER);

end;


//=====================================================================================*\
  {
     function  :  Init

     Descricao  :  Captura os dados necesários e executa PW_iInit.

     Sugestão de Pasta C:\PAYGO (Deve ser Criada)
     "." Gera as Pastas de Dados e Log no Raiz da Aplicação.

  }
//=====================================================================================*/
   function TPGWLib.Init:Integer;
    var
      StrTagNFCe: string;
      Volta : String;
      iRet:Integer;
      iParam : Int16;
      iretornar:integer;
    begin

        StrTagNFCe:= InputBox('Pasta', 'Informe Diretorio:', 'c:\PAYGO');
        iRetornar := PW_iInit(StrTagNFCe);

        if (iRetornar = PWEnums.PWRET_WRITERR)  then
            begin
                iRet := PW_iGetResult(PWEnums.PWINFO_RESULTMSG, vGetpszData, SizeOf(vGetpszData));
                Volta := vGetpszData[0].pszDataxx;
                Application.MessageBox(PChar(Volta),'Erro',mb_OK+mb_IconInformation);
            end;


        Result := iRetornar;

   end;



//=====================================================================================*\
  {
     function  :  Instalacao

     Descricao  :  Instalação de um Ponto de Captura.

  }
//=====================================================================================*/
function TPGWLib.Instalacao: Integer;
var
    szAux: Char;
    StrTagNFCe: string;
    StrValorTagNFCe: AnsiString;
    msg: AnsiString;
    pszData:Char;
    iParam : Int16;
    Volta : String;
    xxxparam: SmallInt;
    I:integer;
    comando: array[0..39] of Char;
    winfo:Integer;
    falta:string;
    iRet:Integer;
    iRetErro : integer;
begin


         //===============================================
         // Evento de Instalação
         //===============================================


         //===============================================
         // Nova Transação - Instalação
         //===============================================
          iparam := PW_iNewTransac(PWEnums.PWOPER_INSTALL);


         //===============================================
         // Testa se Biblioteca foi Inicializada - PWInit
         //===============================================
            iRet := TestaInit(iparam);
            if (iRet <> PWRET_OK) then
               begin
                 Exit;
               end;



         // OK - Continua




           I := 0;

        //=====================================================
        //  Loop Para Capturar Dados e executar Transação
        //=====================================================
        while I < 10 do
        begin

            // Dados Obrigatórios
            AddMandatoryParams;

            // inicializar sempre com 10
            xNumParam := 10;
            // Executa Transação
            iRet := PW_iExecTransac(vGetdataArray, @xNumParam);
            // caso exista Dados faltantes
            if (iRet = PWEnums.PWRET_MOREDATA) then
              begin
                 iRetErro := iExecGetData(vGetdataArray,xNumParam);
              end
            else
              begin
                PPrincipal.Label1.Visible := False;
                Exit;
              end;

            I := I+1;

        end;




end;

//=====================================================================================
  {
     Função Auxiliar. "não esta sendo usada no momento"
  }
//======================================================================================
function tbKeyIsDown(const Key: Integer): Boolean;
begin
   Result := GetKeyState(Key) and 128 > 0;
end;


//=====================================================================================*\
  {
     function  :  TestaInit

     Descricao  :  Verifica se PW_iInit já foi executado.

     Entradas   :  Resultado da Operação

     Saidas     :  nao ha.

     Retorno    :  Código de resultado da operação.

  }
//=====================================================================================*/
function TPGWLib.TestaInit(iparam:Integer): Integer;
var
    //iParam : Int16;
    Volta : String;
    iRet:Integer;
begin

     if (iParam = PWEnums.PWRET_DLLNOTINIT)  then
        begin
            iRet := PW_iGetResult(PWEnums.PWINFO_RESULTMSG, vGetpszData, SizeOf(vGetpszData));
            Volta := vGetpszData[0].pszDataxx;
//            Application.MessageBox(PChar(Volta),'Erro',mb_OK+mb_IconInformation);

            if (PPrincipal.Memo1.Visible = False) then
               begin
                 PPrincipal.Memo1.Visible := True;
               end;
            PPrincipal.Memo1.Lines.Add(Volta);
            PPrincipal.Memo1.Lines.Add(' ');


            Result := iParam;
        end
        else
        begin
          Result := PWEnums.PWRET_OK;
        end;


end;


//=====================================================
  {
      Executa Nova Transaçao de Venda  PWEnums.PWOPER_SALE
  }
//=====================================================
function TPGWLib.venda: Integer;
var
    iParam : Integer;
    Volta : String;
    iRet:Integer;
    iRetI: Integer;
    iRetErro : integer;
    strNome : String;
    I:Integer;
    xloop:integer;
    voltaA:AnsiChar;

begin


        I := 0;

        iRet := PW_iNewTransac(PWEnums.PWOPER_SALE);

        if (iRet <> PWRET_OK) then
           begin


              // Verifica se Foi inicializada a biblioteca
              if (iRet = PWEnums.PWRET_DLLNOTINIT)  then
                  begin
                      iRetErro := PW_iGetResult(PWEnums.PWINFO_RESULTMSG, vGetpszData, SizeOf(vGetpszData));
                      Volta := vGetpszData[0].pszDataxx;
                      if (PPrincipal.Memo1.Visible = False) then
                         begin
                           PPrincipal.Memo1.Visible := True;
                         end;
                           PPrincipal.Memo1.Lines.Add(Volta);
                           PPrincipal.Memo1.Lines.Add(' ');
                           //Application.MessageBox(PChar(Volta),'Erro',mb_OK+mb_IconInformation);
                  end;

              // verifica se foi feito instalação
              if (iRet = PWEnums.PWRET_NOTINST)  then
                  begin
                      iRetErro := PW_iGetResult(PWEnums.PWINFO_RESULTMSG, vGetpszData, SizeOf(vGetpszData));
                      Volta := vGetpszData[0].pszDataxx;
                      if (PPrincipal.Memo1.Visible = False) then
                         begin
                           PPrincipal.Memo1.Visible := True;
                         end;
                           PPrincipal.Memo1.Lines.Add(Volta);
                           PPrincipal.Memo1.Lines.Add(' ');
                  end;


                  // Verificar Outros erros

                  Exit;

           end;




        AddMandatoryParams;  // Parametros obrigatórios


        //=====================================================
        //  Loop Para Capturar Dados e executar Transação
        //=====================================================
        while I < 100 do
        begin

            // Coloca o valor 10 (tamanho da estrutura de entrada) no parâmetro iNumParam
            xNumParam := 10;



            // Tenta executar a transação
            if(iRet <> PWEnums.PWRET_NOTHING) then
              begin
                //ShowMessage('Processando...');
              end;

            iRet := PW_iExecTransac(vGetdataArray, @xNumParam);
            if (iRet = PWEnums.PWRET_MOREDATA) then
              begin

                 // Tenta capturar os dados faltantes, caso ocorra algum erro retorna
                 iRetErro := iExecGetData(vGetdataArray,xNumParam);
                 if (iRetErro <> 0) then
                    begin
                      Exit;
                    end
                 else
                    begin
                      I := I+1;
                      Continue;
                    end;

              end
            else
              begin




                   // Guardar Informações para Confirmação e Mostrar no finanl da transação:

                      {
                      GetParamConfirma();

                      ShowMessage('ReqNum: ' + gstConfirmData[0].szReqNum);
                      ShowMessage('Extref: ' + gstConfirmData[0].szExtRef);
                      ShowMessage('Locref: ' + gstConfirmData[0].szLocRef);
                      ShowMessage('VirtMerch: ' + gstConfirmData[0].szVirtMerch);
                      ShowMessage('AuthSyst: ' + gstConfirmData[0].szAuthSyst);
                      }



                  if(iRet = PWEnums.PWRET_NOTHING) then
                    begin
                      I := I+1;
                      Continue;
                    end
                  else
                    begin
                      Break;
                    end;

              end;


        end;




end;

//=====================================================================================*\
  { Funcao     :  iExecGetData

     Descricao  :  Esta função obtém dos usuários os dados requisitado pelo Pay&Go Web.

     Entradas   :  vstGetData  :  Vetor com as informações dos dados a serem obtidos.
                   iNumParam   :  Número de dados a serem obtidos.

     Saidas     :  nao ha.

     Retorno    :  Código de resultado da operação.
   }
//=====================================================================================*/
function TPGWLib.iExecGetData( vstGetData:PW_GetData; iNumParam:Integer):Integer;
var
  I : integer;
  StrTagNFCe: string;
  falta:string;
  iRet:Integer;
  iRetErro : integer;
  Volta : String;
  strNome:string;
  xloop: integer;
  ulEvent:UInt32;
  x:integer;

begin



               ulEvent := 0;
               I := 0;


              //==========================================================
              // Loop Para Capturar e Adicionar dados solicitados pela DLL.
              // Enquanto houverem dados para capturar
              //==========================================================
              while I < iNumParam do

                begin



                     case (vstGetData[I].bTipoDeDado) of

                       // Dados de Menu

                       PWEnums.PWDAT_MENU:

                             begin



                                 falta := vstGetData[I].szPrompt + chr(13);
                                 falta := falta + ' ' + chr(13);

                                 x := 0;

                                 while (X < vstGetData[I].bNumOpcoesMenu) do
                                     begin

                                        falta := falta + IntToStr(x) + ' - ' + vstGetData[I].vszTextoMenu[x] + chr(13);

                                        x := x+1;
                                     end;



                                 strNome := vInputBox('Selecione Opção', falta, '',550,340);
                                 // Busca Código Referente em vszValorMenu
                                 strNome := vstGetData[I].vszValorMenu[StrToInt(strNome)];
                                 iRet := PW_iAddParam(vstGetData[I].wIdentificador,strNome);
                                 if (iRet = PWEnums.PWRET_OK) then
                                    begin
                                      Result := PWRET_OK;
                                    end
                                 else
                                    begin
                                      Result := iRet;
                                    end;

                                 Break;

                             end;



                       // Entrada Digitada

                       PWEnums.PWDAT_TYPED:
                             begin


                               falta := vstGetData[I].szPrompt;

                               x := 0;

                               while (X < 5) do
                                   begin

                                       StrTagNFCe:= vInputBox('Informar: ',falta,'',550,340);

                                       if (Length(StrTagNFCe) > vstGetData[I].bTamanhoMaximo) then
                                          begin
                                              ShowMessage('Valor Maior que Tamanho Maximo');
                                              Continue;
                                          end;

                                       if (Length(StrTagNFCe) < vstGetData[I].bTamanhoMinimo) then
                                          begin
                                              ShowMessage('Valor Menor que Tamanho Minimo');
                                              Continue;
                                          end;

                                       if (vstGetData[I].bValidacaoDado = 1) then
                                          begin
                                           if (StrToIntDef(StrTagNFCe,0) = 0) then
                                              begin
                                                ShowMessage('Informar Somente Numeros');
                                                Continue;
                                              end;
                                          end;


                                          iRet := PW_iAddParam(vstGetData[I].wIdentificador,StrTagNFCe);
                                          if (iRet <> 0) then
                                             begin
                                                ShowMessage('Erro ao Adicionar Parametros');
                                                Result := iRet;
                                                Exit;
                                              end
                                          else
                                              begin
                                                Result := PWEnums.PWRET_OK;
                                                Break;
                                              end;

                                   end;


                              I := I+1;

                              continue;


                             end;


                       // Dados do Cartão

                       PWEnums.PWDAT_CARDINF:
                             begin

                             if(vstGetData[I].ulTipoEntradaCartao = 1) then
                               begin
                                 //ShowMessage('ulTipoEntrada = 1');
                               end;

                                 iRet := PW_iPPGetCard(I);

                                 if (iRet <> PWRET_OK) then
                                    begin
                                       Result := iRet;
                                       Exit;
                                    end;



                                 xloop := 0;

                                 while xloop < 10000 do
                                 begin

                                   iRet := PW_iPPEventLoop(vGetpszDisplay, sizeof(vGetpszDisplay));
                                   if (iRet = PWEnums.PWRET_DISPLAY) then
                                      begin
                                          if (PPrincipal.Memo1.Visible = False) then
                                             begin
                                               PPrincipal.Memo1.Visible := True;
                                             end;
                                          PPrincipal.Memo1.Lines.Add(vGetpszDisplay[0].szDspMsg);
                                          PPrincipal.Memo1.Lines.Add(' ');

                                      end;

                                   //if((iRet <> PWEnums.PWRET_OK) And (iRet <> PWEnums.PWRET_DISPLAY) And (iRet <> PWEnums.PWRET_NOTHING)) then
                                   if (iRet = PWEnums.PWRET_OK)  then
                                     begin
                                       Result := iRet;
                                       Exit;
                                     end;


                                    xloop := xloop+1;



                                   Sleep(1000);

                                 end;




                             end;



                            // Remoção do cartão do PIN-pad.

                            PWEnums.PWDAT_PPREMCRD:
                              begin

                                 iRet := PW_iPPRemoveCard();

                                 if (iRet <> PWRET_OK) then
                                    begin
                                       Result := iRet;
                                       Exit;
                                    end;

                                 xloop := 0;

                                 while xloop < 10000 do
                                 begin

                                   iRet := PW_iPPEventLoop(vGetpszDisplay, sizeof(vGetpszDisplay));
                                   if (iRet = PWEnums.PWRET_DISPLAY) then
                                      begin
                                          if (PPrincipal.Memo1.Visible = False) then
                                             begin
                                               PPrincipal.Memo1.Visible := True;
                                               // Memo1.Lines.Clear;
                                             end;
                                          PPrincipal.Memo1.Lines.Add(vGetpszDisplay[0].szDspMsg);
                                          PPrincipal.Memo1.Lines.Add(' ');
                                      end;

                                   //if((iRet <> PWEnums.PWRET_OK) And (iRet <> PWEnums.PWRET_DISPLAY) And (iRet <> PWEnums.PWRET_NOTHING)) then
                                   if (iRet = PWEnums.PWRET_OK)  then
                                     begin
                                       Result := iRet;
                                       Exit;
                                     end;


                                    xloop := xloop+1;


                                   Sleep(1000);


                                  end;


                              end;




                            // Captura da senha criptografada

                            PWEnums.PWDAT_PPENCPIN:
                               begin


                                 iRet := PW_iPPGetPIN(I);
                                 if (iRet <> PWRET_OK) then
                                    begin
                                       Result := iRet;
                                       Exit;
                                    end;


                                 while xloop < 1000 do
                                 begin


                                   iRet := PW_iPPEventLoop(vGetpszDisplay, sizeof(vGetpszDisplay));
                                   if (iRet = PWEnums.PWRET_DISPLAY) then
                                      begin
                                          if (PPrincipal.Memo1.Visible = False) then
                                             begin
                                               PPrincipal.Memo1.Visible := True;
                                             end;
                                          PPrincipal.Memo1.Lines.Add(vGetpszDisplay[0].szDspMsg);
                                          PPrincipal.Memo1.Lines.Add(' ');
                                      end;


                                   //if((iRet <> PWEnums.PWRET_OK) And (iRet <> PWEnums.PWRET_DISPLAY) And (iRet <> PWEnums.PWRET_NOTHING)) then
                                   if (iRet = PWEnums.PWRET_OK)  then
                                     begin
                                       Result := iRet;
                                       Exit;
                                     end;

                                   if (iRet = PWEnums.PWRET_TIMEOUT)  then
                                     begin
                                       Result := iRet;
                                       Exit;
                                     end;

                                    xloop := xloop+1;



                                   Sleep(1000);

                                 end;





                               end;



                            // processamento off-line de cartão com chip

                            PWEnums.pWDAT_CARDOFF:

                                begin


                                 iRet := PW_iPPGoOnChip(I);

                                 if (iRet <> PWRET_OK) then
                                    begin
                                       Result := iRet;
                                       Exit;
                                    end;

                                 xloop := 0;

                                 while xloop < 10000 do
                                 begin

                                   iRet := PW_iPPEventLoop(vGetpszDisplay, sizeof(vGetpszDisplay));
                                   if (iRet = PWEnums.PWRET_DISPLAY) then
                                      begin
                                          if (PPrincipal.Memo1.Visible = False) then
                                             begin
                                               PPrincipal.Memo1.Visible := True;
                                             end;
                                          PPrincipal.Memo1.Lines.Add(vGetpszDisplay[0].szDspMsg);
                                          PPrincipal.Memo1.Lines.Add(' ');
                                      end;


                                   if (iRet = PWEnums.PWRET_TIMEOUT)  then
                                     begin
                                       Result := iRet;
                                       Exit;
                                     end;


                                   //if((iRet <> PWEnums.PWRET_OK) And (iRet <> PWEnums.PWRET_DISPLAY) And (iRet <> PWEnums.PWRET_NOTHING)) then
                                   if (iRet = PWEnums.PWRET_OK)  then
                                     begin
                                       Result := iRet;
                                       Exit;
                                     end;


                                    xloop := xloop+1;



                                   Sleep(1000);


                                  end;



                                end;



                                // Captura de dado digitado no PIN-pad

                                PWEnums.PWDAT_PPENTRY:
                                  begin

                                     iRet := PW_iPPGetData(I);

                                     if (iRet <> PWRET_OK) then
                                        begin
                                           Result := iRet;
                                           Exit;
                                        end;

                                     xloop := 0;


                                     while xloop < 10000 do
                                     begin

                                       iRet := PW_iPPEventLoop(vGetpszDisplay, sizeof(vGetpszDisplay));
                                       if (iRet = PWEnums.PWRET_DISPLAY) then
                                          begin
                                              if (PPrincipal.Memo1.Visible = False) then
                                                 begin
                                                   PPrincipal.Memo1.Visible := True;
                                                 end;
                                              PPrincipal.Memo1.Lines.Add(vGetpszDisplay[0].szDspMsg);
                                              PPrincipal.Memo1.Lines.Add(' ');
                                          end;


                                       if (iRet = PWEnums.PWRET_TIMEOUT)  then
                                         begin
                                           Result := iRet;
                                           Exit;
                                         end;


                                       //if((iRet <> PWEnums.PWRET_OK) And (iRet <> PWEnums.PWRET_DISPLAY) And (iRet <> PWEnums.PWRET_NOTHING)) then
                                       if (iRet = PWEnums.PWRET_OK)  then
                                         begin
                                           Result := iRet;
                                           Exit;
                                         end;


                                        xloop := xloop+1;



                                        Sleep(1000);

                                  end;


                                  end;


                                  // Processamento online do cartão com chip

                                  PWEnums.PWDAT_CARDONL:
                                    begin

                                       iRet := PW_iPPFinishChip(I);

                                       if (iRet <> PWRET_OK) then
                                          begin
                                             Result := iRet;
                                             Exit;
                                          end;

                                       xloop := 0;

                                       while xloop < 10000 do
                                       begin

                                         iRet := PW_iPPEventLoop(vGetpszDisplay, sizeof(vGetpszDisplay));
                                         if (iRet = PWEnums.PWRET_DISPLAY) then
                                            begin
                                                if (PPrincipal.Memo1.Visible = False) then
                                                   begin
                                                     PPrincipal.Memo1.Visible := True;
                                                     // Memo1.Lines.Clear;
                                                   end;
                                                PPrincipal.Memo1.Lines.Add(vGetpszDisplay[0].szDspMsg);
                                                PPrincipal.Memo1.Lines.Add(' ');
                                            end;


                                         if (iRet = PWEnums.PWRET_TIMEOUT)  then
                                           begin
                                             Result := iRet;
                                             Exit;
                                           end;


                                         //if((iRet <> PWEnums.PWRET_OK) And (iRet <> PWEnums.PWRET_DISPLAY) And (iRet <> PWEnums.PWRET_NOTHING)) then
                                         if (iRet = PWEnums.PWRET_OK)  then
                                           begin
                                             Result := iRet;
                                             Exit;
                                           end;


                                          xloop := xloop+1;



                                         Sleep(1000);


                                       end;




                                    end;



                                  // Confirmação de dado no PIN-pad

                                  PWEnums.PWDAT_PPCONF:
                                  begin


                                       iRet := PW_iPPConfirmData(I);

                                       if (iRet <> PWRET_OK) then
                                          begin
                                             Result := iRet;
                                             Exit;
                                          end;

                                       xloop := 0;

                                       while xloop < 10000 do
                                       begin

                                         iRet := PW_iPPEventLoop(vGetpszDisplay, sizeof(vGetpszDisplay));
                                         if (iRet = PWEnums.PWRET_DISPLAY) then
                                            begin
                                                if (PPrincipal.Memo1.Visible = False) then
                                                   begin
                                                     PPrincipal.Memo1.Visible := True;
                                                     // Memo1.Lines.Clear;
                                                   end;
                                                PPrincipal.Memo1.Lines.Add(vGetpszDisplay[0].szDspMsg);
                                                PPrincipal.Memo1.Lines.Add(' ');
                                            end;


                                         if (iRet = PWEnums.PWRET_TIMEOUT)  then
                                           begin
                                             Result := iRet;
                                             Exit;
                                           end;


                                         //if((iRet <> PWEnums.PWRET_OK) And (iRet <> PWEnums.PWRET_DISPLAY) And (iRet <> PWEnums.PWRET_NOTHING)) then
                                         if (iRet = PWEnums.PWRET_OK)  then
                                           begin
                                             Result := iRet;
                                             Exit;
                                           end;


                                          xloop := xloop+1;



                                         Sleep(1000);


                                       end;



                                  end;



                                else


                                  begin

                                      ShowMessage('TIPO DE DADOS DESCONHECIDO : ' + IntToStr(vstGetData[I].bTipoDeDado));

                                  end;





                     end;





                    I := I+1;

                    continue;


                end;

                Result := PWRET_OK;

                PPrincipal.Label1.Visible := True;
                PPrincipal.Label1.Caption := 'PROCESSANDO ...';
                Application.ProcessMessages;


          end;




end.

//*****************************************************************************
//
// unit:   uPOSEnums
// Classe: TPOSEnums
//
// Data de criação  :  01/07/2019
// Autor            :
// Descrição        :  Parametros da aplicação
//
//*****************************************************************************/
unit uPOSEnums;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.StrUtils, system.AnsiStrings,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Types, System.TypInfo;

type

  TCPOSEnums = class

private
{}
public



const

//==========================================================================================
// Definição da versão do aplicativo
//==========================================================================================

  PGWEBLIBTEST_VERSION = '2.1.1';
  PGWEBLIBTEST_AUTDEV  = 'AUTOMACAO DE SISTEMAS';
  PGWEBLIBTEST_AUTNAME = 'TestePOSPaygo';
  PGWEBLIBTEST_AUTCAP  = '15';
  PGWEBLIBTEST_AUTHTECHUSER  = 'PAYGOTESTE';

//==========================================================================================
//   Tipos de dados que podem ser informados pela Automação
//==========================================================================================
  PWINFO_OPERATION = 2;         //Transação que foi realizada: “00” – Sem Definição “01” – Venda (pagamento) “02” – Administrativa (geral) “04” – Estorno de Venda
  PWINFO_MERCHANTCNPJCPF = 28;  //CNPJ (ou CPF) do Estabelecimento / Ponto de captura
  PWINFO_TOTAMNT = 37;          //Valor da transação, em centavos. Este parâmetro é mandatório para transações de venda (PTITRN_SALE) e de estorno (PTITRN_SALEVOID)
  PWINFO_CURRENCY = 38;         //Código da moeda, conforme o padrão internacional ISO4217 (986 para Real, 840 para Dólar americano). Este parâmetro é requerido sempre que PWINFO_TOTAMNT for informado
  PWINFO_FISCALREF = 40;        //Número da fatura (final nulo). Este parâmetro é opcional.
  PWINFO_CARDTYPE = 41;         //Modalidade da transação do cartão: 1: crédito; 2: débito; 4: voucher; 8: private label; 16: frota; 128: outros.
  PWINFO_PRODUCTNAME = 42;      //Nome/tipo do produto utilizado, na nomenclatura do Provedor.
  PWINFO_DATETIME = 49;         //Horário do servidor PGWEB, format “YYMMDDhhmmss”.
  PWINFO_REQNUM = 50;           //Identificador único da transação (gerado pelo terminal).
  PWINFO_AUTHSYST = 53;         //Código da Rede Adquirente, conforme descrito no item 5.5. Caso este campo seja preenchido, a transação será realizada diretamente na rede adquirente especificada
  PWINFO_VIRTMERCH = 54;        //Identificador da afiliação utilizada para o sistema de gerenciamento do terminal.
  PWINFO_AUTMERCHID = 56;       //Identificador do estabelecimento para a adquirente.
  PWINFO_FINTYPE = 59;          //Modalidade de financiamento da transação: 1: à vista; 2: parcelado pelo Emissor; 4: parcelado pelo Estabelecimento; 8: pré-datado; 16: crédito emissor; 32: Prédatado parcelado.
  PWINFO_INSTALLMENTS = 60;     //Quantidade de parcelas, para transações parceladas.
  PWINFO_INSTALLMDATE = 61;     //Data de vencimento do prédatado, ou da primeira parcela. Formato “DDMMAA”.
  PWINFO_RESULTMSG = 66;        //Mensagem de texto que descreve o resultado da transação (sucesso ou falha).
  PWINFO_AUTLOCREF = 68;        //Identificador único da transação (gerado pelo sistema de gerenciamento do terminal).
  PWINFO_AUTEXTREF = 69;        //Identificador único da transação (gerado pela adquirente/processadora)
  PWINFO_AUTHCODE = 70;         //Código de autorização (gerado pelo emissor).
  PWINFO_AUTRESPCODE = 71;      //Caso a transação chegue ao sistema autorizador, esse é o código de resposta do mesmo  (bit39 da mensagem ISO8583).
  PWINFO_DISCOUNTAMT = 73;      //Valor do desconto concedido pelo Provedor, considerando PWINFO_CURREXP, já deduzido em PWINFO_TOTAMNT.
  PWINFO_CASHBACKAMT = 74;      //Valor do saque/troco, considerando PWINFO_CURREXP, já incluído em PWINFO_TOTAMNT.
  PWINFO_CARDNAME = 75;         //Nome do cartão ou emissor
  PWINFO_BOARDINGTAX = 77;      //Valor da taxa de embarque, considerando PWINFO_CURREXP, já incluído em PWINFO_TOTAMNT.
  PWINFO_TIPAMOUNT = 78;        //Valor da taxa de serviço (gorjeta), considerando PWINFO_CURREXP, já incluído em PWINFO_TOTAMNT.
  PWINFO_RCPTMERCH = 83;        //Comprovante – via do estabelecimento.
  PWINFO_RCPTCHOLDER = 84;      //Comprovante – via do portador.
  PWINFO_RCPTCHSHORT = 85;      //Comprovante – via reduzida
  PWINFO_TRNORIGDATE = 87;      //Data da transação original. Este campo é utilizado para transações de cancelamento. Formato DDMMAA.
  PWINFO_TRNORIGNSU = 88;       //Número de referência da transação original (atribuído pela adquirente/processadora). Este parâmetro é mandatório para transações de estorno (PTITRN_SALEVOID).
  PWINFO_TRNORIGAUTH = 98;      //Código de autorização da transação original. Este campo é utilizado para transações de cancelamento.
  PWINFO_LANGUAGE = 108;        //Idioma a ser utilizado para a interface com o cliente: 0: Português 1: Inglês 2: Espanhol
  PWINFO_TRNORIGTIME = 115;     //Horário da transação original. Este campo é utilizado para transações de cancelamento. Formato HHMMSS.
  PWPTI_RESULT = 129;           //Caso a execução da função retorne PTIRET_EFTERR, este campo informa o detalhamento do erro.
  PWINFO_CARDENTMODE = 192;     //Modo de entrada do cartão:  1: número do cartão digitado 2: tarja magnética 4: chip com contato EMV  16: fallback para tarja magnética  32: chip sem contato simulando tarja magnética 64: chip sem contato EMV 128: indica que a transação atual é oriunda de um fallback (flag enviado do servidor para o ponto de captura). 256: fallback de tarja para digitado
  PWINFO_CARDPARCPAN = 200;     //Número do cartão mascarado
  PWINFO_CHOLDVERIF = 207;      //Verificação do portador do cartão, soma de:  1: assinatura 2: verificação offline da senha 4: senha offline bloqueada durante a transação  8: verificação on-line da senha.
  PWINFO_MERCHADDDATA1 = 240;   //Número de referência da transação atribuído pela Automação Comercial. Caso fornecido, este número será incluído no histórico de dados da transação e encaminhado à adquirente/processadora, se suportado. Este parâmetro é opcional.
  PWINFO_MERCHADDDATA2 = 241;   //Dados adicionais específicos do negócio. Caso fornecido, será incluso no histórico de dados da transação, por exemplo para referências cruzadas. Este parâmetro é opcional.
  PWINFO_MERCHADDDATA3 = 242;   //Dados adicionais específicos do negócio. Caso fornecido, será incluso no histórico de dados da transação, por exemplo para referências cruzadas. Este parâmetro é opcional.
  PWINFO_MERCHADDDATA4 = 243;   //Dados adicionais específicos do negócio. Caso fornecido, será incluso no histórico de dados da transação, por exemplo para referências cruzadas. Este parâmetro é opcional.
  PWINFO_PNDAUTHSYST = 32517;   //Nome do provedor para o qual existe uma transação pendente.
  PWINFO_PNDVIRTMERCH = 32518;  //Identificador do Estabelecimento para o qual existe uma transação pendente.
  PWINFO_PNDAUTLOCREF = 32520;  //Referência para a infraestrutura Erro! Nome de propriedade do documento desconhecido. da transação que está pendente.
  PWINFO_PNDAUTEXTREF = 32521;  //Referência para o Provedor da transação que está pendente.
  PWINFO_DUEAMNT = 48902;       //Valor devido pelo usuário, considerando PWINFO_CURREXP, já deduzido em PWINFO_TOTAMNT.
  PWINFO_READJUSTEDAMNT = 48905;//Valor total da transação reajustado, este campo será utilizado caso o autorizador, por alguma regra de negócio específica dele, resolva alterar o valor total que foi solicitado para a transação.
  PWINFO_CHOLDERNAME = 7992;  // Nome do portador do cartão utilizado, o tamanho segue o mesmo padrão da tag 5F20 EMV.
  PWINFO_CARDNAMESTD = 196;   // Descrição do produto bandeira padrão relacionado ao BIN.


//==========================================================================================
//   Status final para a transação
//==========================================================================================
  PTICNF_SUCCESS  = 1; // Transação confirmada.
  PTICNF_PRINTERR = 2; // Erro na impressora, desfazer a transação
  PTICNF_DISPFAIL = 3; // Erro com o mecanismo dispensador, desfazer a transação
  PTICNF_OTHERERR = 4; // Outro erro, desfazer a transação.



//==========================================================================================
//   Identificadores da cópia do recibo:
//==========================================================================================
  PTIPRN_MERCHANT = 1;  // Via do estabelecimento
  PTIPRN_CHOLDER  = 2;  // Via do portador do cartão


//==========================================================================================
//  Tabela de Códigos de Erro de Retorno da Biblioteca
//==========================================================================================
  ERRO_INTERNO = 99;            //Erro desta aplicação
  PTIRET_OK = 0;                //Operação bem-sucedida
  PTIRET_INVPARAM = -2001;      //Parâmetro inválido informado à função.
  PTIRET_NOCONN = -2002;        //O terminal está offline
  PTIRET_BUSY = -2003;          //O terminal está ocupado processando outro comando.
  PTIRET_TIMEOUT = -2004;       //Usuário falhou ao pressionar uma tecla durante o tempo especificado
  PTIRET_CANCEL = -2005;        //Usuário pressionou a tecla [CANCELA].
  PTIRET_NODATA = 2006;         //Informação requerida não disponível
  PTIRET_BUFOVRFLW = -2007;     //Dados maiores que o tamanho do buffer fornecido
  PTIRET_SOCKETERR = -2008;     //Impossibilitado de iniciar escuta das portas TCP especificadas
  PTIRET_WRITEERR = -2009;      //Impossibilitado de utilizar o diretório especificado
  PTIRET_EFTERR = -2010;        //A operação financeira foi completada, porém falhou
  PTIRET_INTERNALERR = -2011;   //Erro interno da biblioteca de integração
  PTIRET_PROTOCOLERR = -2012;   //Erro de comunicação entre a biblioteca de integração e o terminal
  PTIRET_SECURITYERR = -2013;   //A função falhou por questões de segurança
  PTIRET_PRINTERR = -2014;      //Erro na impressora
  PTIRET_NOPAPER = -2015;       //Impressora sem papel
  PTIRET_NEWCONN = -2016;       //Novo terminal conectado
  PTIRET_NONEWCONN = -2017;     //Sem recebimento de novas conexões.
  PTIRET_NOTSUPPORTED = -2057;  //Função não suportada pelo terminal.
  PTIRET_CRYPTERR = -2058;      //Erro na criptografia de dados (comunicação entre a biblioteca de integração e o terminal).



//==========================================================================================
// Definicoes das teclas do POS
//==========================================================================================
  PTIKEY_0       = 48;
  PTIKEY_1       = 49;
  PTIKEY_2       = 50;
  PTIKEY_3       = 51;
  PTIKEY_4       = 52;
  PTIKEY_5       = 53;
  PTIKEY_6       = 54;
  PTIKEY_7       = 55;
  PTIKEY_8       = 56;
  PTIKEY_9       = 57;
  PTIKEY_STAR    = '*';
  PTIKEY_HASH    = '#';
  PTIKEY_DOT     = '.';
  PTIKEY_00      = 37;
  PTIKEY_BACKSP  = 8;
  PTIKEY_OK      = 13;
  PTIKEY_CANCEL  = 27;
  PTIKEY_FUNC0   = 97;
  PTIKEY_FUNC1   = 98;
  PTIKEY_FUNC2   = 99;
  PTIKEY_FUNC3   = 100;
  PTIKEY_FUNC4   = 101;
  PTIKEY_FUNC5	 = 102;
  PTIKEY_FUNC6	 = 103;
  PTIKEY_FUNC7	 = 104;
  PTIKEY_FUNC8	 = 105;
  PTIKEY_FUNC9	 = 106;
  PTIKEY_FUNC10	 = 107;
  PTIKEY_TOUCH   = 126;
  PTIKEY_ALPHA   = 38;


//==========================================================================================
//   Tipos de transações
//==========================================================================================
  PWOPER_ADMIN    = 32;  // Qualquer transação que não seja um pagamento(estorno, pré-autorização, consulta, relatório, reimpressão de recibo, etc.).
  PWOPER_SALE     = 33;  // Pagamento de mercadorias ou serviços.
  PWOPER_SALEVOID = 34;  // Estorna uma transação de venda que foi previamente realizada e confirmada


//==========================================================================================
// Tipos de aviso sonoro:
//==========================================================================================
  PTIBEEP_OK       = 0;  // Sucesso
  PTIBEEP_WARNING  = 1;  // Alerta
  PTIBEEP_ERROR    = 2;  // Erro


//==========================================================================================
// Modalidade de Financiamneto da Transação
//==========================================================================================
  a_vista = 1;
  parcelado_pelo_Emissor = 2;
  parcelado_pelo_Estabelecimento = 4;
  pré_datado = 8;
  crédito_emissor = 16;
  Prédatado_parcelado = 32;


//==========================================================================================
// Modalidade da transação do cartão:
//==========================================================================================
  Credito = 1;
  Debito = 2;
  Voucher = 4;
  Private_Label = 8;
  Frota = 16;
  Outros = 128;


//==========================================================================================
// Status do Terminal
//==========================================================================================

  PTISTAT_IDLE = 0;        // Terminal está on-line e aguardando por comandos.
  PTISTAT_BUSY = 1;        // Terminal está on-line, porém ocupado processando um comando
  PTISTAT_NOCONN = 2;      // Terminal está offline.
  PTISTAT_WAITRECON = 3;   // Terminal está off-line. A transação continua sendo executada e
                           // após sua finalização, o terminal tentará efetuar a reconexão
                           // automaticamente.



//==========================================================================================
//
//==========================================================================================
   WInputH:Integer = 550;
   WInputV:Integer = 140;



  Constructor Create;    // declaração do metodo construtor

  Destructor  Destroy; Override; // declaração do metodo destrutor



  end;


var
eCclasse:TCPOSEnums;


implementation

{ TCEnums }

{ TCPOSEnums }

constructor TCPOSEnums.Create;
begin

end;

destructor TCPOSEnums.Destroy;
begin

  inherited;
end;

end.

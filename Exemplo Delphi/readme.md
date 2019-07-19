# Exemplo de integração em Delphi com a biblioteca PGWebLibC da plataforma de transações com cartão PayGo Web

### Funcionalidades implementadas neste exemplo:
  - Instalação
  - Venda
  - Confirmação
  - Cancelamento
  - Reimpressão
  - Relatório das transações
  - Função Administrativa
  - Captura no PinPad
  - Caso de uso não convencionais
  
### Pré-requisitos
  - Delphi 
  - Windows
  - Cadastro no ambiente de testes/sandbox do PayGo Web
    - código do Ponto de Captura (PdC)
    - PIN-Pad

#### Instruções de uso do exemplo Delphi

- Antes de utilizar qualquer função da PGWebLib.dll o primirei passo é inicializa-la. 
  Para fazer isso no exemplo Delphi, clique no menu de opções, em seguida na opção PW_iINit - Inicializar. 
  Após isso será solicitado um diretório para gravar os logs de interação com a PGWebLib.dll.

- A primeira transação a ser efetuada é a de INSTALAÇÃO. Esta pode ser acionada diretamente
  PW_iNewTransac, em seguida PWOPER_INSTALL ou através de uma transação ADMINISTRATIVA (PWOPER_ADMIN).
  
- No decorrer da transação de instalação são solicitadas as configurações necessárias para operação
  do Ponto de Captura. Para alterar estas configurações após isso, acionar a transação de CONFIGURAÇÃO,
  diretamente (PWOPER_CONFIG), ou através de uma transação ADMINISTRATIVA (PWOPER_ADMIN).

- Quando solicitada a senha técnica, informar "314159".

- A primeira comunicação com o PIN-pad pode demorar até 1 minuto, devido à coleta de todas as suas
  informações.

- Após realizar a transação de instalação com sucesso, um comprovante será gerado, listando os
  sistemas de autorização configurados para o Ponto de Captura. A partir deste momento, outras transações
  poderão ser realizadas (venda, recarga, etc.).
  
  ### Observações
1) Caso ainda não possua os dados de configuração do ambiente de teste entre em contato com a PayGo pelos seguintes canais:
0800 737 2255 Opção 1
dev@paygo.com.br

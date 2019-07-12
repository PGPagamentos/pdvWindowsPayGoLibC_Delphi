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

### Configurando no Windows

### Como executar
Windows


#### Observações

1 O certificado "certificado.crt" na raiz do projeto é utilizado apenas no ambiente de testes, para ambiente produtivo utiliza-se outro arquivo.

2 PGWebLib.DLL e certificado.crt devem ser colocada na pasta de criação do Projeto  \Win32\Debug  para compilação do mesmo. (Estas pastas são criadas na primeira compilação, copiar os arquivos e compilar novamente)

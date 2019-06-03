unit Principal;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.StrUtils, system.AnsiStrings,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Types, System.TypInfo,uEnums,
  Vcl.ExtCtrls, uLib, uPGWLib, Vcl.Menus;

type



  TPrincipal = class(TForm)
    Label1: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    MainMenu1: TMainMenu;
    Operaes1: TMenuItem;
    PWiInit1: TMenuItem;
    PWiNewTransac1: TMenuItem;
    PWOPERINSTALL1: TMenuItem;
    PWOPERSALEVenda1: TMenuItem;
    PWiConfirmation1: TMenuItem;
    PWOPERSALEVOIDCancelamento1: TMenuItem;
    PWOPERVERSIONVersodaDLL1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N5PWOPERREPRINTReimpresso1: TMenuItem;
    N7: TMenuItem;
    PWOPERRPTDETAIL1: TMenuItem;
    N8: TMenuItem;
    N7PWOPERADMIN1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PWiInit1Click(Sender: TObject);
    procedure PWOPERINSTALL1Click(Sender: TObject);
    procedure PWOPERSALEVenda1Click(Sender: TObject);
    procedure PWiConfirmation1Click(Sender: TObject);
    procedure PWOPERSALEVOIDCancelamento1Click(Sender: TObject);
    procedure PWOPERVERSIONVersodaDLL1Click(Sender: TObject);
    procedure N5PWOPERREPRINTReimpresso1Click(Sender: TObject);
    procedure PWOPERRPTDETAIL1Click(Sender: TObject);
    procedure N7PWOPERADMIN1Click(Sender: TObject);



  private



  public

      PWEnums : TCEnums;
      PGWLib  : TPGWLib;

      iKey:Integer;

      ApertouESC:Boolean;



   Constructor Create;             // declaração do metodo construtor

   Destructor  Destroy; Override; // declaração do metodo destrutor


   var








  end;







var
  PPrincipal: TPrincipal;





implementation

{$R *.dfm}


constructor TPrincipal.Create;
begin

  PWEnums := TCEnums.Create;
  PGWLib  := TPGWLib.Create;


end;

destructor TPrincipal.Destroy;
begin
  PWEnums.Free;

  inherited;
end;

procedure TPrincipal.FormCreate(Sender: TObject);
begin
      //=================================================
      //  Atualiza Form Inicial com Dados da Aplicação
      //=================================================

      Label2.Caption := 'PWINFO_AUTNAME(21): ' + '  ' + PWEnums.PGWEBLIBTEST_AUTNAME;
      Label3.Caption := 'PWINFO_AUTVER (22) : ' + '  ' + PWEnums.PGWEBLIBTEST_VERSION;
      Label4.Caption := 'PWINFO_AUTDEV (23) : ' + '  ' + PWEnums.PGWEBLIBTEST_AUTDEV;
      Label5.Caption := 'PWINFO_AUTCAP (36) : ' + '  ' + PWEnums.PGWEBLIBTEST_AUTCAP;

end;


procedure TPrincipal.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     //label6.caption := Key.ToString;

     iKey := Key;
end;




procedure TPrincipal.N5PWOPERREPRINTReimpresso1Click(Sender: TObject);
begin

    // Transação de Reimpressão
       PGWLib.Reimpressao();

end;

procedure TPrincipal.N7PWOPERADMIN1Click(Sender: TObject);
begin

    // Transação Administrativa
   // PGWLib.Admin();

end;

procedure TPrincipal.PWiConfirmation1Click(Sender: TObject);
begin

    //  Confirmação de Transação
   PGWLib.ConfirmaTrasacao();


end;

procedure TPrincipal.PWiInit1Click(Sender: TObject);
begin

      // Inicializar Lib
      PGWLib.Init();

end;

procedure TPrincipal.PWOPERINSTALL1Click(Sender: TObject);
begin

    // Instalar Ponto de Captura
    PGWLib.Instalacao();

end;

procedure TPrincipal.PWOPERRPTDETAIL1Click(Sender: TObject);
begin
    // Relatórios
   // PGWLib.Relatorios();

end;

procedure TPrincipal.PWOPERSALEVenda1Click(Sender: TObject);
begin

    // Transação de Venda
    PGWLib.venda();

end;

procedure TPrincipal.PWOPERSALEVOIDCancelamento1Click(Sender: TObject);
begin

      // Cancelamento
      PGWLib.Cancelamento();

end;

procedure TPrincipal.PWOPERVERSIONVersodaDLL1Click(Sender: TObject);
begin

    // versão atual da DLL
    PGWLib.GetVersao();

end;

end.

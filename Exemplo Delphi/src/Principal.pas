unit Principal;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.StrUtils, system.AnsiStrings,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Types, System.TypInfo,uEnums,
  Vcl.ExtCtrls, uLib, uPGWLib, Vcl.Menus, Vcl.Mask, System.Actions, Vcl.ActnList;

type



  TTelPrincipal = class(TForm)
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
    N9: TMenuItem;
    Button1: TButton;
    Button2: TButton;
    N10: TMenuItem;
    N8TestaAutoAtendimento1: TMenuItem;
    ActionList1: TActionList;
    Abortar: TAction;
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
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N8TestaAutoAtendimento1Click(Sender: TObject);
    procedure AbortarExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);



  private



  public

      PWEnums : TCEnums;
      PGWLib  : TPGWLib;

      iKey:Integer;

      ApertouESC:Boolean;



   Constructor Create;             // declaração do metodo construtor

   Destructor  Destroy; Override; // declaração do metodo destrutor




  end;







var
  TPrincipal: TTelPrincipal;





implementation

{$R *.dfm}

uses FCaptura, uLib02;

//uses FrmCaptura;




procedure TTelPrincipal.AbortarExecute(Sender: TObject);
begin

  ShowMessage('Abortar');

end;

procedure TTelPrincipal.Button1Click(Sender: TObject);
begin

    // Limpa Log
    Memo1.Clear;

end;

procedure TTelPrincipal.Button2Click(Sender: TObject);
begin

    TelCaptura.ShowModal;

end;

constructor TTelPrincipal.Create;
begin

  PWEnums := TCEnums.Create;
  PGWLib  := TPGWLib.Create;


end;

destructor TTelPrincipal.Destroy;
begin
  PWEnums.Free;

  inherited;
end;

procedure TTelPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Application.Terminate;

end;

procedure TTelPrincipal.FormCreate(Sender: TObject);
begin
      //=================================================
      //  Atualiza Form Inicial com Dados da Aplicação
      //=================================================

      Label2.Caption := 'PWINFO_AUTNAME(21): ' + '  ' + PWEnums.PGWEBLIBTEST_AUTNAME;
      Label3.Caption := 'PWINFO_AUTVER (22) : ' + '  ' + PWEnums.PGWEBLIBTEST_VERSION;
      Label4.Caption := 'PWINFO_AUTDEV (23) : ' + '  ' + PWEnums.PGWEBLIBTEST_AUTDEV;
      Label5.Caption := 'PWINFO_AUTCAP (36) : ' + '  ' + PWEnums.PGWEBLIBTEST_AUTCAP;

end;


procedure TTelPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

     //ShowMessage('Teclou Algo ' + IntToStr(Key));
     iKey := Key;

end;

procedure TTelPrincipal.FormKeyPress(Sender: TObject; var Key: Char);
begin

if Key = #27 then
  begin
    iKey := 1;
  end;
end;

procedure TTelPrincipal.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     //label6.caption := Key.ToString;

     iKey := Key;
end;




procedure TTelPrincipal.N5PWOPERREPRINTReimpresso1Click(Sender: TObject);
begin

    // Transação de Reimpressão
       PGWLib.Reimpressao();

end;

procedure TTelPrincipal.N7PWOPERADMIN1Click(Sender: TObject);
begin

    // Transação Administrativa
    PGWLib.Admin();

end;

procedure TTelPrincipal.N8TestaAutoAtendimento1Click(Sender: TObject);
begin

  // Teste de Auto Atendimento
//  PGWLib.TesteAA();

end;

procedure TTelPrincipal.PWiConfirmation1Click(Sender: TObject);
begin

    //  Confirmação de Transação
   PGWLib.ConfirmaTrasacao();


end;

procedure TTelPrincipal.PWiInit1Click(Sender: TObject);
begin

      // Inicializar Lib
      PGWLib.Init();

end;

procedure TTelPrincipal.PWOPERINSTALL1Click(Sender: TObject);
begin

    // Instalar Ponto de Captura
    PGWLib.Instalacao();

end;

procedure TTelPrincipal.PWOPERRPTDETAIL1Click(Sender: TObject);
begin
    // Relatórios
    PGWLib.Relatorios();

end;

procedure TTelPrincipal.PWOPERSALEVenda1Click(Sender: TObject);
begin

    // Transação de Venda

     // Força Tecla
     //keybd_event(VK_HOME, 0, 0, 0);

    PGWLib.venda();

end;

procedure TTelPrincipal.PWOPERSALEVOIDCancelamento1Click(Sender: TObject);
begin

        // Força Tecla
        // keybd_event(VK_HOME, 0, 0, 0);
        // keybd_event(VK_ESCAPE, 0, 0, 0);

       // Verifica se Teclou <ESC>
       //if GetAsyncKeyState(VK_ESCAPE)<>0 then
       //   begin
       //     keybd_event(VK_ESCAPE, 0, 0, 0);
       //   end;


      // if (iKey = 1) then
      //     begin
      //       ShowMessage('Abortar');
      //     end;


      // Cancelamento
      PGWLib.Cancelamento();

end;

procedure TTelPrincipal.PWOPERVERSIONVersodaDLL1Click(Sender: TObject);
begin

    // versão atual da DLL
    PGWLib.GetVersao();

end;

end.

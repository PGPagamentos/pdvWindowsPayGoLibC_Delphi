unit Principal;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.StrUtils, system.AnsiStrings,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Types, System.TypInfo,uEnums,
  Vcl.ExtCtrls, uLib, uPGWLib;

type



  TPrincipal = class(TForm)
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Label1: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    Button1: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);



  private



  public

      PWEnums : TCEnums;
      PGWLib  : TPGWLib;

      iKey:Integer;

      ApertouESC:Boolean;



   Constructor Create;             // declaração do metodo construtor

   Destructor  Destroy; Override; // declaração do metodo  destrutor


   var








  end;







var
  PPrincipal: TPrincipal;





implementation

{$R *.dfm}


procedure TPrincipal.Button1Click(Sender: TObject);
begin

//   PGWLib.ConfirmaTrasacao();

end;

procedure TPrincipal.Button2Click(Sender: TObject);
begin

    // versão atual da DLL
    PGWLib.GetVersao();

end;

procedure TPrincipal.Button3Click(Sender: TObject);
begin

    // Instalar Ponto de Captura
    PGWLib.Instalacao();

end;




procedure TPrincipal.Button4Click(Sender: TObject);
begin

    // Transação de Venda
    PGWLib.venda();

end;


procedure TPrincipal.Button5Click(Sender: TObject);
begin

      // Inicializar Lib
      PGWLib.Init();

end;

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




end.

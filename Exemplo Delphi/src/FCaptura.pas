unit FCaptura;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,uPGWLib, Vcl.Mask;

type
  TTelCaptura = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ComboBox3: TComboBox;
    ComboBox2: TComboBox;
    ComboBox1: TComboBox;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }



   PGWLib  : TPGWLib;

   Constructor Create;             // declaração do metodo construtor

   Destructor  Destroy; Override; // declaração do metodo destrutor

   Procedure FormatarComoMoeda( Componente : TObject; var Key: Char );

  end;

var
  TelCaptura: TTelCaptura;

implementation

{$R *.dfm}

procedure TTelCaptura.Button1Click(Sender: TObject);
begin

  Close;

end;

procedure TTelCaptura.Button2Click(Sender: TObject);
var
nome:string;
begin

  label4.Visible := True;
  Label4.Caption := '';
  label4.Visible := False;
  Application.ProcessMessages;
  nome := combobox1.items[combobox1.ItemIndex];
  PGWLib.CapturaPinPad(nome,ComboBox1.ItemIndex+1,ComboBox2.ItemIndex+1,ComboBox3.ItemIndex+1);

end;

constructor TTelCaptura.Create;
begin

  PGWLib  := TPGWLib.Create;

end;

destructor TTelCaptura.Destroy;
begin

  inherited;
end;

procedure TTelCaptura.RadioButton1Click(Sender: TObject);
begin
   if (RadioButton1.Checked = True) then
      begin
        ComboBox1.Enabled := True;
        Label4.Caption := '';
        Label4.Visible := False;
      end;
end;

procedure TTelCaptura.RadioButton2Click(Sender: TObject);
begin
   if (RadioButton2.Checked = True) then
      begin
        ComboBox1.Enabled := False;
        Label4.Caption := '';
        Label4.Visible := False;
      end;
end;


Procedure TTelCaptura.FormatarComoMoeda( Componente : TObject; var Key: Char );
var
   str_valor  : String;
   dbl_valor  : double;
begin

   { verificando se estamos recebendo o TEdit realmente }
   IF Componente is TEdit THEN
   BEGIN
      { se tecla pressionada e' um numero, backspace ou del deixa passar }
      IF ( Key in ['0'..'9', #8, #9] ) THEN
      BEGIN
         { guarda valor do TEdit com que vamos trabalhar }
         str_valor := TEdit( Componente ).Text ;
         { verificando se nao esta vazio }
         IF str_valor = EmptyStr THEN str_valor := '0,00' ;
         { se valor numerico ja insere na string temporaria }
         IF Key in ['0'..'9'] THEN str_valor := Concat( str_valor, Key ) ;
         { retira pontos e virgulas se tiver! }
         str_valor := Trim( StringReplace( str_valor, '.', '', [rfReplaceAll, rfIgnoreCase] ) ) ;
         str_valor := Trim( StringReplace( str_valor, ',', '', [rfReplaceAll, rfIgnoreCase] ) ) ;
         {inserindo 2 casas decimais}
         dbl_valor := StrToFloat( str_valor ) ;
         dbl_valor := ( dbl_valor / 100 ) ;

         {reseta posicao do tedit}
         TEdit( Componente ).SelStart := Length( TEdit( Componente ).Text );
         {retornando valor tratado ao TEdit}
         TEdit( Componente ).Text := FormatFloat( '###,##0.00', dbl_valor ) ;
      END;
      {se nao e' key relevante entao reseta}
      IF NOT( Key in [#8, #9] ) THEN key := #0;
   END;
end;


procedure TTelCaptura.FormKeyPress(Sender: TObject; var Key: Char);
begin
//   FormatarComoMoeda(Edit1,Key);
end;

end.

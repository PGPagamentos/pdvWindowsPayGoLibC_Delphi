//*****************************************************************************
  {
   unit:   uLib
   Classe: uLib

   Data de criação  : 20/05/2019
   Autor            :
   Descrição        : Lib contendo estruturas Auxiliares da Aplicação
   }
//*****************************************************************************/
unit uLib;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.StrUtils, system.AnsiStrings,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Types, System.TypInfo;





function GetAveCharSize(Canvas: TCanvas): TPoint;
function vInputQuery(const ACaption, APrompt: string; var Value: string; x,y:integer): Boolean;
function vInputBox(const ACaption, APrompt, ADefault: string; x,y: integer): string;
function KeyIsDown(const Key: integer): boolean;

var
x:Integer;


implementation





//==========================================================
  {
    Auxliar para capturar tamanho dos caracteres de InputBox
  }
//==========================================================
function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;



end;


//==========================================================
  {
    Cria Formulário para entrada de dados
  }
//==========================================================
function vInputQuery(const ACaption, APrompt: string; var Value: string; x,y:integer): Boolean;
var
  Form: TForm;
  Prompt: TLabel;
  Edit: TEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Result := False;
  Form := TForm.Create(Application);
with Form do
try
  FormStyle := fsStayOnTop;
  BorderIcons := BorderIcons - [biSystemMenu] - [biMaximize]; // Tira Maximizar
  Canvas.Font := Font;
  DialogUnits := GetAveCharSize(Canvas);
  BorderStyle := bsDialog;
  Caption := ACaption;
  ClientWidth := MulDiv(180, DialogUnits.X, 4);
  Position := poDesigned;
  Top := y;
  Left := x;
  Prompt := TLabel.Create(Form);
with Prompt do
begin
  Parent := Form;
  Caption := APrompt;
  Left := MulDiv(8, DialogUnits.X, 4);
  Top := MulDiv(8, DialogUnits.Y, 8);
  Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
  WordWrap := True;
end;
Edit := TEdit.Create(Form);
with Edit do
begin
  Parent := Form;
  Left := Prompt.Left;
  Top := Prompt.Top + Prompt.Height + 5;
  Width := MulDiv(164, DialogUnits.X, 4);
  MaxLength := 255;
  // PassWordChar := ´*´;
  Text := Value;
  SelectAll;
end;
  ButtonTop := Edit.Top + Edit.Height + 15;
  ButtonWidth := MulDiv(50, DialogUnits.X, 4);
  ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
with TButton.Create(Form) do
begin
  Parent := Form;
  Caption := 'Ok';
  ModalResult := mrOk;
  Default := True;
  SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
  ButtonHeight);
end;

with TButton.Create(Form) do
begin
  Parent := Form;
  Caption := 'Cancelar';
  ModalResult := mrCancel;
  Cancel := True;
  //Enabled := False;
  Visible := False;       // Esconde Botão Cancelar
  SetBounds(MulDiv(92, DialogUnits.X, 4), Edit.Top + Edit.Height + 15,
  ButtonWidth, ButtonHeight);
  Form.ClientHeight := Top + Height + 13;
end;

if ShowModal = mrOk then
begin
  Value := Edit.Text;
  Result := True;
end;
finally
  Form.Free;
end;
end;



//==========================================================
  {
    Executa ImputBox
  }
//==========================================================
function vInputBox(const ACaption, APrompt, ADefault: string; x,y: integer): string;
begin
  Result := ADefault;
  vInputQuery(ACaption, APrompt, Result, x,y);
end;



function KeyIsDown(const Key: integer): boolean;
begin
  Result := GetKeyState(Key) and 128 > 0;
end;


end.

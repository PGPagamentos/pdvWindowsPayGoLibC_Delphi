program TestePaygo;

uses
  Vcl.Forms,
  uEnums in 'uEnums.pas',
  uLib in 'uLib.pas',
  uPGWLib in 'uPGWLib.pas',
  Principal in 'Principal.pas' {TelPrincipal},
  FCaptura in 'FCaptura.pas' {TelCaptura},
  uLib02 in 'uLib02.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTelPrincipal, TPrincipal);
  Application.CreateForm(TTelCaptura, TelCaptura);
  Application.Run;

end.

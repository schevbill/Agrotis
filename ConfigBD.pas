unit ConfigBD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.UITypes;

type
  TfConfigBD = class(TForm)
    pFundo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtIP: TEdit;
    btnCriarINI: TButton;
    edtPatch: TEdit;
    btnLocalizar: TButton;
    OpenDialog: TOpenDialog;
    procedure btnLocalizarClick(Sender: TObject);
    procedure btnCriarINIClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fConfigBD: TfConfigBD;

implementation

{$R *.dfm}

uses FuncaoGenerica, DM;

procedure TfConfigBD.btnCriarINIClick(Sender: TObject);
begin
  if SameText(Trim(edtIP.Text),'') then
  begin
    ShowMessage('Preencher valor no IP SERVIDOR');
    edtIP.SetFocus;
    Abort;
  end;

  if SameText(Trim(edtPatch.Text),'') then
  begin
    ShowMessage('Preencher valor no PATCH DO BANCO');
    edtPatch.SetFocus;
    Abort;
  end;

  if GravarINI(edtIP.Text, edtPatch.Text) then
  begin
    MessageDlg('Sistema será fechado para configurar o config.ini!' ,mtConfirmation,[mbyes],0);

    with fDM.FDConnection do
    begin
      LoginPrompt := False;
      Connected   := False;
    end;
  end;

  Application.Terminate;
end;

procedure TfConfigBD.btnLocalizarClick(Sender: TObject);
begin
  OpenDialog.InitialDir := ExtractFilePath(Application.ExeName);

  if OpenDialog.Execute then
    edtPatch.Text := OpenDialog.FileName;
end;

end.

unit DM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  System.UITypes;

type
  TfDM = class(TDataModule)
    FDTransaction: TFDTransaction;
    FDConnection: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fDM: TfDM;

implementation

uses
  Vcl.Dialogs, Vcl.Forms, ConfigBD, FuncaoGenerica;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TfDM.DataModuleCreate(Sender: TObject);
begin
  try
    with FDConnection do
    begin
      Params.Database := LerINI.IP + ':' + LerINI.Patch;
      LoginPrompt     := False;
      Connected       := True;
    end;
  except
    MessageDlg('Configure o arquivo ini para conexão com o banco de dados!' ,mtConfirmation,[mbyes],0);

    Application.CreateForm(TfConfigBD, fConfigBD);
    fConfigBD.ShowModal;
    Exit;
  end;
end;

end.

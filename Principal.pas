unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Actions,
  Vcl.ActnList, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage;

type
  TfPrincipal = class(TForm)
    PFundoTop: TPanel;
    ImgLogo: TImage;
    Panel2: TPanel;
    PFundoLeft: TPanel;
    btnCliente: TButton;
    PanelWorkArea: TPanel;
    StatusBar: TStatusBar;
    ActionList: TActionList;
    ActionCadCliente: TAction;
    TimerStatus: TTimer;
    btnProduto: TButton;
    ActionCadProduto: TAction;
    btnPedido: TButton;
    ActionCadPedido: TAction;
    procedure FormCreate(Sender: TObject);
    procedure TimerStatusTimer(Sender: TObject);
    procedure ActionCadClienteExecute(Sender: TObject);
    procedure ActionCadProdutoExecute(Sender: TObject);
    procedure ActionCadPedidoExecute(Sender: TObject);
  private
    { Private declarations }
    procedure LoadForm(AClass: TFormClass);
  public
    { Public declarations }
    FFormActive: TForm;
  end;

var
  fPrincipal: TfPrincipal;

implementation

{$R *.dfm}

uses CadCliente, CadProduto, CadPedido;

procedure TfPrincipal.ActionCadClienteExecute(Sender: TObject);
begin
  Self.LoadForm(TfCadCliente);
end;

procedure TfPrincipal.ActionCadPedidoExecute(Sender: TObject);
begin
  Self.LoadForm(TfCadPedido);
end;

procedure TfPrincipal.ActionCadProdutoExecute(Sender: TObject);
begin
  Self.LoadForm(TfCadProduto);
end;

procedure TfPrincipal.FormCreate(Sender: TObject);
begin
  Self.WindowState := TWindowState.wsMaximized;
  Statusbar.Panels[0].Text := 'Edson Renato';
end;

procedure TfPrincipal.LoadForm(AClass: TFormClass);
begin
  if Assigned(Self.FFormActive) then
  begin
    Self.FFormActive.Close;
    Self.FFormActive.Free;
    Self.FFormActive := nil;
  end;

  Self.FFormActive             := AClass.Create(nil);
  Self.FFormActive.Parent      := Self.PanelWorkArea;
  Self.FFormActive.BorderStyle := TFormBorderStyle.bsNone;

  Self.FFormActive.Top   := 0;
  Self.FFormActive.Left  := 0;
  Self.FFormActive.Align := TAlign.alClient;

  Self.FFormActive.Show;
end;

procedure TfPrincipal.TimerStatusTimer(Sender: TObject);
begin
  Statusbar.Panels[1].Text := FormatDatetime('DD/MM/YYYY',Date) + ' - ' + FormatDatetime('HH:MM:SS',Time);
end;

end.

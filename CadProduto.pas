unit CadProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, Produto,
  System.Generics.Collections, FireDAC.Comp.Client;

type
  TfCadProduto = class(TForm)
    pFundo: TPanel;
    Label12: TLabel;
    Label1: TLabel;
    edtCodigo: TEdit;
    edtDescricao: TEdit;
    pBotoes: TPanel;
    btnNovo: TButton;
    btnCancelar: TButton;
    btnGravar: TButton;
    btnEditar: TButton;
    btnSair: TButton;
    btnExcluir: TButton;
    btnAnterior: TButton;
    btnProximo: TButton;
    Label2: TLabel;
    edtValorUnit: TEdit;
    procedure edtValorUnitExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edtValorUnitKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FLista : TList<IProduto>;
    FIndex : Integer;
    procedure HabilitarBotao;
    procedure Carregar;
    procedure CarregarComponente(const aIndex: Integer);
  public
    { Public declarations }
  end;

var
  fCadProduto: TfCadProduto;

implementation

{$R *.dfm}

uses FuncaoGenerica, Principal, DM;

procedure TfCadProduto.btnAnteriorClick(Sender: TObject);
begin
  if FIndex > 0 then
    FIndex := FIndex - 1;

  CarregarComponente(FIndex);
end;

procedure TfCadProduto.btnCancelarClick(Sender: TObject);
begin
  HabilitarBotao;
  CarregarComponente(0);
end;

procedure TfCadProduto.btnEditarClick(Sender: TObject);
begin
  HabilitarBotao;
  CarregarComponente(FIndex);
  edtDescricao.SetFocus;
end;

procedure TfCadProduto.btnExcluirClick(Sender: TObject);
var
  xProduto : IProduto;
begin
  try
    xProduto    := TProduto.Create(fDM.FDConnection);
    xProduto.ID := StrToInt(edtCodigo.Text);
    xProduto.Deletar;

    FLista.Delete(FIndex);
    ShowMessage('Deletado com sucesso!');
  finally
    FIndex := 0;
    CarregarComponente(FIndex);
  end;
end;

procedure TfCadProduto.btnGravarClick(Sender: TObject);
var
  xProduto : IProduto;
begin
  ComponenteObrigatorio(fPrincipal.FFormActive, 1);

  try
    xProduto               := TProduto.Create(fDM.FDConnection);
    xProduto.ID            := StrToIntDef(edtCodigo.Text,0);
    xProduto.ID_Atual      := RetornoID_Proximo(fPrincipal.FFormActive.Name);
    xProduto.Descricao     := edtDescricao.Text;
    xProduto.ValorUnitario := StrToCurr(edtValorUnit.Text);

    if StrToIntDef(edtCodigo.Text,0) = 0 then
      FLista.Add(xProduto)
    else
    begin
      FLista.Items[FIndex].ID           := StrToInt(edtCodigo.Text);
      FLista.Items[FIndex].ID_Atual     := StrToInt(edtCodigo.Text);
      FLista.Items[FIndex].Descricao    := edtDescricao.Text;
      FLista.Items[FIndex].ValorUnitario:= StrToCurr(edtValorUnit.Text);
    end;

    xProduto.Gravar;
    ShowMessage('Gravado com sucesso!');
  finally
    FIndex := 0;
    CarregarComponente(FIndex);
    HabilitarBotao;
  end;

end;

procedure TfCadProduto.btnNovoClick(Sender: TObject);
begin
  HabilitarBotao;
  LimparComponente(fPrincipal.FFormActive, 1);
  edtDescricao.SetFocus;
end;

procedure TfCadProduto.btnProximoClick(Sender: TObject);
begin
  if FIndex < Pred(FLista.Count) then
    FIndex := FIndex + 1;

  CarregarComponente(FIndex);
end;

procedure TfCadProduto.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfCadProduto.edtValorUnitExit(Sender: TObject);
begin
  edtValorUnit.Text:= FormatFloat('###,##0.00', StrtoFloat(edtValorUnit.Text));
end;

procedure TfCadProduto.edtValorUnitKeyPress(Sender: TObject; var Key: Char);
begin
  if not(CharInSet(key, ['0'..'9',',',#8])) then
    key := #0;
end;

procedure TfCadProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FLista);

  FreeAndNil(fCadProduto);
end;

procedure TfCadProduto.FormCreate(Sender: TObject);
begin
  HabilitarBotao;
  FIndex := 0;

  FLista := TList<IProduto>.Create;
end;

procedure TfCadProduto.FormShow(Sender: TObject);
begin
  Carregar;
  CarregarComponente(FIndex);
end;

procedure TfCadProduto.Carregar;
var
  xQryDados : TFDQuery;
  xProduto : IProduto;
begin
  try
    xQryDados := TFDQuery.Create(Self);

    xQryDados.Connection := fDM.FDConnection;

    xQryDados.Close;
    xQryDados.SQL.Clear;
    xQryDados.SQL.Add('SELECT * FROM PRODUTO');
    xQryDados.Open;

    xQryDados.First;
    while not xQryDados.Eof do
    begin
      xProduto              := TProduto.Create(fDM.FDConnection);
      xProduto.ID           := xQryDados.FieldByName('ID_PRODUTO').AsInteger;
      xProduto.ID_Atual     := xQryDados.FieldByName('ID_PRODUTO').AsInteger;
      xProduto.Descricao    := xQryDados.FieldByName('DESCRICAO').AsString;
      xProduto.ValorUnitario:= xQryDados.FieldByName('VALOR_UNITARIO').AsCurrency;

      FLista.Add(xProduto);

      xQryDados.Next;
    end;

    FreeAndNil(xQryDados);
  except
    raise Exception.Create('Não foi possível exibir as informações do cliente');
  end;
end;

procedure TfCadProduto.CarregarComponente(const aIndex : Integer);
begin
  if FLista.Count > 0 then
  begin
    edtCodigo.Text    := IntToStr(FLista.Items[aIndex].ID_Atual);
    edtDescricao.Text := FLista.Items[aIndex].Descricao;
    edtValorUnit.Text := FormatFloat('###,##0.00', FLista.Items[aIndex].ValorUnitario);
  end
  else
    LimparComponente(fPrincipal.FFormActive, 1);
end;

procedure TfCadProduto.HabilitarBotao;
begin
  pFundo.Enabled      := not pFundo.Enabled;
  btnAnterior.Enabled := not pFundo.Enabled;
  btnProximo.Enabled  := not pFundo.Enabled;
  btnNovo.Enabled     := not pFundo.Enabled;
  btnEditar.Enabled   := not pFundo.Enabled;
  btnExcluir.Enabled  := not pFundo.Enabled;
  btnGravar.Enabled   := pFundo.Enabled;
  btnCancelar.Enabled := pFundo.Enabled;
end;

end.

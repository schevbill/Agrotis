unit CadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  System.Generics.Collections, Cliente, System.Classes, FireDAC.Comp.Client,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, REST.Types,
  REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope;

type
  TfCadCliente = class(TForm)
    pFundo: TPanel;
    Label12: TLabel;
    Label1: TLabel;
    gbEndereco: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    pBotoes: TPanel;
    btnNovo: TButton;
    btnCancelar: TButton;
    btnGravar: TButton;
    btnEditar: TButton;
    btnSair: TButton;
    btnExcluir: TButton;
    Label2: TLabel;
    btnAnterior: TButton;
    btnProximo: TButton;
    CBUF: TComboBox;
    edtCodigo: TEdit;
    edtNome: TEdit;
    edtCEP: TEdit;
    edtIBGE: TEdit;
    edtEnd: TEdit;
    edtNum: TEdit;
    edtComplemento: TEdit;
    edtBairro: TEdit;
    edtCidade: TEdit;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
    FDMemTable: TFDMemTable;
    procedure FormCreate(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtCEPExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FLista : TList<ICliente>;
    FIndex : Integer;
    procedure HabilitarBotao;
    procedure Carregar;
    procedure CarregarComponente(const aIndex : Integer);
  public
    { Public declarations }
  end;

var
  fCadCliente: TfCadCliente;

implementation

uses
  DM, FuncaoGenerica, Principal, MaskUtils;

{$R *.dfm}

procedure TfCadCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FLista);
  FreeAndNil(fCadCliente);
end;

procedure TfCadCliente.FormCreate(Sender: TObject);
begin
  HabilitarBotao;
  FIndex := 0;

  FLista := TList<ICliente>.Create;
end;

procedure TfCadCliente.FormShow(Sender: TObject);
begin
  Carregar;
  CarregarComponente(FIndex);
end;

procedure TfCadCliente.HabilitarBotao;
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

procedure TfCadCliente.btnAnteriorClick(Sender: TObject);
begin
  if FIndex > 0 then
    FIndex := FIndex - 1;

  CarregarComponente(FIndex);
end;

procedure TfCadCliente.btnCancelarClick(Sender: TObject);
begin
  HabilitarBotao;
  CarregarComponente(0);
end;

procedure TfCadCliente.btnEditarClick(Sender: TObject);
begin
  HabilitarBotao;
  CarregarComponente(FIndex);
  edtNome.SetFocus;
end;

procedure TfCadCliente.btnExcluirClick(Sender: TObject);
var
  xCliente : ICliente;
begin
  try
    xCliente    := TCliente.Create(fDM.FDConnection);
    xCliente.ID := StrToInt(edtCodigo.Text);
    xCliente.Deletar;

    FLista.Delete(FIndex);
    ShowMessage('Deletado com sucesso!');
  finally
    FIndex := 0;
    CarregarComponente(FIndex);
  end;
end;

procedure TfCadCliente.btnGravarClick(Sender: TObject);
var
  xCliente : ICliente;
begin
  ComponenteObrigatorio(fPrincipal.FFormActive, 1);

  try
    xCliente             := TCliente.Create(fDM.FDConnection);
    xCliente.ID          := StrToIntDef(edtCodigo.Text,0);
    xCliente.ID_Atual    := RetornoID_Proximo(fPrincipal.FFormActive.Name);
    xCliente.Nome        := edtNome.Text;
    xCliente.CEP         := edtCEP.Text;
    xCliente.IBGE        := StrToIntDef(edtIBGE.Text,0);
    xCliente.Endereco    := edtEnd.Text;
    xCliente.Num         := edtNum.Text;
    xCliente.Complemento := edtComplemento.Text;
    xCliente.Bairro      := edtBairro.Text;
    xCliente.Cidade      := edtCidade.Text;
    xCliente.UF          := CBUF.Text;

    if StrToIntDef(edtCodigo.Text,0) = 0 then
      FLista.Add(xCliente)
    else
    begin
      FLista.Items[FIndex].ID          := StrToInt(edtCodigo.Text);
      FLista.Items[FIndex].ID_Atual    := StrToInt(edtCodigo.Text);
      FLista.Items[FIndex].Nome        := edtnome.Text;
      FLista.Items[FIndex].CEP         := edtCEP.Text;
      FLista.Items[FIndex].IBGE        := StrToInt(edtIBGE.Text);
      FLista.Items[FIndex].Endereco    := edtEnd.Text;
      FLista.Items[FIndex].Num         := edtNum.Text;
      FLista.Items[FIndex].Complemento := edtComplemento.Text;
      FLista.Items[FIndex].Bairro      := edtBairro.Text;
      FLista.Items[FIndex].Cidade      := edtCidade.Text;
      FLista.Items[FIndex].UF          := CBUF.Text;
    end;

    xCliente.Gravar;
    ShowMessage('Gravado com sucesso!');
  finally
    FIndex := 0;
    CarregarComponente(FIndex);
    HabilitarBotao;
  end;
end;

procedure TfCadCliente.btnNovoClick(Sender: TObject);
begin
  HabilitarBotao;
  LimparComponente(fPrincipal.FFormActive, 1);
  edtNome.SetFocus;
end;

procedure TfCadCliente.btnProximoClick(Sender: TObject);
begin
  if FIndex < Pred(FLista.Count) then
    FIndex := FIndex + 1;

  CarregarComponente(FIndex);
end;

procedure TfCadCliente.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfCadCliente.Carregar;
var
  xQryDados : TFDQuery;
  xCliente : ICliente;
begin
  try
    xQryDados := TFDQuery.Create(Self);

    xQryDados.Connection := fDM.FDConnection;

    xQryDados.Close;
    xQryDados.SQL.Clear;
    xQryDados.SQL.Add('SELECT * FROM CLIENTE');
    xQryDados.Open;

    xQryDados.First;
    while not xQryDados.Eof do
    begin
      xCliente             := TCliente.Create(fDM.FDConnection);
      xCliente.ID          := xQryDados.FieldByName('ID_CLIENTE').AsInteger;
      xCliente.ID_Atual    := xQryDados.FieldByName('ID_CLIENTE').AsInteger;
      xCliente.Nome        := xQryDados.FieldByName('NOME').AsString;
      xCliente.CEP         := xQryDados.FieldByName('CEP').AsString;
      xCliente.IBGE        := xQryDados.FieldByName('IBGE').AsInteger;
      xCliente.Endereco    := xQryDados.FieldByName('LOGRADOURO').AsString;
      xCliente.Num         := xQryDados.FieldByName('NUMERO').AsString;
      xCliente.Complemento := xQryDados.FieldByName('COMPLEMENTO').AsString;
      xCliente.Bairro      := xQryDados.FieldByName('BAIRRO').AsString;
      xCliente.Cidade      := xQryDados.FieldByName('CIDADE').AsString;
      xCliente.UF          := xQryDados.FieldByName('UF').AsString;

      FLista.Add(xCliente);

      xQryDados.Next;
    end;

    FreeAndNil(xQryDados);
  except
    raise Exception.Create('Não foi possível exibir as informações do cliente');
  end;
end;

procedure TfCadCliente.CarregarComponente(const aIndex : Integer);
begin
  if FLista.Count > 0 then
  begin
    edtCodigo.Text      := IntToStr(FLista.Items[aIndex].ID_Atual);
    edtNome.Text        := FLista.Items[aIndex].Nome;
    edtCEP.Text         := FLista.Items[aIndex].CEP;
    edtIBGE.Text        := IntToStr(FLista.Items[aIndex].IBGE);
    edtEnd.Text         := FLista.Items[aIndex].Endereco;
    edtNum.Text         := FLista.Items[aIndex].Num;
    edtComplemento.Text := FLista.Items[aIndex].Complemento;
    edtBairro.Text      := FLista.Items[aIndex].Bairro;
    edtCidade.Text      := FLista.Items[aIndex].Cidade;
    CBUF.ItemIndex      := CBUF.Items.IndexOf(FLista.Items[aIndex].UF);
  end
  else
    LimparComponente(fPrincipal.FFormActive, 1);
end;

procedure TfCadCliente.edtCEPExit(Sender: TObject);
begin
  if not SameText(edtCEP.Text, '') then
  begin
    RESTClient.BaseURL := 'http://viacep.com.br/ws/' + edtCEP.Text + '/json';
    RESTRequest.Execute;

    edtIBGE.Text       := FDMemTable.FieldByName('ibge').AsString;
    edtEnd.Text        := FDMemTable.FieldByName('logradouro').AsString;
    edtComplemento.Text:= FDMemTable.FieldByName('complemento').AsString;
    edtBairro.Text     := FDMemTable.FieldByName('bairro').AsString;
    edtCidade.Text     := FDMemTable.FieldByName('localidade').AsString;
    CBUF.ItemIndex     := CBUF.Items.IndexOf(FDMemTable.FieldByName('uf').AsString);
  end;
end;

end.

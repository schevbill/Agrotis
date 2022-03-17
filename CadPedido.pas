unit CadPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, System.Generics.Collections,
  Pedido, PedidoItem, FireDAC.Comp.Client, FireDAC.Stan.Param;

type
  TfCadPedido = class(TForm)
    pFundoPedido: TPanel;
    pFundoPedidoItem: TPanel;
    pFundo: TPanel;
    Label12: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edtCodigo: TEdit;
    edtReferencia: TEdit;
    edtNumPedido: TEdit;
    pBotoes: TPanel;
    btnNovo: TButton;
    btnCancelar: TButton;
    btnGravar: TButton;
    btnEditar: TButton;
    btnSair: TButton;
    btnExcluir: TButton;
    btnAnterior: TButton;
    btnProximo: TButton;
    pFundoItem: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtCodigoItem: TEdit;
    edtNumPedidoItem: TEdit;
    edtQtd: TEdit;
    pBotoesItem: TPanel;
    btnNovoItem: TButton;
    btnCancelarItem: TButton;
    btnGravarItem: TButton;
    btnEditarItem: TButton;
    btnExcluirItem: TButton;
    btnAnteriorItem: TButton;
    btnProximoItem: TButton;
    Label6: TLabel;
    edtCodProduto: TEdit;
    Label7: TLabel;
    edtDescricaoProd: TEdit;
    Label8: TLabel;
    edtVlrUnit: TEdit;
    edtTotalItem: TEdit;
    Label9: TLabel;
    edtData: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    edtCodCliente: TEdit;
    edtNomeCliente: TEdit;
    cbTipo: TComboBox;
    edtVlrTotalPedido: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtDataChange(Sender: TObject);
    procedure edtNumPedidoEnter(Sender: TObject);
    procedure btnAnteriorItemClick(Sender: TObject);
    procedure btnProximoItemClick(Sender: TObject);
    procedure btnNovoItemClick(Sender: TObject);
    procedure btnEditarItemClick(Sender: TObject);
    procedure btnExcluirItemClick(Sender: TObject);
    procedure btnGravarItemClick(Sender: TObject);
    procedure btnCancelarItemClick(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure edtQtdExit(Sender: TObject);
  private
    { Private declarations }
    FLista : TList<IPedido>;
    FIndex : Integer;

    FListaItem : TList<IItem>;
    FIndexItem : Integer;

    procedure HabilitarBotao;
    procedure HabilitarBotao_Item;
    procedure Carregar;
    procedure CarregarItem(const aID_Pedido: Integer);

    procedure CarregarComponente(const aIndex: Integer);
    procedure CarregarComponenteItem(const aIndex: Integer);
    function ValorTotalItem(const aID_Pedido: Integer): Currency;
    procedure AtualizarTotal(const aIndexPedido : Integer; const aID_Pedido : Integer);
  public
    { Public declarations }
  end;

var
  fCadPedido: TfCadPedido;

implementation

{$R *.dfm}

uses DM, FuncaoGenerica, Principal;

procedure TfCadPedido.btnAnteriorClick(Sender: TObject);
begin
  if FIndex > 0 then
    FIndex := FIndex - 1;

  CarregarComponente(FIndex);
end;

procedure TfCadPedido.btnAnteriorItemClick(Sender: TObject);
begin
  if FIndexItem > 0 then
    FIndexItem := FIndexItem - 1;

  CarregarComponenteItem(FIndexItem);
end;

procedure TfCadPedido.btnCancelarClick(Sender: TObject);
begin
  HabilitarBotao;
  CarregarComponente(0);
end;

procedure TfCadPedido.btnCancelarItemClick(Sender: TObject);
begin
  HabilitarBotao_Item;
  CarregarComponenteItem(0);
end;

procedure TfCadPedido.btnEditarClick(Sender: TObject);
begin
  HabilitarBotao;
  CarregarComponente(FIndex);
  edtReferencia.SetFocus;
end;

procedure TfCadPedido.btnEditarItemClick(Sender: TObject);
begin
  HabilitarBotao_Item;
  CarregarComponenteItem(FIndexItem);
  edtCodProduto.SetFocus;
end;

procedure TfCadPedido.btnExcluirClick(Sender: TObject);
var
  xPedido : IPedido;
begin
  try
    xPedido    := TPedido.Create(fDM.FDConnection);
    xPedido.ID := StrToInt(edtCodigo.Text);
    xPedido.Deletar;

    FLista.Delete(FIndex);

    ShowMessage('Deletado com sucesso!');
  finally
    FIndex := 0;
    CarregarComponente(FIndex);
  end;
end;

procedure TfCadPedido.btnExcluirItemClick(Sender: TObject);
var
  xItem : IItem;
begin
  try
    xItem    := TItem.Create(fDM.FDConnection);
    xItem.ID := StrToInt(edtCodigoItem.Text);
    xItem.Deletar;

    FListaItem.Delete(FIndexItem);

    AtualizarTotal(FIndex, StrToInt(edtCodigo.Text));

    ShowMessage('Deletado com sucesso!');
  finally
    FIndexItem := 0;
    CarregarComponenteItem(FIndexItem);
  end;
end;

procedure TfCadPedido.btnGravarClick(Sender: TObject);
var
  xPedido : IPedido;
begin
  ComponenteObrigatorio(fPrincipal.FFormActive, 1);

  try
    xPedido               := TPedido.Create(fDM.FDConnection);
    xPedido.ID            := StrToIntDef(edtCodigo.Text,0);
    xPedido.ID_Atual      := RetornoID_Proximo(fPrincipal.FFormActive.Name, 0);
    xPedido.Referencia    := edtReferencia.Text;
    xPedido.Num_Pedido    := StrToInt(edtNumPedido.Text);
    xPedido.Data_Emissao  := StrToDate(edtData.Text);
    xPedido.ID_Cliente    := StrToInt(edtCodCliente.Text);
    xPedido.Nome_Cliente  := edtNomeCliente.Text;
    xPedido.Tipo_Operacao := cbTipo.Text;
    xPedido.Total_Pedido  := StrToCurrDef(edtVlrTotalPedido.Text,0.00);

    if StrToIntDef(edtCodigo.Text,0) = 0 then
      FLista.Add(xPedido)
    else
    begin
      FLista.Items[FIndex].ID            := StrToInt(edtCodigo.Text);
      FLista.Items[FIndex].ID_Atual      := StrToInt(edtCodigo.Text);
      FLista.Items[FIndex].Referencia    := edtReferencia.Text;
      FLista.Items[FIndex].Num_Pedido    := StrToInt(edtNumPedido.Text);
      FLista.Items[FIndex].Data_Emissao  := StrToDate(edtData.Text);
      FLista.Items[FIndex].ID_Cliente    := StrToInt(edtCodCliente.Text);
      FLista.Items[FIndex].Nome_Cliente  := edtNomeCliente.Text;
      FLista.Items[FIndex].Tipo_Operacao := cbTipo.Text;
      FLista.Items[FIndex].Total_Pedido  := StrToCurr(edtVlrTotalPedido.Text);
    end;

    xPedido.Gravar;
    ShowMessage('Gravado com sucesso!');
  finally
    FIndex := 0;
    CarregarComponente(FIndex);
    HabilitarBotao;
  end;
end;

procedure TfCadPedido.btnGravarItemClick(Sender: TObject);
var
  xItem : IItem;
begin
  ComponenteObrigatorio(fPrincipal.FFormActive, 1);

  try
    xItem                := TItem.Create(fDM.FDConnection);
    xItem.ID             := StrToIntDef(edtCodigoItem.Text,0);
    xItem.ID_Atual       := RetornoID_Proximo(fPrincipal.FFormActive.Name, 2);
    xItem.ID_Pedido      := StrToInt(edtCodigo.Text);
    xItem.ID_Produto     := StrToInt(edtCodProduto.Text);
    xItem.Descricao_Prod := edtDescricaoProd.Text;
    xItem.Num_Pedido     := StrToInt(edtNumPedidoItem.Text);
    xItem.Quantidade     := StrToFloat(edtQtd.Text);
    xItem.Valor_Unitario := StrToCurr(edtVlrUnit.Text);
    xItem.Total_Item     := StrToCurr(edtTotalItem.Text);

    if StrToIntDef(edtCodigoItem.Text,0) = 0 then
      FListaItem.Add(xItem)
    else
    begin
      FListaItem.Items[FIndexItem].ID             := StrToInt(edtCodigoItem.Text);
      FListaItem.Items[FIndexItem].ID_Atual       := StrToInt(edtCodigoItem.Text);
      FListaItem.Items[FIndexItem].ID_Pedido      := StrToInt(edtCodigo.Text);
      FListaItem.Items[FIndexItem].ID_Produto     := StrToInt(edtCodProduto.Text);
      FListaItem.Items[FIndexItem].Descricao_Prod := edtDescricaoProd.Text;
      FListaItem.Items[FIndexItem].Num_Pedido     := StrToInt(edtNumPedidoItem.Text);
      FListaItem.Items[FIndexItem].Quantidade     := StrToFloat(edtQtd.Text);
      FListaItem.Items[FIndexItem].Valor_Unitario := StrToCurr(edtVlrUnit.Text);
      FListaItem.Items[FIndexItem].Total_Item     := StrToCurr(edtTotalItem.Text);
    end;

    xItem.Gravar;

    AtualizarTotal(FIndex, StrToInt(edtCodigo.Text));

    ShowMessage('Gravado com sucesso!');
  finally
    FIndexItem := 0;
    CarregarComponenteItem(FIndexItem);
    HabilitarBotao_Item;
  end;
end;

procedure TfCadPedido.btnNovoClick(Sender: TObject);
begin
  HabilitarBotao;
  LimparComponente(fPrincipal.FFormActive, 1);
  edtReferencia.SetFocus;
end;

procedure TfCadPedido.btnNovoItemClick(Sender: TObject);
begin
  HabilitarBotao_Item;
  LimparComponente(fPrincipal.FFormActive, 2);
  edtNumPedidoItem.Text := edtNumPedido.Text;
  edtCodProduto.SetFocus;
end;

procedure TfCadPedido.btnProximoClick(Sender: TObject);
begin
  if FIndex < Pred(FLista.Count) then
    FIndex := FIndex + 1;

  CarregarComponente(FIndex);
end;

procedure TfCadPedido.btnProximoItemClick(Sender: TObject);
begin
  if FIndexItem < Pred(FListaItem.Count) then
    FIndexItem := FIndexItem + 1;

  CarregarComponenteItem(FIndexItem);
end;

procedure TfCadPedido.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfCadPedido.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FLista);
  FreeAndNil(FListaItem);

  FreeAndNil(fCadPedido);
end;

procedure TfCadPedido.FormCreate(Sender: TObject);
begin
  HabilitarBotao;
  HabilitarBotao_Item;
  FIndex := 0;
  FIndexItem := 0;

  FLista := TList<IPedido>.Create;
  FListaItem := TList<IItem>.Create;
end;

procedure TfCadPedido.FormShow(Sender: TObject);
begin
  Carregar;
  CarregarComponente(FIndex);
end;

procedure TfCadPedido.Carregar;
var
  xQryDados : TFDQuery;
  xPedido : IPedido;
begin
  try
    xQryDados := TFDQuery.Create(Self);

    xQryDados.Connection := fDM.FDConnection;

    xQryDados.Close;
    xQryDados.SQL.Clear;
    xQryDados.SQL.Add('SELECT * FROM PEDIDO');
    xQryDados.Open;

    xQryDados.First;
    while not xQryDados.Eof do
    begin
      xPedido              := TPedido.Create(fDM.FDConnection);
      xPedido.ID           := xQryDados.FieldByName('ID_PEDIDO').AsInteger;
      xPedido.ID_Atual     := xQryDados.FieldByName('ID_PEDIDO').AsInteger;
      xPedido.Referencia   := xQryDados.FieldByName('REFERENCIA').AsString;
      xPedido.Num_Pedido   := xQryDados.FieldByName('NUM_PEDIDO').AsInteger;
      xPedido.Data_Emissao := xQryDados.FieldByName('DATA_EMISSAO').AsDateTime;
      xPedido.ID_Cliente   := xQryDados.FieldByName('ID_CLIENTE').AsInteger;
      xPedido.Nome_Cliente := xPedido.RetornoNomeCliente(xQryDados.FieldByName('ID_CLIENTE').AsInteger);
      xPedido.Tipo_Operacao:= xQryDados.FieldByName('TIPO_OPERACAO').AsString;
      xPedido.Total_Pedido := xQryDados.FieldByName('TOTAL_PEDIDO').AsCurrency;

      FLista.Add(xPedido);

      xQryDados.Next;
    end;

    FreeAndNil(xQryDados);
  except
    raise Exception.Create('Não foi possível exibir as informações do cliente');
  end;
end;

procedure TfCadPedido.CarregarItem(Const aID_Pedido : Integer);
var
  xQryDados : TFDQuery;
  xItem : IItem;
begin
  try
    xQryDados := TFDQuery.Create(Self);

    xQryDados.Connection := fDM.FDConnection;

    xQryDados.Close;
    xQryDados.SQL.Clear;
    xQryDados.SQL.Add('SELECT P.NUM_PEDIDO, I.* FROM PEDIDO_ITEM I ' +
                      'INNER JOIN PEDIDO P ON (P.ID_PEDIDO = I.ID_PEDIDO) ' +
                      'WHERE I.ID_PEDIDO = :ID_PEDIDO');
    xQryDados.ParamByName('ID_PEDIDO').AsInteger := aID_Pedido;
    xQryDados.Open;

    xQryDados.First;
    while not xQryDados.Eof do
    begin
      xItem                := TItem.Create(fDM.FDConnection);
      xItem.ID             := xQryDados.FieldByName('ID_PEDIDO_ITEM').AsInteger;
      xItem.ID_Atual       := xQryDados.FieldByName('ID_PEDIDO_ITEM').AsInteger;
      xItem.ID_Pedido      := xQryDados.FieldByName('ID_PEDIDO').AsInteger;
      xItem.ID_Produto     := xQryDados.FieldByName('ID_PRODUTO').AsInteger;
      xItem.Descricao_Prod := xItem.RetornoProduto(xQryDados.FieldByName('ID_PRODUTO').AsInteger).Descricao;
      xItem.Num_Pedido     := xQryDados.FieldByName('NUM_PEDIDO').AsInteger;
      xItem.Quantidade     := xQryDados.FieldByName('QUANTIDADE').AsFloat;
      xItem.Valor_Unitario := xQryDados.FieldByName('VALOR_UNITARIO').AsCurrency;
      xItem.Total_Item     := xQryDados.FieldByName('TOTAL_ITEM').AsCurrency;

      FListaItem.Add(xItem);

      xQryDados.Next;
    end;

    FreeAndNil(xQryDados);
  except
    raise Exception.Create('Não foi possível exibir as informações do cliente');
  end;
end;

procedure TfCadPedido.CarregarComponente(const aIndex : Integer);
var
  xI : Integer;
begin
  if FLista.Count > 0 then
  begin
    edtCodigo.Text        := IntToStr(FLista.Items[aIndex].ID_Atual);
    edtReferencia.Text    := FLista.Items[aIndex].Referencia;
    edtNumPedido.Text     := IntToStr(FLista.Items[aIndex].Num_Pedido);
    edtData.Text          := FormatDateTime('dd/mm/yyyy',FLista.Items[aIndex].Data_Emissao);
    edtCodCliente.Text    := IntToStr(FLista.Items[aIndex].ID_Cliente);
    edtNomeCliente.Text   := FLista.Items[aIndex].Nome_Cliente;
    cbTipo.ItemIndex      := cbTipo.Items.IndexOf(FLista.Items[aIndex].Tipo_Operacao);
    edtVlrTotalPedido.Text:= FormatFloat('###,##0.00', FLista.Items[aIndex].Total_Pedido);

    for xI := Pred(FListaItem.Count) downto 0 do
      FListaItem.Delete(xI);

    FIndexItem := 0;
    CarregarItem(FLista.Items[aIndex].ID_Atual);
    CarregarComponenteItem(0);
  end
  else
    LimparComponente(fPrincipal.FFormActive, 1);
end;

procedure TfCadPedido.CarregarComponenteItem(const aIndex : Integer);
begin
  if FListaItem.Count > 0 then
  begin
    edtCodigoItem.Text    := IntToStr(FListaItem.Items[aIndex].ID_Atual);
    edtNumPedidoItem.Text := IntToStr(FListaItem.Items[aIndex].Num_Pedido);
    edtCodProduto.Text    := IntToStr(FListaItem.Items[aIndex].ID_Produto);
    edtDescricaoProd.Text := FListaItem.Items[aIndex].Descricao_Prod;
    edtQtd.Text           := FormatFloat('###,##0.00', FListaItem.Items[aIndex].Quantidade);
    edtVlrUnit.Text       := FormatFloat('###,##0.00', FListaItem.Items[aIndex].Valor_Unitario);
    edtTotalItem.Text     := FormatFloat('###,##0.00', FListaItem.Items[aIndex].Total_Item);
  end
  else
    LimparComponente(fPrincipal.FFormActive, 2);
end;

procedure TfCadPedido.edtCodClienteExit(Sender: TObject);
var
  xPedido : IPedido;
begin
  xPedido := TPedido.Create(fDM.FDConnection);
  edtNomeCliente.Text := xPedido.RetornoNomeCliente(StrToInt(edtCodCliente.Text));
end;

procedure TfCadPedido.edtCodProdutoExit(Sender: TObject);
var
  xItem : IItem;
begin
  if not SameText(edtCodProduto.Text, '') then
  begin
    xItem := TItem.Create(fDM.FDConnection);
    edtDescricaoProd.Text := xItem.RetornoProduto(StrToInt(edtCodProduto.Text)).Descricao;
    edtVlrUnit.Text := FormatFloat('###,##0.00',xItem.RetornoProduto(StrToInt(edtCodProduto.Text)).VlrUnitario);
  end;
end;

procedure TfCadPedido.edtDataChange(Sender: TObject);
begin
  edtData.Text := Mascara(edtData.Text,'99/99/9999');
  edtData.SelStart := Length(edtData.Text);
end;

procedure TfCadPedido.edtNumPedidoEnter(Sender: TObject);
begin
  if SameText(edtNumPedido.Text, '') then
    edtNumPedido.Text := IntToStr(RetornoID_Proximo(fPrincipal.FFormActive.Name, 1));
end;

procedure TfCadPedido.edtQtdExit(Sender: TObject);
var
  xVlrUnit : Currency;
  xQtd : Double;
begin
  xVlrUnit := StrToCurrDef(edtVlrUnit.Text,0);
  xQtd := StrToFloatDef(edtQtd.Text,0);
  edtTotalItem.Text := FormatFloat('###,##0.00', (xVlrUnit * xQtd) );
end;

procedure TfCadPedido.HabilitarBotao;
begin
  pFundo.Enabled      := not pFundo.Enabled;
  btnAnterior.Enabled := not pFundo.Enabled;
  btnProximo.Enabled  := not pFundo.Enabled;
  btnNovo.Enabled     := not pFundo.Enabled;
  btnEditar.Enabled   := not pFundo.Enabled;
  btnExcluir.Enabled  := not pFundo.Enabled;
  btnGravar.Enabled   := pFundo.Enabled;
  btnCancelar.Enabled := pFundo.Enabled;

  pBotoesItem.Enabled := not pFundo.Enabled;
end;

procedure TfCadPedido.HabilitarBotao_Item;
begin
  pFundoItem.Enabled      := not pFundoItem.Enabled;
  btnAnteriorItem.Enabled := not pFundoItem.Enabled;
  btnProximoItem.Enabled  := not pFundoItem.Enabled;
  btnNovoItem.Enabled     := not pFundoItem.Enabled;
  btnEditarItem.Enabled   := not pFundoItem.Enabled;
  btnExcluirItem.Enabled  := not pFundoItem.Enabled;
  btnGravarItem.Enabled   := pFundoItem.Enabled;
  btnCancelarItem.Enabled := pFundoItem.Enabled;

  pBotoes.Enabled := not pFundoItem.Enabled;
end;

function TfCadPedido.ValorTotalItem(const aID_Pedido : Integer) : Currency;
var
  xQrySum : TFDQuery;
begin
  try
    xQrySum := TFDQuery.Create(Self);

    xQrySum.Connection := fDM.FDConnection;

    xQrySum.Close;
    xQrySum.SQL.Clear;
    xQrySum.SQL.Add('SELECT SUM(I.TOTAL_ITEM) AS TOTAL_PEDIDO FROM PEDIDO_ITEM I ' +
                    'INNER JOIN PEDIDO P ON (P.ID_PEDIDO = I.ID_PEDIDO) ' +
                    'WHERE I.ID_PEDIDO = :ID_PEDIDO');
    xQrySum.ParamByName('ID_PEDIDO').AsInteger := aID_Pedido;
    xQrySum.Open;

    Result := xQrySum.FieldByName('TOTAL_PEDIDO').AsCurrency;
  finally
    FreeAndNil(xQrySum);
  end;
end;

procedure TfCadPedido.AtualizarTotal(const aIndexPedido : Integer; const aID_Pedido : Integer);
var
  xQryUpdate : TFDQuery;
begin
  try
    FLista.Items[aIndexPedido].Total_Pedido := ValorTotalItem(aID_Pedido);
    edtVlrTotalPedido.Text := FormatFloat('###,##0.00',FLista.Items[aIndexPedido].Total_Pedido);

    xQryUpdate := TFDQuery.Create(Self);

    xQryUpdate.Connection := fDM.FDConnection;

    xQryUpdate.Close;
    xQryUpdate.SQL.Clear;
    xQryUpdate.SQL.Add('UPDATE PEDIDO SET TOTAL_PEDIDO = :TOTAL_PEDIDO ' +
                       'WHERE ID_PEDIDO = :ID_PEDIDO');
    xQryUpdate.ParamByName('TOTAL_PEDIDO').AsCurrency := FLista.Items[aIndexPedido].Total_Pedido;
    xQryUpdate.ParamByName('ID_PEDIDO').AsInteger := aID_Pedido;
    xQryUpdate.ExecSQL;
  finally
    FreeAndNil(xQryUpdate);
  end;
end;

end.

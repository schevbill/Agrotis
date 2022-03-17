unit PedidoItem;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Param;

type
  TProduto = record
    Descricao : string;
    VlrUnitario : Currency;
end;

type
  IItem = interface
    ['{7B13B655-0DD2-419C-9A17-3C8127F89E46}']
    procedure Gravar;
    procedure Deletar;
    function RetornoProduto(const aID_Produto: Integer): TProduto;

    function GetID: Integer;
    procedure SetID(const Value: Integer);
    property ID : Integer read GetID write SetID;

    function GetID_Atual: Integer;
    procedure SetID_Atual(const Value: Integer);
    property ID_Atual : Integer read GetID_Atual write SetID_Atual;

    function GetID_Pedido: Integer;
    procedure SetID_Pedido(const Value: Integer);
    property ID_Pedido : Integer read GetID_Pedido write SetID_Pedido;

    function GetID_Produto: Integer;
    procedure SetID_Produto(const Value: Integer);
    property ID_Produto : Integer read GetID_Produto write SetID_Produto;

    function GetDescricao_Prod: string;
    procedure SetDescricao_Prod(const Value: string);
    property Descricao_Prod : string read GetDescricao_Prod write SetDescricao_Prod;

    function GetNum_Pedido: Integer;
    procedure SetNum_Pedido(const Value: Integer);
    property Num_Pedido : Integer read GetNum_Pedido write SetNum_Pedido;

    function GetQuantidade: Double;
    procedure SetQuantidade(const Value: Double);
    property Quantidade : Double read GetQuantidade write SetQuantidade;

    function GetValor_Unitario: Currency;
    procedure SetValor_Unitario(const Value: Currency);
    property Valor_Unitario : Currency read GetValor_Unitario write SetValor_Unitario;

    function GetTotal_Item: Currency;
    procedure SetTotal_Item(const Value: Currency);
    property Total_Item : Currency read GetTotal_Item write SetTotal_Item;
end;

type
  TItem = class(TInterfacedObject, IItem)
    private
      FConn: TFDConnection;

      FID: Integer;
      FID_Atual: Integer;
      FID_Pedido: Integer;
      FID_Produto: Integer;
      FDescricao_Prod: string;
      FNum_Pedido: Integer;
      FQuantidade: Double;
      FValor_Unitario: Currency;
      FTotal_Item: Currency;

      function GetID: Integer;
      procedure SetID(const Value: Integer);
      function GetID_Atual: Integer;
      procedure SetID_Atual(const Value: Integer);
      function GetID_Pedido: Integer;
      procedure SetID_Pedido(const Value: Integer);
      function GetID_Produto: Integer;
      procedure SetID_Produto(const Value: Integer);
      function GetDescricao_Prod: string;
      procedure SetDescricao_Prod(const Value: string);
      function GetNum_Pedido: Integer;
      procedure SetNum_Pedido(const Value: Integer);
      function GetQuantidade: Double;
      procedure SetQuantidade(const Value: Double);
      function GetValor_Unitario: Currency;
      procedure SetValor_Unitario(const Value: Currency);
      function GetTotal_Item: Currency;
      procedure SetTotal_Item(const Value: Currency);
    public
      constructor Create(const aConn: TFDConnection);
      destructor Destroy; override;
      procedure Gravar;
      procedure Deletar;
      function RetornoProduto(const aID_Produto: Integer): TProduto;

      property ID : Integer read GetID write SetID;
      property ID_Atual : Integer read GetID_Atual write SetID_Atual;
      property ID_Pedido : Integer read GetID_Pedido write SetID_Pedido;
      property ID_Produto : Integer read GetID_Produto write SetID_Produto;
      property Descricao_Prod : string read GetDescricao_Prod write SetDescricao_Prod;
      property Num_Pedido : Integer read GetNum_Pedido write SetNum_Pedido;
      property Quantidade : Double read GetQuantidade write SetQuantidade;
      property Valor_Unitario : Currency read GetValor_Unitario write SetValor_Unitario;
      property Total_Item : Currency read GetTotal_Item write SetTotal_Item;
end;

implementation

{ TItem }

constructor TItem.Create(const aConn: TFDConnection);
begin
  FConn := aConn;
end;

procedure TItem.Deletar;
var
  xQryDados : TFDQuery;
begin
  xQryDados := TFDQuery.Create(nil);

  with xQryDados do
  begin
    Connection := FConn;

    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM PEDIDO_ITEM ' +
            'WHERE ID_PEDIDO_ITEM = :ID_PEDIDO_ITEM');

    ParamByName('ID_PEDIDO_ITEM').AsInteger := ID;
  end;

  try
    xQryDados.ExecSQL;
    FreeAndNil(xQryDados);
  except
    raise Exception.Create('Não foi possível apagar do banco!');
  end;
end;

function TItem.RetornoProduto(const aID_Produto: Integer): TProduto;
var
  xQryProduto : TFDQuery;
begin
  xQryProduto := TFDQuery.Create(nil);
  xQryProduto.Connection := FConn;

  xQryProduto.Close;
  xQryProduto.SQL.Clear;
  xQryProduto.SQL.Add('SELECT * FROM PRODUTO ' +
                      'WHERE ID_Produto = :ID_Produto');
  xQryProduto.ParamByName('ID_Produto').AsInteger := aID_Produto;
  xQryProduto.Open;

  if SameText(xQryProduto.FieldByName('DESCRICAO').AsString, '') then
    raise Exception.Create('Não tem produto cadastrado com este codigo')
  else
  begin
    Result.Descricao := xQryProduto.FieldByName('DESCRICAO').AsString;
    Result.VlrUnitario := xQryProduto.FieldByName('VALOR_UNITARIO').AsCurrency;
  end;

  FreeAndNil(xQryProduto);
end;

destructor TItem.Destroy;
begin

  inherited;
end;

function TItem.GetDescricao_Prod: string;
begin
  Result := FDescricao_Prod;
end;

function TItem.GetID: Integer;
begin
  Result := FID;
end;

function TItem.GetID_Atual: Integer;
begin
  Result := FID_Atual;
end;

function TItem.GetID_Pedido: Integer;
begin
  Result := FID_Pedido;
end;

function TItem.GetID_Produto: Integer;
begin
  Result := FID_Produto;
end;

function TItem.GetNum_Pedido: Integer;
begin
  Result := FNum_Pedido;
end;

function TItem.GetQuantidade: Double;
begin
  Result := FQuantidade;
end;

function TItem.GetTotal_Item: Currency;
begin
  Result := FTotal_Item;
end;

function TItem.GetValor_Unitario: Currency;
begin
  Result := FValor_Unitario;
end;

procedure TItem.Gravar;
var
  xQryDados : TFDQuery;
  xSQL : string;
begin
  if ID = 0 then
    xSQL := 'INSERT INTO PEDIDO_ITEM ' +
              '(ID_PEDIDO, ID_PRODUTO, QUANTIDADE, VALOR_UNITARIO, ' +
               'TOTAL_ITEM) ' +
            'VALUES ' +
              '(:ID_PEDIDO, :ID_PRODUTO, :QUANTIDADE, :VALOR_UNITARIO, ' +
               ':TOTAL_ITEM)'
  else
    xSQL := 'UPDATE PEDIDO_ITEM SET ' +
              'ID_PEDIDO = :ID_PEDIDO, ID_PRODUTO = :ID_PRODUTO, ' +
              'QUANTIDADE = :QUANTIDADE, VALOR_UNITARIO = :VALOR_UNITARIO, ' +
              'TOTAL_ITEM = :TOTAL_ITEM ' +
            'WHERE ID_PEDIDO_ITEM = :ID_PEDIDO_ITEM';

  xQryDados := TFDQuery.Create(nil);

  with xQryDados do
  begin
    Connection := FConn;

    Close;
    SQL.Clear;
    SQL.Add(xSQL);

    if ID > 0 then
      ParamByName('ID_PEDIDO_ITEM').AsInteger := ID;

    ParamByName('ID_PEDIDO').AsInteger       := ID_Pedido;
    ParamByName('ID_PRODUTO').AsInteger      := ID_Produto;
    ParamByName('QUANTIDADE').AsFloat        := Quantidade;
    ParamByName('VALOR_UNITARIO').AsCurrency := Valor_Unitario;
    ParamByName('TOTAL_ITEM').AsCurrency     := Total_Item;
  end;

  try
    xQryDados.ExecSQL;

    FreeAndNil(xQryDados);
  except
    raise Exception.Create('Não foi possível gravar no banco!!');
  end;
end;

procedure TItem.SetDescricao_Prod(const Value: string);
begin
  FDescricao_Prod := Value;
end;

procedure TItem.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TItem.SetID_Atual(const Value: Integer);
begin
  FID_Atual := Value;
end;

procedure TItem.SetID_Pedido(const Value: Integer);
begin
  FID_Pedido := Value;
end;

procedure TItem.SetID_Produto(const Value: Integer);
begin
  FID_Produto := Value;
end;

procedure TItem.SetNum_Pedido(const Value: Integer);
begin
  FNum_Pedido := Value;
end;

procedure TItem.SetQuantidade(const Value: Double);
begin
  FQuantidade := Value;
end;

procedure TItem.SetTotal_Item(const Value: Currency);
begin
  FTotal_Item := Value;
end;

procedure TItem.SetValor_Unitario(const Value: Currency);
begin
  FValor_Unitario := Value;
end;

end.

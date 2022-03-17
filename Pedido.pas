unit Pedido;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Param;

type
  IPedido = interface
    ['{0DD17623-CEEE-46B7-B280-53B4AD1EE18A}']
    procedure Gravar;
    procedure Deletar;
    function RetornoNomeCliente(const aID_Cliente: Integer): string;

    function GetID: Integer;
    procedure SetID(const Value: Integer);
    property ID : Integer read GetID write SetID;

    function GetID_Atual: Integer;
    procedure SetID_Atual(const Value: Integer);
    property ID_Atual : Integer read GetID_Atual write SetID_Atual;

    function GetReferencia: string;
    procedure SetReferencia(const Value: string);
    property Referencia : string read GetReferencia write SetReferencia;

    function GetNum_Pedido: Integer;
    procedure SetNum_Pedido(const Value: Integer);
    property Num_Pedido : Integer read GetNum_Pedido write SetNum_Pedido;

    function GetData_Emissao: TDate;
    procedure SetData_Emissao(const Value: TDate);
    property Data_Emissao : TDate read GetData_Emissao write SetData_Emissao;

    function GetID_Cliente: Integer;
    procedure SetID_Cliente(const Value: Integer);
    property ID_Cliente : Integer read GetID_Cliente write SetID_Cliente;

    function GetNome_Cliente: string;
    procedure SetNome_Cliente(const Value: string);
    property Nome_Cliente : string read GetNome_Cliente write SetNome_Cliente;

    function GetTipo_Operacao: string;
    procedure SetTipo_Operacao(const Value: string);
    property Tipo_Operacao : string read GetTipo_Operacao write SetTipo_Operacao;

    function GetTotal_Pedido: Currency;
    procedure SetTotal_Pedido(const Value: Currency);
    property Total_Pedido : Currency read GetTotal_Pedido write SetTotal_Pedido;
end;

type
  TPedido = class(TInterfacedObject, IPedido)
    private
      FConn: TFDConnection;

      FID: Integer;
      FID_Atual: Integer;
      FReferencia: string;
      FNum_Pedido: Integer;
      FData_Emissao: TDate;
      FID_Cliente: Integer;
      FNome_Cliente: string;
      FTipo_Operacao: string;
      FTotal_Pedido: Currency;

      function GetID: Integer;
      procedure SetID(const Value: Integer);
      function GetID_Atual: Integer;
      procedure SetID_Atual(const Value: Integer);
      function GetReferencia: string;
      procedure SetReferencia(const Value: string);
      function GetNum_Pedido: Integer;
      procedure SetNum_Pedido(const Value: Integer);
      function GetData_Emissao: TDate;
      procedure SetData_Emissao(const Value: TDate);
      function GetID_Cliente: Integer;
      procedure SetID_Cliente(const Value: Integer);
      function GetNome_Cliente: string;
      procedure SetNome_Cliente(const Value: string);
      function GetTipo_Operacao: string;
      procedure SetTipo_Operacao(const Value: string);
      function GetTotal_Pedido: Currency;
      procedure SetTotal_Pedido(const Value: Currency);

    public
      constructor Create(const aConn: TFDConnection);
      destructor Destroy; override;
      procedure Gravar;
      procedure Deletar;
      function RetornoNomeCliente(const aID_Cliente: Integer): string;

      property ID : Integer read GetID write SetID;
      property ID_Atual : Integer read GetID_Atual write SetID_Atual;
      property Referencia : string read GetReferencia write SetReferencia;
      property Num_Pedido : Integer read GetNum_Pedido write SetNum_Pedido;
      property Data_Emissao : TDate read GetData_Emissao write SetData_Emissao;
      property ID_Cliente : Integer read GetID_Cliente write SetID_Cliente;
      property Nome_Cliente : string read GetNome_Cliente write SetNome_Cliente;
      property Tipo_Operacao : string read GetTipo_Operacao write SetTipo_Operacao;
      property Total_Pedido : Currency read GetTotal_Pedido write SetTotal_Pedido;
end;

implementation

{ TPedido }

constructor TPedido.Create(const aConn: TFDConnection);
begin
  FConn := aConn;
end;

procedure TPedido.Deletar;
var
  xQryDados : TFDQuery;
begin
  xQryDados := TFDQuery.Create(nil);

  with xQryDados do
  begin
    Connection := FConn;

    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM PEDIDO ' +
            'WHERE ID_PEDIDO = :ID_PEDIDO');

    ParamByName('ID_PEDIDO').AsInteger := ID;
  end;

  try
    xQryDados.ExecSQL;
    FreeAndNil(xQryDados);
  except
    raise Exception.Create('Não foi possível apagar do banco!');
  end;
end;

destructor TPedido.Destroy;
begin

  inherited;
end;

function TPedido.GetData_Emissao: TDate;
begin
  Result := FData_Emissao;
end;

function TPedido.GetID: Integer;
begin
  Result := FID;
end;

function TPedido.GetID_Atual: Integer;
begin
  Result := FID_Atual;
end;

function TPedido.GetID_Cliente: Integer;
begin
  Result := FID_Cliente;
end;

function TPedido.GetNome_Cliente: string;
begin
  Result := FNome_Cliente;
end;

function TPedido.GetNum_Pedido: Integer;
begin
  Result := FNum_Pedido;
end;

function TPedido.GetReferencia: string;
begin
  Result := FReferencia;
end;

function TPedido.GetTipo_Operacao: string;
begin
  Result := FTipo_Operacao;
end;

function TPedido.GetTotal_Pedido: Currency;
begin
  Result := FTotal_Pedido;
end;

procedure TPedido.Gravar;
var
  xQryDados : TFDQuery;
  xSQL : string;
begin
  if ID = 0 then
    xSQL := 'INSERT INTO PEDIDO ' +
              '(REFERENCIA, DATA_EMISSAO, ID_CLIENTE, TIPO_OPERACAO, ' +
               'TOTAL_PEDIDO) ' +
            'VALUES ' +
              '(:REFERENCIA, :DATA_EMISSAO, :ID_CLIENTE, :TIPO_OPERACAO, ' +
               ':TOTAL_PEDIDO)'

  else
    xSQL := 'UPDATE PEDIDO SET ' +
              'REFERENCIA = :REFERENCIA, DATA_EMISSAO = :DATA_EMISSAO, ' +
              'ID_CLIENTE = :ID_CLIENTE, TIPO_OPERACAO = :TIPO_OPERACAO, ' +
              'TOTAL_PEDIDO = :TOTAL_PEDIDO ' +
            'WHERE ID_PEDIDO = :ID_PEDIDO';

  xQryDados := TFDQuery.Create(nil);

  with xQryDados do
  begin
    Connection := FConn;

    Close;
    SQL.Clear;
    SQL.Add(xSQL);

    if ID > 0 then
      ParamByName('ID_PEDIDO').AsInteger := ID;

    ParamByName('REFERENCIA').AsString    := Referencia;
    ParamByName('DATA_EMISSAO').AsDate    := Data_Emissao;
    ParamByName('ID_CLIENTE').AsInteger   := ID_Cliente;
    ParamByName('TIPO_OPERACAO').AsString := Tipo_Operacao;
    ParamByName('TOTAL_PEDIDO').AsCurrency:= Total_Pedido;
  end;

  try
    xQryDados.ExecSQL;

    FreeAndNil(xQryDados);
  except
    raise Exception.Create('Não foi possível gravar no banco!!');
  end;
end;

function TPedido.RetornoNomeCliente(const aID_Cliente: Integer): string;
var
  xQryCliente : TFDQuery;
begin
  xQryCliente := TFDQuery.Create(nil);
  xQryCliente.Connection := FConn;

  xQryCliente.Close;
  xQryCliente.SQL.Clear;
  xQryCliente.SQL.Add('SELECT NOME FROM CLIENTE ' +
                      'WHERE ID_CLIENTE = :ID_CLIENTE');
  xQryCliente.ParamByName('ID_CLIENTE').AsInteger := aID_Cliente;
  xQryCliente.Open;

  if SameText(xQryCliente.FieldByName('NOME').AsString, '') then
    raise Exception.Create('Não tem cliente cadastrado com este codigo')
  else
    Result := xQryCliente.FieldByName('NOME').AsString;

  FreeAndNil(xQryCliente);
end;

procedure TPedido.SetData_Emissao(const Value: TDate);
begin
  FData_Emissao := Value;
end;

procedure TPedido.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TPedido.SetID_Atual(const Value: Integer);
begin
  FID_Atual := Value;
end;

procedure TPedido.SetID_Cliente(const Value: Integer);
begin
  FID_Cliente := Value;
end;

procedure TPedido.SetNome_Cliente(const Value: string);
begin
  FNome_Cliente := Value;
end;

procedure TPedido.SetNum_Pedido(const Value: Integer);
begin
  FNum_Pedido := Value;
end;

procedure TPedido.SetReferencia(const Value: string);
begin
  FReferencia := Value;
end;

procedure TPedido.SetTipo_Operacao(const Value: string);
begin
  FTipo_Operacao := Value;
end;

procedure TPedido.SetTotal_Pedido(const Value: Currency);
begin
  FTotal_Pedido := Value;
end;

end.

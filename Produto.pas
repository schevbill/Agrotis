unit Produto;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Param;

type
  IProduto = interface
    ['{BDFEEB65-508A-4E49-AC9F-95901D811815}']
    function GetID: Integer;
    procedure SetID(const Value: Integer);
    property ID : Integer read GetID write SetID;

    function GetID_Atual: Integer;
    procedure SetID_Atual(const Value: Integer);
    property ID_Atual : Integer read GetID_Atual write SetID_Atual;

    function GetDescricao: string;
    procedure SetDescricao(const Value: string);
    property Descricao : string read GetDescricao write SetDescricao;

    function GetValorUnitario: Currency;
    procedure SetValorUnitario(const Value: Currency);
    property ValorUnitario : Currency read GetValorUnitario write SetValorUnitario;

    procedure Gravar;
    procedure Deletar;
end;

type
  TProduto = class(TInterfacedObject, IProduto)
    private
      FConn: TFDConnection;

      FID: Integer;
      FID_Atual: Integer;
      FDescricao: string;
      FValorUnitario: Currency;

      function GetID: Integer;
      procedure SetID(const Value: Integer);
      function GetID_Atual: Integer;
      procedure SetID_Atual(const Value: Integer);
      function GetDescricao: string;
      procedure SetDescricao(const Value: string);
      function GetValorUnitario: Currency;
      procedure SetValorUnitario(const Value: Currency);
    public
      constructor Create(const aConn: TFDConnection);
      destructor Destroy; override;
      procedure Gravar;
      procedure Deletar;

      property ID : Integer read GetID write SetID;
      property ID_Atual : Integer read GetID_Atual write SetID_Atual;
      property Descricao : string read GetDescricao write SetDescricao;
      property ValorUnitario : Currency read GetValorUnitario write SetValorUnitario;
end;

implementation

{ TProduto }

constructor TProduto.Create(const aConn: TFDConnection);
begin
  FConn := aConn;
end;

procedure TProduto.Deletar;
var
  xQryDados : TFDQuery;
begin
  xQryDados := TFDQuery.Create(nil);

  with xQryDados do
  begin
    Connection := FConn;

    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM PRODUTO ' +
            'WHERE ID_PRODUTO = :ID_PRODUTO');

    ParamByName('ID_PRODUTO').AsInteger := ID;
  end;

  try
    xQryDados.ExecSQL;
    FreeAndNil(xQryDados);
  except
    raise Exception.Create('Não foi possível apagar do banco!');
  end;

end;

procedure TProduto.Gravar;
var
  xQryDados : TFDQuery;
  xSQL : string;
begin
  if ID = 0 then
    xSQL := 'INSERT INTO PRODUTO ' +
              '(DESCRICAO, VALOR_UNITARIO) ' +
            'VALUES ' +
              '(:DESCRICAO, :VALOR_UNITARIO)'
  else
    xSQL := 'UPDATE PRODUTO SET ' +
              'DESCRICAO = :DESCRICAO, VALOR_UNITARIO = :VALOR_UNITARIO ' +
            'WHERE ID_PRODUTO = :ID_PRODUTO';

  xQryDados := TFDQuery.Create(nil);

  with xQryDados do
  begin
    Connection := FConn;

    Close;
    SQL.Clear;
    SQL.Add(xSQL);

    if ID > 0 then
      ParamByName('ID_PRODUTO').AsInteger := ID;

    ParamByName('DESCRICAO').AsString        := Descricao;
    ParamByName('VALOR_UNITARIO').AsCurrency := ValorUnitario;
  end;

  try
    xQryDados.ExecSQL;

    FreeAndNil(xQryDados);
  except
    raise Exception.Create('Não foi possível gravar no banco!!');
  end;
end;

destructor TProduto.Destroy;
begin

  inherited;
end;

function TProduto.GetDescricao: string;
begin
  Result := FDescricao;
end;

function TProduto.GetID: Integer;
begin
  Result := FID;
end;

function TProduto.GetID_Atual: Integer;
begin
  Result := FID_Atual;
end;

function TProduto.GetValorUnitario: Currency;
begin
  Result := FValorUnitario;
end;

procedure TProduto.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TProduto.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TProduto.SetID_Atual(const Value: Integer);
begin
  FID_Atual := Value;
end;

procedure TProduto.SetValorUnitario(const Value: Currency);
begin
  FValorUnitario := Value;
end;

end.

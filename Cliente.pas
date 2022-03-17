unit Cliente;

interface

uses
  System.Generics.Collections, FireDAC.Comp.Client,
  FireDAC.Stan.Param, System.SysUtils, Data.DB;

type
  ICliente = interface
    ['{83E5CF1F-9D23-4E9A-89C9-16936E8B3B36}']
    function GetID: Integer;
    procedure SetID(const Value: Integer);
    property ID : Integer read GetID write SetID;

    function GetID_Atual: Integer;
    procedure SetID_Atual(const Value: Integer);
    property ID_Atual : Integer read GetID_Atual write SetID_Atual;

    function GetNome: string;
    procedure SetNome(const Value: string);
    property Nome : string read GetNome write SetNome;

    function GetCEP: string;
    procedure SetCEP(const Value: string);
    property CEP : string read GetCEP write SetCEP;

    function GetIBGE: Integer;
    procedure SetIBGE(const Value: Integer);
    property IBGE : Integer read GetIBGE write SetIBGE;

    function GetEndereco: string;
    procedure SetEndereco(const Value: string);
    property Endereco : string read GetEndereco write SetEndereco;

    function GetNum: string;
    procedure SetNum(const Value: string);
    property Num : string read GetNum write SetNum;

    function GetComplemento: string;
    procedure SetComplemento(const Value: string);
    property Complemento : string read GetComplemento write SetComplemento;

    function GetBairro: string;
    procedure SetBairro(const Value: string);
    property Bairro : string read GetBairro write SetBairro;

    function GetCidade: string;
    procedure SetCidade(const Value: string);
    property Cidade : string read GetCidade write SetCidade;

    function GetUF: string;
    procedure SetUF(const Value: string);
    property UF : string read GetUF write SetUF;

    procedure Gravar;
    procedure Deletar;
end;

type
  TCliente = class(TInterfacedObject, ICliente)
    private
      FConn: TFDConnection;

      FID: Integer;
      FID_Atual: Integer;
      FNome: string;
      FCEP: string;
      FIBGE: Integer;
      FEndereco: string;
      FNum: string;
      FComplemento: string;
      FBairro: string;
      FCidade: string;
      FUF: string;

      function GetID: Integer;
      procedure SetID(const Value: Integer);
      function GetID_Atual: Integer;
      procedure SetID_Atual(const Value: Integer);
      function GetNome: string;
      procedure SetNome(const Value: string);
      function GetCEP: string;
      procedure SetCEP(const Value: string);
      function GetIBGE: Integer;
      procedure SetIBGE(const Value: Integer);
      function GetEndereco: string;
      procedure SetEndereco(const Value: string);
      function GetNum: string;
      procedure SetNum(const Value: string);
      function GetComplemento: string;
      procedure SetComplemento(const Value: string);
      function GetBairro: string;
      procedure SetBairro(const Value: string);
      function GetCidade: string;
      procedure SetCidade(const Value: string);
      function GetUF: string;
      procedure SetUF(const Value: string);
    public
      constructor Create(const aConn: TFDConnection);
      destructor Destroy; override;
      procedure Gravar;
      procedure Deletar;

      property ID : Integer read GetID write SetID;
      property ID_Atual : Integer read GetID_Atual write SetID_Atual;
      property Nome : string read GetNome write SetNome;
      property CEP : string read GetCEP write SetCEP;
      property IBGE : Integer read GetIBGE write SetIBGE;
      property Endereco : string read GetEndereco write SetEndereco;
      property Num : string read GetNum write SetNum;
      property Complemento : string read GetComplemento write SetComplemento;
      property Bairro : string read GetBairro write SetBairro;
      property Cidade : string read GetCidade write SetCidade;
      property UF : string read GetUF write SetUF;
  end;

implementation

{ TCliente }

constructor TCliente.Create(const aConn: TFDConnection);
begin
  FConn := aConn;
end;

procedure TCliente.Deletar;
var
  xQryDados : TFDQuery;
begin
  xQryDados := TFDQuery.Create(nil);

  with xQryDados do
  begin
    Connection := FConn;

    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM CLIENTE ' +
            'WHERE ID_CLIENTE = :ID_CLIENTE');

    ParamByName('ID_CLIENTE').AsInteger := ID;
  end;

  try
    xQryDados.ExecSQL;
    FreeAndNil(xQryDados);
  except
    raise Exception.Create('Não foi possível apagar do banco!');
  end;
end;

destructor TCliente.Destroy;
begin

  inherited;
end;

procedure TCliente.Gravar;
var
  xQryDados : TFDQuery;
  xSQL : string;
begin
  if ID = 0 then
    xSQL := 'INSERT INTO CLIENTE ' +
              '(NOME, CEP, LOGRADOURO, NUMERO, COMPLEMENTO, BAIRRO, CIDADE, UF, IBGE) ' +
            'VALUES ' +
              '(:NOME, :CEP, :LOGRADOURO, :NUMERO, :COMPLEMENTO, :BAIRRO, :CIDADE, :UF, :IBGE)'
  else
    xSQL := 'UPDATE CLIENTE SET ' +
              'NOME = :NOME, CEP = :CEP, LOGRADOURO = :LOGRADOURO, NUMERO = :NUMERO, ' +
              'COMPLEMENTO = :COMPLEMENTO, BAIRRO = :BAIRRO, CIDADE = :CIDADE, UF = :UF, ' +
              'IBGE = :IBGE ' +
            'WHERE ID_CLIENTE = :ID_CLIENTE';

  xQryDados := TFDQuery.Create(nil);

  with xQryDados do
  begin
    Connection := FConn;

    Close;
    SQL.Clear;
    SQL.Add(xSQL);

    if ID > 0 then
      ParamByName('ID_CLIENTE').AsInteger := ID;

    ParamByName('NOME').AsString        := Nome;
    ParamByName('CEP').AsString         := CEP;
    ParamByName('LOGRADOURO').AsString  := Endereco;
    ParamByName('NUMERO').AsString      := Num;
    ParamByName('COMPLEMENTO').AsString := Complemento;
    ParamByName('BAIRRO').AsString      := Bairro;
    ParamByName('CIDADE').AsString      := Cidade;
    ParamByName('UF').AsString          := UF;
    ParamByName('IBGE').AsInteger       := IBGE;
  end;

  try
    xQryDados.ExecSQL;

    FreeAndNil(xQryDados);
  except
    raise Exception.Create('Não foi possível gravar no banco!!');
  end;
end;

{GET}

function TCliente.GetID: Integer;
begin
  Result := FID;
end;

function TCliente.GetID_Atual: Integer;
begin
  Result := FID_Atual;
end;

function TCliente.GetNome: string;
begin
  Result := FNome;
end;

function TCliente.GetCEP: string;
begin
  Result := FCEP;
end;

function TCliente.GetIBGE: Integer;
begin
  Result := FIBGE;
end;

function TCliente.GetEndereco: string;
begin
  Result := FEndereco;
end;

function TCliente.GetNum: string;
begin
  Result := FNum;
end;

function TCliente.GetComplemento: string;
begin
  Result := FComplemento;
end;

function TCliente.GetBairro: string;
begin
  Result := FBairro;
end;

function TCliente.GetCidade: string;
begin
  Result := FCidade;
end;

function TCliente.GetUF: string;
begin
  Result := FUF;
end;

{SET}

procedure TCliente.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TCliente.SetID_Atual(const Value: Integer);
begin
  FID_Atual := Value;
end;

procedure TCliente.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TCliente.SetCEP(const Value: string);
begin
  FCEP := Value;
end;

procedure TCliente.SetIBGE(const Value: Integer);
begin
  FIBGE := Value;
end;

procedure TCliente.SetEndereco(const Value: string);
begin
  FEndereco := Value;
end;

procedure TCliente.SetNum(const Value: string);
begin
  FNum := Value;
end;

procedure TCliente.SetComplemento(const Value: string);
begin
  FComplemento := Value;
end;

procedure TCliente.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TCliente.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TCliente.SetUF(const Value: string);
begin
  FUF := Value;
end;

end.

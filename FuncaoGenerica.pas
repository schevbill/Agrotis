unit FuncaoGenerica;

interface

uses
  IniFiles, System.SysUtils, System.StrUtils, Vcl.Forms, Vcl.ExtCtrls;

type
  TIni = record
    IP: string;
    Patch: string;
end;

  function GravarINI(const aIP, aPatch : string) : Boolean;
  function LerINI : TIni;
  procedure LimparComponente(const aForm : Tform; const aTag : Integer);
  procedure ComponenteObrigatorio(const aForm : Tform; const aTag : Integer);
  function RetornoID_Proximo(const aNomeForm : string; const aOpcaoGenerator : Integer = 0) : Integer;
  function Mascara(aEdt : String; aStr : String) : string;

implementation

uses
  Vcl.StdCtrls, DM, FireDAC.Comp.Client;

function GravarINI(const aIP, aPatch : string) : Boolean;
var
  xConfig : Tinifile;
begin
  try
    xConfig := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    xConfig.WriteString('BANCO','IP_SERVER',aIP);
    xConfig.WriteString('BANCO','PATCH',aPatch);
  finally
    Result := True;
    FreeAndNil(xConfig);
  end;
end;

function LerINI : TIni;
var
  xConfig : TIniFile;
begin
  try
    xConfig := TIniFile.Create(ExtractFilePath(Application.ExeName)+ 'config.ini');

    Result.IP := xConfig.ReadString('BANCO','IP_SERVER','');
    Result.Patch := xConfig.ReadString('BANCO','PATCH','');
  finally
    FreeAndNil(xConfig);
  end;
end;

procedure LimparComponente(const aForm : Tform; const aTag : Integer);
var
  xI: Integer;
begin
  for xI := 0 to aForm.ComponentCount -1 do
  begin
    if aForm.Components[xI] is TEdit then
    begin
      if (TEdit(aForm.Components[xI]).Tag = aTag) then
        TEdit(aForm.Components[xI]).Clear;
    end;

    if aForm.Components[xI] is TComboBox then
    begin
      if (TComboBox(aForm.Components[xI]).Tag = aTag) then
        TComboBox(aForm.Components[xI]).ItemIndex := -1;
    end;
  end;
end;

procedure ComponenteObrigatorio(const aForm : Tform; const aTag : Integer);
var
  xI: Integer;
begin
  for xI := 0 to aForm.ComponentCount -1 do
  begin
    if aForm.Components[xI] is TEdit then
    begin
      if (TEdit(aForm.Components[xI]).Tag = aTag) and (SameText(TEdit(aForm.Components[xI]).Text,'')) then
      begin
        TEdit(aForm.Components[xI]).SetFocus;
        raise Exception.Create('Campo Obrigatorio - ' + TEdit(aForm.Components[xI]).Hint);
      end;
    end;

    if aForm.Components[xI] is TComboBox then
    begin
      if (TComboBox(aForm.Components[xI]).Tag = aTag) and (TComboBox(aForm.Components[xI]).ItemIndex = -1) then
      begin
        TComboBox(aForm.Components[xI]).SetFocus;
        raise Exception.Create('Campo Obrigatorio - ' + TComboBox(aForm.Components[xI]).Hint);
      end;
    end;
  end;
end;

function RetornoID_Proximo(const aNomeForm : string; const aOpcaoGenerator : Integer = 0) : Integer;
var
  xQryDados : TFDQuery;
  xGenerator : string;
begin
  case AnsiIndexStr(aNomeForm, ['fCadCliente','fCadProduto','fCadPedido']) of
    0 : xGenerator := 'GEN_CLIENTE_ID';
    1 : xGenerator := 'GEN_PRODUTO_ID';
    2 :
    begin
      if aOpcaoGenerator = 0 then
        xGenerator := 'GEN_PEDIDO_ID'
      else if aOpcaoGenerator = 1 then
        xGenerator := 'GEN_NUM_PEDIDO_ID'
      else
        xGenerator := 'GEN_PEDIDO_ITEM_ID';
    end;
  end;

  xQryDados := TFDQuery.Create(nil);

  with xQryDados do
  begin
    Connection := fDM.FDConnection;

    Close;
    SQL.Clear;
    SQL.Add('SELECT GEN_ID(' + xGenerator + ', 0) FROM rdb$database');
  end;

  try
    xQryDados.Open;
    Result := xQryDados.FieldByName('GEN_ID').AsInteger + 1;
  finally
    FreeAndNil(xQryDados)
  end;
end;

function Mascara(aEdt : String; aStr : String) : string;
var
  xI : integer;
begin
  for xI := 1 to Length(aEdt) do
  begin
    if (aStr[xI] = '9') and not (CharInSet(aEdt[xI], ['0'..'9'])) and (Length(aEdt) = Length(aStr) +1) then
      Delete(aEdt,xI,1);

    if (aStr[xI] <> '9') and (CharInSet(aEdt[xI], ['0'..'9'])) then
      Insert(aStr[xI],aEdt, xI);
  end;

  Result := aEdt;
end;

end.

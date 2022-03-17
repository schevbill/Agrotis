program AGROTIS;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {fPrincipal},
  DM in 'DM.pas' {fDM: TDataModule},
  FuncaoGenerica in 'FuncaoGenerica.pas',
  ConfigBD in 'ConfigBD.pas' {fConfigBD},
  CadCliente in 'CadCliente.pas' {fCadCliente},
  Cliente in 'Cliente.pas',
  CadProduto in 'CadProduto.pas' {fCadProduto},
  Produto in 'Produto.pas',
  CadPedido in 'CadPedido.pas' {fCadPedido},
  Pedido in 'Pedido.pas',
  PedidoItem in 'PedidoItem.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfDM, fDM);
  Application.CreateForm(TfPrincipal, fPrincipal);
  Application.Run;
end.

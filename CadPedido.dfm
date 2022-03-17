object fCadPedido: TfCadPedido
  Left = 0
  Top = 0
  Caption = 'Cadastro de Pedido'
  ClientHeight = 574
  ClientWidth = 978
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pFundoPedido: TPanel
    Left = 0
    Top = 0
    Width = 978
    Height = 291
    Align = alTop
    TabOrder = 0
    object pFundo: TPanel
      Left = 1
      Top = 1
      Width = 830
      Height = 289
      Align = alClient
      TabOrder = 0
      ExplicitHeight = 290
      object Label12: TLabel
        Left = 17
        Top = 13
        Width = 33
        Height = 13
        Caption = 'C'#243'digo'
      end
      object Label1: TLabel
        Left = 97
        Top = 13
        Width = 52
        Height = 13
        Caption = 'Refer'#234'ncia'
      end
      object Label2: TLabel
        Left = 17
        Top = 59
        Width = 56
        Height = 13
        Caption = 'Num Pedido'
      end
      object Label10: TLabel
        Left = 97
        Top = 59
        Width = 64
        Height = 13
        Caption = 'Data Emiss'#227'o'
      end
      object Label11: TLabel
        Left = 224
        Top = 59
        Width = 69
        Height = 13
        Caption = 'C'#243'digo Cliente'
      end
      object Label13: TLabel
        Left = 299
        Top = 59
        Width = 63
        Height = 13
        Caption = 'Nome Cliente'
      end
      object Label14: TLabel
        Left = 17
        Top = 105
        Width = 70
        Height = 13
        Caption = 'Tipo Opera'#231#227'o'
      end
      object Label15: TLabel
        Left = 97
        Top = 105
        Width = 86
        Height = 13
        Caption = 'Valor Total Pedido'
      end
      object edtCodigo: TEdit
        Tag = 1
        Left = 17
        Top = 32
        Width = 74
        Height = 21
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 0
      end
      object edtReferencia: TEdit
        Tag = 1
        Left = 97
        Top = 32
        Width = 656
        Height = 21
        Hint = 'Refer'#234'ncia'
        CharCase = ecUpperCase
        TabOrder = 1
      end
      object edtNumPedido: TEdit
        Tag = 1
        Left = 17
        Top = 78
        Width = 74
        Height = 21
        Hint = 'Num Pedido'
        ReadOnly = True
        TabOrder = 2
        OnEnter = edtNumPedidoEnter
      end
      object edtData: TEdit
        Tag = 1
        Left = 97
        Top = 78
        Width = 121
        Height = 21
        Hint = 'Data Emiss'#227'o'
        TabOrder = 3
        OnChange = edtDataChange
      end
      object edtCodCliente: TEdit
        Tag = 1
        Left = 224
        Top = 78
        Width = 69
        Height = 21
        Hint = 'C'#243'digo Cliente'
        NumbersOnly = True
        TabOrder = 4
        OnExit = edtCodClienteExit
      end
      object edtNomeCliente: TEdit
        Tag = 1
        Left = 299
        Top = 78
        Width = 454
        Height = 21
        ReadOnly = True
        TabOrder = 5
      end
      object cbTipo: TComboBox
        Tag = 1
        Left = 17
        Top = 124
        Width = 74
        Height = 21
        Hint = 'Tipo Opera'#231#227'o'
        Style = csDropDownList
        TabOrder = 6
        Items.Strings = (
          'E'
          'S')
      end
      object edtVlrTotalPedido: TEdit
        Tag = 1
        Left = 97
        Top = 124
        Width = 121
        Height = 21
        Alignment = taRightJustify
        ReadOnly = True
        TabOrder = 7
        Text = '0,00'
      end
    end
    object pBotoes: TPanel
      Left = 831
      Top = 1
      Width = 146
      Height = 289
      Align = alRight
      BevelInner = bvLowered
      Caption = 'pBotoes'
      ShowCaption = False
      TabOrder = 1
      ExplicitLeft = 648
      ExplicitTop = 0
      ExplicitHeight = 274
      object btnNovo: TButton
        Left = 6
        Top = 39
        Width = 132
        Height = 32
        Caption = '&Novo'
        TabOrder = 0
        OnClick = btnNovoClick
      end
      object btnCancelar: TButton
        Left = 6
        Top = 191
        Width = 132
        Height = 32
        Caption = '&Cancelar'
        TabOrder = 4
        OnClick = btnCancelarClick
      end
      object btnGravar: TButton
        Left = 6
        Top = 153
        Width = 132
        Height = 32
        Caption = '&Gravar'
        TabOrder = 3
        OnClick = btnGravarClick
      end
      object btnEditar: TButton
        Left = 6
        Top = 77
        Width = 132
        Height = 32
        Caption = '&Editar'
        TabOrder = 1
        OnClick = btnEditarClick
      end
      object btnSair: TButton
        Left = 6
        Top = 229
        Width = 132
        Height = 32
        Caption = '&Sair'
        TabOrder = 5
        OnClick = btnSairClick
      end
      object btnExcluir: TButton
        Left = 6
        Top = 115
        Width = 132
        Height = 32
        Caption = 'E&xcluir'
        TabOrder = 2
        OnClick = btnExcluirClick
      end
      object btnAnterior: TButton
        Left = 6
        Top = 8
        Width = 63
        Height = 25
        Caption = '<<'
        TabOrder = 6
        OnClick = btnAnteriorClick
      end
      object btnProximo: TButton
        Left = 75
        Top = 8
        Width = 63
        Height = 25
        Caption = '>>'
        TabOrder = 7
        OnClick = btnProximoClick
      end
    end
  end
  object pFundoPedidoItem: TPanel
    Left = 0
    Top = 291
    Width = 978
    Height = 283
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 408
    ExplicitTop = 296
    ExplicitWidth = 185
    ExplicitHeight = 41
    object pFundoItem: TPanel
      Left = 1
      Top = 1
      Width = 830
      Height = 281
      Align = alClient
      TabOrder = 0
      ExplicitTop = 5
      ExplicitHeight = 275
      object Label3: TLabel
        Left = 17
        Top = 13
        Width = 33
        Height = 13
        Caption = 'C'#243'digo'
      end
      object Label4: TLabel
        Left = 81
        Top = 13
        Width = 56
        Height = 13
        Caption = 'Num Pedido'
      end
      object Label5: TLabel
        Left = 17
        Top = 59
        Width = 56
        Height = 13
        Caption = 'Quantidade'
      end
      object Label6: TLabel
        Left = 144
        Top = 13
        Width = 74
        Height = 13
        Caption = 'C'#243'digo Produto'
      end
      object Label7: TLabel
        Left = 224
        Top = 13
        Width = 87
        Height = 13
        Caption = 'Descri'#231#227'o Produto'
      end
      object Label8: TLabel
        Left = 144
        Top = 59
        Width = 64
        Height = 13
        Caption = 'Valor Unit'#225'rio'
      end
      object Label9: TLabel
        Left = 271
        Top = 59
        Width = 24
        Height = 13
        Caption = 'Total'
      end
      object edtCodigoItem: TEdit
        Tag = 2
        Left = 17
        Top = 32
        Width = 58
        Height = 21
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 0
      end
      object edtNumPedidoItem: TEdit
        Tag = 2
        Left = 81
        Top = 32
        Width = 57
        Height = 21
        Hint = 'Num Pedido'
        CharCase = ecUpperCase
        ReadOnly = True
        TabOrder = 1
      end
      object edtQtd: TEdit
        Tag = 2
        Left = 17
        Top = 78
        Width = 121
        Height = 21
        Hint = 'Quantidade'
        Alignment = taRightJustify
        TabOrder = 4
        Text = '0,00'
        OnExit = edtQtdExit
      end
      object edtCodProduto: TEdit
        Tag = 2
        Left = 144
        Top = 32
        Width = 74
        Height = 21
        Hint = 'Codigo Produto'
        CharCase = ecUpperCase
        TabOrder = 2
        OnExit = edtCodProdutoExit
      end
      object edtDescricaoProd: TEdit
        Tag = 2
        Left = 224
        Top = 32
        Width = 585
        Height = 21
        Hint = 'Descri'#231#227'o Produto'
        CharCase = ecUpperCase
        ReadOnly = True
        TabOrder = 3
      end
      object edtVlrUnit: TEdit
        Tag = 2
        Left = 144
        Top = 78
        Width = 121
        Height = 21
        Hint = 'Valor Unit'#225'rio'
        Alignment = taRightJustify
        TabOrder = 5
        Text = '0,00'
        OnExit = edtQtdExit
      end
      object edtTotalItem: TEdit
        Tag = 2
        Left = 271
        Top = 78
        Width = 121
        Height = 21
        Hint = 'Total'
        Alignment = taRightJustify
        ReadOnly = True
        TabOrder = 6
        Text = '0,00'
      end
    end
    object pBotoesItem: TPanel
      Left = 831
      Top = 1
      Width = 146
      Height = 281
      Align = alRight
      BevelInner = bvLowered
      Caption = 'pBotoes'
      ShowCaption = False
      TabOrder = 1
      ExplicitLeft = 832
      ExplicitTop = 2
      ExplicitHeight = 299
      object btnNovoItem: TButton
        Left = 6
        Top = 39
        Width = 132
        Height = 32
        Caption = '&Novo'
        TabOrder = 0
        OnClick = btnNovoItemClick
      end
      object btnCancelarItem: TButton
        Left = 6
        Top = 191
        Width = 132
        Height = 32
        Caption = '&Cancelar'
        TabOrder = 4
        OnClick = btnCancelarItemClick
      end
      object btnGravarItem: TButton
        Left = 6
        Top = 153
        Width = 132
        Height = 32
        Caption = '&Gravar'
        TabOrder = 3
        OnClick = btnGravarItemClick
      end
      object btnEditarItem: TButton
        Left = 6
        Top = 77
        Width = 132
        Height = 32
        Caption = '&Editar'
        TabOrder = 1
        OnClick = btnEditarItemClick
      end
      object btnExcluirItem: TButton
        Left = 6
        Top = 115
        Width = 132
        Height = 32
        Caption = 'E&xcluir'
        TabOrder = 2
        OnClick = btnExcluirItemClick
      end
      object btnAnteriorItem: TButton
        Left = 6
        Top = 8
        Width = 63
        Height = 25
        Caption = '<<'
        TabOrder = 5
        OnClick = btnAnteriorItemClick
      end
      object btnProximoItem: TButton
        Left = 75
        Top = 8
        Width = 63
        Height = 25
        Caption = '>>'
        TabOrder = 6
        OnClick = btnProximoItemClick
      end
    end
  end
end

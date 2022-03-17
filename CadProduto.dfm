object fCadProduto: TfCadProduto
  Left = 0
  Top = 0
  Caption = 'Cadastro de Produto'
  ClientHeight = 274
  ClientWidth = 794
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
  object pFundo: TPanel
    Left = 0
    Top = 0
    Width = 648
    Height = 274
    Align = alClient
    TabOrder = 0
    object Label12: TLabel
      Left = 17
      Top = 13
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label1: TLabel
      Left = 81
      Top = 13
      Width = 102
      Height = 13
      Caption = 'Descri'#231#227'o do Produto'
    end
    object Label2: TLabel
      Left = 17
      Top = 59
      Width = 64
      Height = 13
      Caption = 'Valor Unit'#225'rio'
    end
    object edtCodigo: TEdit
      Left = 17
      Top = 32
      Width = 58
      Height = 21
      NumbersOnly = True
      ReadOnly = True
      TabOrder = 0
    end
    object edtDescricao: TEdit
      Tag = 1
      Left = 81
      Top = 32
      Width = 544
      Height = 21
      Hint = 'Descri'#231#227'o do Produto'
      CharCase = ecUpperCase
      TabOrder = 1
    end
    object edtValorUnit: TEdit
      Tag = 1
      Left = 17
      Top = 78
      Width = 121
      Height = 21
      Hint = 'Valor Unit'#225'rio'
      TabOrder = 2
      OnExit = edtValorUnitExit
      OnKeyPress = edtValorUnitKeyPress
    end
  end
  object pBotoes: TPanel
    Left = 648
    Top = 0
    Width = 146
    Height = 274
    Align = alRight
    BevelInner = bvLowered
    Caption = 'pBotoes'
    ShowCaption = False
    TabOrder = 1
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

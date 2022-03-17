object fCadCliente: TfCadCliente
  Left = 0
  Top = 0
  Caption = 'Cadastro de Cliente'
  ClientHeight = 278
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
    Height = 278
    Align = alClient
    TabOrder = 0
    object Label12: TLabel
      Left = 17
      Top = 10
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label1: TLabel
      Left = 81
      Top = 10
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object gbEndereco: TGroupBox
      Left = 8
      Top = 56
      Width = 625
      Height = 206
      Caption = 'Endere'#231'o'
      TabOrder = 2
      object Label6: TLabel
        Left = 16
        Top = 64
        Width = 45
        Height = 13
        Caption = 'Endere'#231'o'
      end
      object Label7: TLabel
        Left = 520
        Top = 64
        Width = 37
        Height = 13
        Caption = 'N'#250'mero'
      end
      object Label8: TLabel
        Left = 16
        Top = 110
        Width = 65
        Height = 13
        Caption = 'Complemento'
      end
      object Label9: TLabel
        Left = 273
        Top = 156
        Width = 33
        Height = 13
        Caption = 'Cidade'
      end
      object Label10: TLabel
        Left = 520
        Top = 156
        Width = 13
        Height = 13
        Caption = 'UF'
      end
      object Label11: TLabel
        Left = 16
        Top = 18
        Width = 19
        Height = 13
        Caption = 'CEP'
      end
      object Label13: TLabel
        Left = 16
        Top = 156
        Width = 28
        Height = 13
        Caption = 'Bairro'
      end
      object Label2: TLabel
        Left = 143
        Top = 18
        Width = 23
        Height = 13
        Caption = 'IBGE'
      end
      object CBUF: TComboBox
        Tag = 1
        Left = 520
        Top = 175
        Width = 47
        Height = 21
        Hint = 'UF'
        Style = csDropDownList
        TabOrder = 7
        Items.Strings = (
          'AC'
          'AL'
          'AP'
          'AM'
          'BA'
          'CE'
          'ES'
          'GO'
          'MA'
          'MT'
          'MS'
          'MG'
          'PA'
          'PB'
          'PR'
          'PE'
          'PI'
          'RJ'
          'RN'
          'RS'
          'RO'
          'RR'
          'SC'
          'SP'
          'SE'
          'TO'
          'DF')
      end
      object edtCEP: TEdit
        Tag = 1
        Left = 16
        Top = 37
        Width = 121
        Height = 21
        Hint = 'CEP'
        MaxLength = 8
        NumbersOnly = True
        TabOrder = 0
        OnExit = edtCEPExit
      end
      object edtIBGE: TEdit
        Left = 143
        Top = 37
        Width = 124
        Height = 21
        TabOrder = 1
      end
      object edtEnd: TEdit
        Tag = 1
        Left = 16
        Top = 83
        Width = 498
        Height = 21
        Hint = 'Endere'#231'o'
        CharCase = ecUpperCase
        TabOrder = 2
      end
      object edtNum: TEdit
        Tag = 1
        Left = 520
        Top = 83
        Width = 86
        Height = 21
        Hint = 'N'#250'mero'
        CharCase = ecUpperCase
        TabOrder = 3
      end
      object edtComplemento: TEdit
        Left = 16
        Top = 129
        Width = 590
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 4
      end
      object edtBairro: TEdit
        Tag = 1
        Left = 16
        Top = 175
        Width = 251
        Height = 21
        Hint = 'Bairro'
        CharCase = ecUpperCase
        TabOrder = 5
      end
      object edtCidade: TEdit
        Tag = 1
        Left = 273
        Top = 175
        Width = 241
        Height = 21
        Hint = 'Cidade'
        CharCase = ecUpperCase
        TabOrder = 6
      end
    end
    object edtCodigo: TEdit
      Left = 17
      Top = 29
      Width = 58
      Height = 21
      NumbersOnly = True
      ReadOnly = True
      TabOrder = 0
    end
    object edtNome: TEdit
      Tag = 1
      Left = 81
      Top = 29
      Width = 552
      Height = 21
      Hint = 'Nome'
      CharCase = ecUpperCase
      TabOrder = 1
    end
  end
  object pBotoes: TPanel
    Left = 648
    Top = 0
    Width = 146
    Height = 278
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
      TabOrder = 2
      OnClick = btnNovoClick
    end
    object btnCancelar: TButton
      Left = 6
      Top = 191
      Width = 132
      Height = 32
      Caption = '&Cancelar'
      TabOrder = 6
      OnClick = btnCancelarClick
    end
    object btnGravar: TButton
      Left = 6
      Top = 153
      Width = 132
      Height = 32
      Caption = '&Gravar'
      TabOrder = 5
      OnClick = btnGravarClick
    end
    object btnEditar: TButton
      Left = 6
      Top = 77
      Width = 132
      Height = 32
      Caption = '&Editar'
      TabOrder = 3
      OnClick = btnEditarClick
    end
    object btnSair: TButton
      Left = 6
      Top = 229
      Width = 132
      Height = 32
      Caption = '&Sair'
      TabOrder = 7
      OnClick = btnSairClick
    end
    object btnExcluir: TButton
      Left = 6
      Top = 115
      Width = 132
      Height = 32
      Caption = 'E&xcluir'
      TabOrder = 4
      OnClick = btnExcluirClick
    end
    object btnAnterior: TButton
      Left = 6
      Top = 8
      Width = 63
      Height = 25
      Caption = '<<'
      TabOrder = 0
      OnClick = btnAnteriorClick
    end
    object btnProximo: TButton
      Left = 75
      Top = 8
      Width = 63
      Height = 25
      Caption = '>>'
      TabOrder = 1
      OnClick = btnProximoClick
    end
  end
  object RESTClient: TRESTClient
    BaseURL = 'http://viacep.com.br/ws/01001000/json'
    Params = <>
    Left = 64
    Top = 304
  end
  object RESTRequest: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Params = <>
    Response = RESTResponse
    Left = 144
    Top = 304
  end
  object RESTResponse: TRESTResponse
    Left = 224
    Top = 304
  end
  object RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter
    Dataset = FDMemTable
    FieldDefs = <>
    Response = RESTResponse
    TypesMode = Rich
    Left = 344
    Top = 304
  end
  object FDMemTable: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    Left = 456
    Top = 304
  end
end

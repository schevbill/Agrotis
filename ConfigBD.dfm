object fConfigBD: TfConfigBD
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Configura'#231#227'o do Banco'
  ClientHeight = 89
  ClientWidth = 486
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pFundo: TPanel
    Left = 0
    Top = 0
    Width = 486
    Height = 89
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 97
    object Label1: TLabel
      Left = 24
      Top = 22
      Width = 57
      Height = 13
      Caption = 'IP Servidor:'
    end
    object Label2: TLabel
      Left = 24
      Top = 54
      Width = 78
      Height = 13
      Caption = 'Patch do Banco:'
    end
    object edtIP: TEdit
      Left = 104
      Top = 19
      Width = 249
      Height = 21
      TabOrder = 0
      Text = 'localhost'
    end
    object btnCriarINI: TButton
      Left = 359
      Top = 49
      Width = 114
      Height = 25
      Caption = '&Criar Arquivo INI'
      TabOrder = 3
      OnClick = btnCriarINIClick
    end
    object edtPatch: TEdit
      Left = 104
      Top = 51
      Width = 217
      Height = 21
      TabOrder = 1
    end
    object btnLocalizar: TButton
      Left = 328
      Top = 49
      Width = 25
      Height = 25
      Caption = '...'
      TabOrder = 2
      OnClick = btnLocalizarClick
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 'teste_pratico.FDB|*.FDB'
    Left = 416
    Top = 8
  end
end

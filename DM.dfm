object fDM: TfDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object FDTransaction: TFDTransaction
    Connection = FDConnection
    Left = 127
    Top = 8
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=C:\Users\RenatoMi\Desktop\AGROTIS\BD\AGROTIS.FDB'
      'DriverID=FB')
    LoginPrompt = False
    Left = 39
    Top = 9
  end
end

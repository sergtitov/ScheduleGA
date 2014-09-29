inherited FTime: TFTime
  Left = 352
  Top = 213
  Caption = 'F'
  ClientHeight = 61
  ClientWidth = 171
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 0
    Top = 40
    Width = 68
    Height = 16
    Caption = 'В месяцах'
  end
  object Label3: TLabel
    Left = 80
    Top = 40
    Width = 81
    Height = 16
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Label3'
  end
  object MaskEdit1: TEdit
    Left = 0
    Top = 0
    Width = 231
    Height = 24
    TabOrder = 0
    Text = 'MaskEdit1'
    OnChange = MaskEdit1Change
    OnKeyPress = MaskEdit1KeyPress
  end
end

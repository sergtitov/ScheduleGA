inherited FMassa: TFMassa
  Left = 494
  Top = 207
  Caption = 'FMassa'
  ClientHeight = 55
  ClientWidth = 230
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 0
    Top = 35
    Width = 62
    Height = 16
    Caption = 'В тоннах:'
  end
  object Label2: TLabel
    Left = 100
    Top = 35
    Width = 41
    Height = 16
    Alignment = taRightJustify
    Caption = 'Label2'
  end
  object Edit1: TEdit
    Left = 0
    Top = 0
    Width = 231
    Height = 24
    TabOrder = 0
    Text = 'Edit1'
    OnChange = Edit1Change
    OnKeyPress = Edit1KeyPress
  end
  object Button1: TButton
    Left = 155
    Top = 30
    Width = 74
    Height = 25
    Caption = 'x 1000'
    TabOrder = 1
    OnClick = Button1Click
  end
end

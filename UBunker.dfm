inherited FBunker: TFBunker
  Left = 357
  Top = 208
  Caption = 'FBunker'
  ClientHeight = 206
  ClientWidth = 423
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 20
    Top = 20
    Width = 111
    Height = 31
    AutoSize = False
    Caption = 'Емкость бункера (кг):'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label2: TLabel
    Left = 20
    Top = 90
    Width = 111
    Height = 48
    AutoSize = False
    Caption = 'Текущая загрузка (кг):'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label5: TLabel
    Left = 20
    Top = 170
    Width = 121
    Height = 21
    AutoSize = False
    Caption = 'Линия обработки'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Panel1: TPanel
    Left = 170
    Top = 20
    Width = 230
    Height = 60
    AutoSize = True
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 170
    Top = 90
    Width = 230
    Height = 60
    AutoSize = True
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 1
  end
  object LineBox: TComboBox
    Left = 170
    Top = 165
    Width = 151
    Height = 24
    ItemHeight = 16
    TabOrder = 2
  end
end

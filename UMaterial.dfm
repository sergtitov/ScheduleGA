inherited FMaterial: TFMaterial
  Left = 335
  Top = 126
  Caption = 'FMaterial'
  ClientHeight = 504
  ClientWidth = 451
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 20
    Top = 20
    Width = 151
    Height = 51
    AutoSize = False
    Caption = 'Мат.ожидание скорости обработки (тонн/час)'
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
    Top = 100
    Width = 171
    Height = 31
    AutoSize = False
    Caption = 'Среднеквадратичное отклонение'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label4: TLabel
    Left = 20
    Top = 180
    Width = 121
    Height = 48
    AutoSize = False
    Caption = 'Интенсивность входного потока (тонн/час)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label3: TLabel
    Left = 20
    Top = 260
    Width = 141
    Height = 61
    AutoSize = False
    Caption = 'Текущая загрузка бункера элеватора  (кг)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label6: TLabel
    Left = 20
    Top = 340
    Width = 141
    Height = 61
    AutoSize = False
    Caption = 'Емкость бункера элеватора (кг)'
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
    Top = 421
    Width = 141
    Height = 61
    AutoSize = False
    Caption = 'Коэффициент полезности'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Panel1: TPanel
    Left = 200
    Top = 20
    Width = 230
    Height = 60
    AutoSize = True
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 200
    Top = 100
    Width = 230
    Height = 60
    AutoSize = True
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 1
  end
  object Panel4: TPanel
    Left = 200
    Top = 180
    Width = 230
    Height = 60
    AutoSize = True
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 2
  end
  object Panel3: TPanel
    Left = 200
    Top = 260
    Width = 230
    Height = 60
    AutoSize = True
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 3
  end
  object Panel5: TPanel
    Left = 200
    Top = 340
    Width = 230
    Height = 60
    AutoSize = True
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 4
  end
  object Panel6: TPanel
    Left = 200
    Top = 421
    Width = 230
    Height = 60
    AutoSize = True
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 5
  end
end

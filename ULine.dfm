inherited FLine: TFLine
  Left = 381
  Top = 161
  Align = alClient
  Caption = 'FLine'
  ClientHeight = 472
  ClientWidth = 527
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Panel4: TPanel
    Left = 0
    Top = 0
    Width = 527
    Height = 251
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 20
      Top = 20
      Width = 104
      Height = 48
      Caption = 'Максимальная масса партии загрузки (кг)'
      WordWrap = True
    end
    object Label5: TLabel
      Left = 20
      Top = 165
      Width = 70
      Height = 16
      Caption = 'Тип сырья'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 20
      Top = 210
      Width = 477
      Height = 35
      AutoSize = False
      Caption = 
        'Время перестройки линии обработки (в часах) (0 - перенастройка н' +
        'е требуется, -1 - перенастройка невозможна)'
      WordWrap = True
    end
    object Bevel1: TBevel
      Left = 0
      Top = 200
      Width = 527
      Height = 51
      Align = alBottom
      Shape = bsTopLine
    end
    object Label3: TLabel
      Left = 20
      Top = 90
      Width = 99
      Height = 48
      Caption = 'Минимальная масса партии загрузки (кг)'
      WordWrap = True
    end
    object Panel1: TPanel
      Left = 150
      Top = 20
      Width = 230
      Height = 55
      BevelOuter = bvNone
      BorderStyle = bsSingle
      TabOrder = 0
    end
    object MaterialBox: TComboBox
      Left = 150
      Top = 157
      Width = 151
      Height = 24
      ItemHeight = 16
      TabOrder = 2
    end
    object Panel5: TPanel
      Left = 150
      Top = 90
      Width = 230
      Height = 55
      BevelOuter = bvNone
      BorderStyle = bsSingle
      TabOrder = 1
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 251
    Width = 527
    Height = 221
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object grid: TStringGrid
      Left = 20
      Top = 0
      Width = 487
      Height = 201
      Align = alClient
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goTabs, goAlwaysShowEditor, goThumbTracking]
      TabOrder = 0
      OnKeyPress = gridKeyPress
      ColWidths = (
        64
        64
        64
        64
        64)
      RowHeights = (
        24
        24
        24
        24
        24)
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 20
      Height = 201
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
    end
    object Panel10: TPanel
      Left = 507
      Top = 0
      Width = 20
      Height = 201
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 3
    end
    object Panel11: TPanel
      Left = 0
      Top = 201
      Width = 527
      Height = 20
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
    end
  end
end

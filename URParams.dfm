object FRParams: TFRParams
  Left = 333
  Top = 208
  BorderStyle = bsDialog
  Caption = 'Параметры перенастройки'
  ClientHeight = 322
  ClientWidth = 424
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 30
    Top = 34
    Width = 120
    Height = 16
    Caption = 'Линия обработки'
  end
  object Label2: TLabel
    Left = 30
    Top = 80
    Width = 111
    Height = 61
    Caption = 'Время запуска перенастройки (в сменах)'
    WordWrap = True
  end
  object Label3: TLabel
    Left = 30
    Top = 164
    Width = 118
    Height = 16
    Caption = 'Начальное сырье'
  end
  object Label4: TLabel
    Left = 30
    Top = 214
    Width = 108
    Height = 16
    Caption = 'Конечное сырье'
  end
  object Button1: TButton
    Left = 107
    Top = 280
    Width = 102
    Height = 31
    Caption = 'Готово'
    TabOrder = 0
    OnClick = Button1Click
  end
  object LineBox: TComboBox
    Left = 220
    Top = 30
    Width = 171
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 220
    Top = 80
    Width = 171
    Height = 61
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 2
  end
  object FromBox: TComboBox
    Left = 220
    Top = 160
    Width = 171
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    TabOrder = 3
  end
  object ToBox: TComboBox
    Left = 220
    Top = 210
    Width = 171
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    TabOrder = 4
  end
  object Button2: TButton
    Left = 216
    Top = 280
    Width = 101
    Height = 31
    Caption = 'Отмена'
    ModalResult = 2
    TabOrder = 5
  end
end

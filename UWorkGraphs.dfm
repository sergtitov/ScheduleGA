object FWorkGraphs: TFWorkGraphs
  Left = 381
  Top = 292
  BorderStyle = bsDialog
  Caption = 'Графики загруженности'
  ClientHeight = 133
  ClientWidth = 309
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 40
    Top = 20
    Width = 142
    Height = 16
    Caption = 'Выберите тип сырья'
  end
  object Button1: TButton
    Left = 158
    Top = 90
    Width = 111
    Height = 31
    Caption = 'Закрыть'
    ModalResult = 2
    TabOrder = 0
  end
  object Button2: TButton
    Left = 40
    Top = 90
    Width = 111
    Height = 31
    Caption = 'Показать'
    TabOrder = 1
    OnClick = Button2Click
  end
  object GBox: TComboBox
    Left = 40
    Top = 40
    Width = 231
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    TabOrder = 2
    OnDropDown = GBoxDropDown
  end
end

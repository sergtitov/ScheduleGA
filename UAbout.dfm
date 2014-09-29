object FAbout: TFAbout
  Left = 404
  Top = 222
  BorderStyle = bsDialog
  Caption = 'О программе'
  ClientHeight = 283
  ClientWidth = 448
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 120
  TextHeight = 16
  object Bevel1: TBevel
    Left = 8
    Top = 10
    Width = 433
    Height = 223
  end
  object Label1: TLabel
    Left = 24
    Top = 20
    Width = 400
    Height = 165
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'Инструментальная система имитационного моделирования и анализа т' +
      'ехнологических структур производства сыпучих продуктов'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clNavy
    Font.Height = -27
    Font.Name = 'Times New Roman'
    Font.Style = [fsItalic]
    ParentFont = False
    WordWrap = True
  end
  object Label2: TLabel
    Left = 64
    Top = 192
    Width = 321
    Height = 33
    Alignment = taCenter
    AutoSize = False
    Caption = 'Бурковский В.Л., Елецких С.В., Титов С.В., ВГТУ'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Button1: TButton
    Left = 169
    Top = 246
    Width = 111
    Height = 31
    Caption = 'Закрыть'
    TabOrder = 0
    OnClick = Button1Click
  end
end

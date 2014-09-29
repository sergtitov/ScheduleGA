object FOpt: TFOpt
  Left = 405
  Top = 325
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Оптимизация графика перенастроек'
  ClientHeight = 157
  ClientWidth = 360
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
  object Label1: TLabel
    Left = 24
    Top = 40
    Width = 223
    Height = 16
    Caption = 'Проанализировано комбинаций:'
  end
  object Label2: TLabel
    Left = 25
    Top = 128
    Width = 102
    Height = 16
    Caption = 'Лучшая оценка'
  end
  object LCount: TLabel
    Left = 256
    Top = 40
    Width = 81
    Height = 16
    Alignment = taRightJustify
    AutoSize = False
    Caption = '0'
  end
  object LBest: TLabel
    Left = 136
    Top = 128
    Width = 81
    Height = 16
    AutoSize = False
    Caption = '0'
  end
  object Label3: TLabel
    Left = 24
    Top = 16
    Width = 131
    Height = 16
    Caption = 'Всего комбинаций:'
  end
  object LAll: TLabel
    Left = 256
    Top = 16
    Width = 81
    Height = 16
    Alignment = taRightJustify
    AutoSize = False
    Caption = '0'
  end
  object Label4: TLabel
    Left = 224
    Top = 128
    Width = 47
    Height = 16
    Caption = 'Время:'
  end
  object LTime: TLabel
    Left = 289
    Top = 128
    Width = 48
    Height = 16
    Alignment = taRightJustify
    Caption = '00:00:00'
  end
  object p_opt: TProgressBar
    Left = 24
    Top = 72
    Width = 313
    Height = 25
    Min = 0
    Max = 100
    TabOrder = 0
  end
end

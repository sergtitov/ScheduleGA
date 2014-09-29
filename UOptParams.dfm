object FOptParams: TFOptParams
  Left = 384
  Top = 234
  BorderStyle = bsDialog
  Caption = 'Параметры оптимизации'
  ClientHeight = 328
  ClientWidth = 433
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 120
  TextHeight = 16
  object Button1: TButton
    Left = 208
    Top = 288
    Width = 105
    Height = 33
    Caption = 'Готово'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 320
    Top = 288
    Width = 105
    Height = 33
    Caption = 'Отмена'
    TabOrder = 1
    OnClick = Button2Click
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 16
    Width = 417
    Height = 265
    ActivePage = TabSheet1
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Параметры'
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 393
        Height = 217
        TabOrder = 0
        object Label1: TLabel
          Left = 24
          Top = 112
          Width = 315
          Height = 16
          Caption = 'Количество точек на графике перенастройки'
        end
        object CheckBox1: TCheckBox
          Left = 24
          Top = 40
          Width = 265
          Height = 33
          Caption = 'Показывать ход оптимизации'
          TabOrder = 0
        end
        object TrackBar1: TTrackBar
          Left = 16
          Top = 144
          Width = 265
          Height = 41
          Max = 20
          Min = 1
          Orientation = trHorizontal
          Frequency = 1
          Position = 1
          SelEnd = 0
          SelStart = 0
          TabOrder = 1
          TickMarks = tmBottomRight
          TickStyle = tsAuto
          OnChange = TrackBar1Change
        end
        object SpinEdit1: TSpinEdit
          Left = 296
          Top = 141
          Width = 65
          Height = 26
          MaxValue = 20
          MinValue = 1
          TabOrder = 2
          Value = 1
          OnChange = SpinEdit1Change
        end
      end
    end
  end
end

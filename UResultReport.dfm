object ResultReport: TResultReport
  Left = 0
  Top = 0
  Width = 992
  Height = 1403
  Frame.Color = clBlack
  Frame.DrawTop = False
  Frame.DrawBottom = False
  Frame.DrawLeft = False
  Frame.DrawRight = False
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Arial'
  Font.Style = []
  Functions.Strings = (
    'PAGENUMBER'
    'COLUMNNUMBER'
    'REPORTTITLE'
    'QRSTRINGSBAND1')
  Functions.DATA = (
    '0'
    '0'
    #39#39
    #39#39)
  Options = [FirstPageHeader, LastPageFooter]
  Page.Columns = 1
  Page.Orientation = poPortrait
  Page.PaperSize = A4
  Page.Values = (
    100
    2970
    100
    2100
    100
    100
    0)
  PrinterSettings.Copies = 1
  PrinterSettings.Duplex = False
  PrinterSettings.FirstPage = 0
  PrinterSettings.LastPage = 0
  PrinterSettings.OutputBin = Auto
  PrintIfEmpty = True
  ReportTitle = 'Статистика по моделированию'
  SnapToGrid = True
  Units = MM
  Zoom = 100
  object QRBand1: TQRBand
    Left = 47
    Top = 47
    Width = 898
    Height = 54
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = clSilver
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      114.3
      1900.76666666667)
    BandType = rbTitle
    object QRLabel1: TQRLabel
      Left = 110
      Top = 10
      Width = 677
      Height = 40
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.6666666666667
        232.833333333333
        21.1666666666667
        1432.98333333333)
      Alignment = taCenter
      AlignToBand = True
      AutoSize = True
      AutoStretch = False
      Caption = 'Результаты моделирования (линии обработки)'
      Color = clSilver
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -33
      Font.Name = 'Times New Roman'
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 20
    end
  end
  object QRLabel2: TQRLabel
    Left = 70
    Top = 140
    Width = 179
    Height = 21
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    Size.Values = (
      44.45
      148.166666666667
      296.333333333333
      378.883333333333)
    Alignment = taLeftJustify
    AlignToBand = False
    AutoSize = True
    AutoStretch = False
    Caption = 'Время работы модели:'
    Color = clWhite
    Transparent = False
    WordWrap = True
    FontSize = 10
  end
  object QTime: TQRLabel
    Left = 280
    Top = 140
    Width = 48
    Height = 20
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    Size.Values = (
      42.3333333333333
      592.666666666667
      296.333333333333
      101.6)
    Alignment = taLeftJustify
    AlignToBand = False
    AutoSize = True
    AutoStretch = False
    Caption = 'QTime'
    Color = clWhite
    Transparent = False
    WordWrap = True
    FontSize = 10
  end
  object QRLabel3: TQRLabel
    Left = 422
    Top = 190
    Width = 146
    Height = 20
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    Size.Values = (
      42.3333333333333
      893.233333333333
      402.166666666667
      309.033333333333)
    Alignment = taCenter
    AlignToBand = False
    AutoSize = True
    AutoStretch = False
    Caption = 'Линии обработки'
    Color = clWhite
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = False
    WordWrap = True
    FontSize = 10
  end
  object QRShape1: TQRShape
    Left = 70
    Top = 210
    Width = 851
    Height = 11
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    Size.Values = (
      23.2833333333333
      148.166666666667
      444.5
      1801.28333333333)
    Shape = qrsHorLine
  end
  object QLineName: TQRLabel
    Left = 70
    Top = 240
    Width = 241
    Height = 23
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    Size.Values = (
      48.6833333333333
      148.166666666667
      508
      510.116666666667)
    Alignment = taLeftJustify
    AlignToBand = False
    AutoSize = False
    AutoStretch = False
    Caption = 'Название'
    Color = clWhite
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Times New Roman'
    Font.Style = [fsItalic]
    ParentFont = False
    Transparent = False
    WordWrap = True
    FontSize = 12
  end
  object QLineWork: TQRLabel
    Left = 410
    Top = 240
    Width = 220
    Height = 23
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    Size.Values = (
      48.6833333333333
      867.833333333333
      508
      465.666666666667)
    Alignment = taRightJustify
    AlignToBand = False
    AutoSize = False
    AutoStretch = False
    Caption = 'Время работы'
    Color = clWhite
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Times New Roman'
    Font.Style = [fsItalic]
    ParentFont = False
    Transparent = False
    WordWrap = True
    FontSize = 12
  end
  object QLineRest: TQRLabel
    Left = 660
    Top = 240
    Width = 220
    Height = 23
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    Size.Values = (
      48.6833333333333
      1397
      508
      465.666666666667)
    Alignment = taRightJustify
    AlignToBand = False
    AutoSize = False
    AutoStretch = False
    Caption = 'Время простоя'
    Color = clWhite
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Times New Roman'
    Font.Style = [fsItalic]
    ParentFont = False
    Transparent = False
    WordWrap = True
    FontSize = 12
  end
  object LineChart: TQRChart
    Left = 50
    Top = 327
    Width = 891
    Height = 359
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    Size.Values = (
      759.883333333333
      105.833333333333
      692.15
      1885.95)
    object QRDBChart1: TQRDBChart
      Left = -1
      Top = -1
      Width = 1
      Height = 1
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      BottomWall.Color = 12615680
      LeftWall.Brush.Color = clWhite
      MarginBottom = 0
      MarginLeft = 0
      MarginRight = 0
      MarginTop = 0
      Title.Font.Charset = RUSSIAN_CHARSET
      Title.Font.Color = clBlue
      Title.Font.Height = -17
      Title.Font.Name = 'Arial'
      Title.Font.Style = []
      Title.Text.Strings = (
        'Загрузка линий обработки')
      Legend.Alignment = laTop
      object Series1: TBarSeries
        Marks.ArrowLength = 20
        Marks.Style = smsValue
        Marks.Visible = True
        SeriesColor = clBlack
        Title = 'Время работы'
        BarBrush.Style = bsDiagCross
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Bar'
        YValues.Multiplier = 1
        YValues.Order = loNone
      end
      object Series2: TBarSeries
        Marks.ArrowLength = 20
        Marks.Style = smsValue
        Marks.Visible = True
        SeriesColor = clGreen
        Title = 'Время простоя'
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Bar'
        YValues.Multiplier = 1
        YValues.Order = loNone
      end
    end
  end
end

object Main: TMain
  Left = 322
  Top = 219
  Width = 608
  Height = 414
  Caption = 'Моделирование'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 120
  TextHeight = 16
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 600
    Height = 29
    Align = alTop
    AutoSize = True
    BevelEdges = [beTop]
    BevelInner = bvNone
    BevelKind = bkFlat
    RowSnap = False
    TabOrder = 0
    object ToolBar1: TToolBar
      Left = 11
      Top = 2
      Width = 200
      Height = 24
      AutoSize = True
      ButtonHeight = 24
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Images = FModel.AllImages
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      object ToolButton9: TToolButton
        Left = 0
        Top = 0
        Action = FModel.AClear
      end
      object ToolButton1: TToolButton
        Left = 23
        Top = 0
        Action = ALoad
      end
      object ToolButton2: TToolButton
        Left = 46
        Top = 0
        Action = ASave
      end
      object ToolButton3: TToolButton
        Left = 69
        Top = 0
        Width = 8
        Caption = 'ToolButton3'
        ImageIndex = 9
        Style = tbsSeparator
      end
      object ToolButton4: TToolButton
        Left = 77
        Top = 0
        Action = AModel
      end
      object ToolButton7: TToolButton
        Left = 100
        Top = 0
        Action = FModel.APrint
      end
      object ToolButton8: TToolButton
        Left = 123
        Top = 0
        Action = ASolve
      end
      object ToolButton5: TToolButton
        Left = 146
        Top = 0
        Width = 8
        Caption = 'ToolButton5'
        ImageIndex = 26
        Style = tbsSeparator
      end
      object ToolButton6: TToolButton
        Left = 154
        Top = 0
        Action = AHelp
      end
      object ToolButton10: TToolButton
        Left = 177
        Top = 0
        Action = AAbout
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 336
    Width = 600
    Height = 22
    Panels = <
      item
        Width = 250
      end
      item
        Width = 50
      end>
    ParentShowHint = False
    ShowHint = True
    SimplePanel = False
  end
  object MainMenu1: TMainMenu
    Images = FModel.AllImages
    Left = 230
    Top = 80
    object NFile: TMenuItem
      Caption = '&Файл'
      object N13: TMenuItem
        Action = FModel.AClear
      end
      object N3: TMenuItem
        Action = ALoad
      end
      object N2: TMenuItem
        Action = ASave
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Nexit: TMenuItem
        Action = AExit
      end
    end
    object NParams: TMenuItem
      Caption = '&Модель'
      object N9: TMenuItem
        Action = AModelReport
      end
      object N10: TMenuItem
        Caption = '&Результаты моделирования'
        Hint = 'Результаты моделирования'
        object N14: TMenuItem
          Action = ALinesReport
        end
        object N16: TMenuItem
          Action = ABunkersReport
        end
        object N17: TMenuItem
          Action = AMaterialsReport
        end
        object N18: TMenuItem
          Action = AWorkGraphs
        end
        object N15: TMenuItem
          Action = AReconfReport
        end
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object N20: TMenuItem
        Action = AOptimize
      end
      object N12: TMenuItem
        Action = ASolve
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object NLines: TMenuItem
        Action = AModel
      end
      object N22: TMenuItem
        Action = AOptParams
      end
      object N21: TMenuItem
        Caption = '-'
      end
      object N19: TMenuItem
        Action = Areconflist
      end
    end
    object N4: TMenuItem
      Caption = '&Справка'
      object N7: TMenuItem
        Action = AHelp
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object N6: TMenuItem
        Action = AAbout
      end
    end
  end
  object ActionList1: TActionList
    Images = FModel.AllImages
    Left = 310
    Top = 80
    object AExit: TAction
      Category = 'Файл'
      Caption = 'В&ыход'
      Hint = 'Выход|Выход из программы'
      OnExecute = AExitExecute
    end
    object AModel: TAction
      Category = 'Model'
      Caption = '&Настройка модели...'
      Hint = 'Настройка модели|Настройка модели'
      ImageIndex = 25
      OnExecute = AModelExecute
    end
    object AAbout: TAction
      Category = 'Help'
      Caption = '&О программе...'
      Hint = 'О программе|Информация о программе'
      ImageIndex = 17
      OnExecute = AAboutExecute
    end
    object AHelp: TAction
      Category = 'Help'
      Caption = '&Вызов справки'
      Hint = 'Справка|Вызов справки'
      ImageIndex = 26
      OnExecute = AHelpExecute
    end
    object ALinesReport: TAction
      Category = 'Model'
      Caption = 'Отчет о &линиях обработки...'
      Hint = 'Отчет о линиях обработки...|Печать отчета о линиях обработки'
      OnExecute = ALinesReportExecute
    end
    object AModelReport: TAction
      Category = 'Model'
      Caption = 'Отчет о &модели...'
      Hint = 'Отчет о модели...|Печать отчета о модели'
      OnExecute = AModelReportExecute
    end
    object ASolve: TAction
      Category = 'Model'
      Caption = '&Запуск обработки...'
      Hint = 'Запуск обработки|Запуск процесса моделирования'
      ImageIndex = 27
      OnExecute = ASolveExecute
    end
    object AReconfReport: TAction
      Category = 'Model'
      Caption = '&График перенастройки...'
      Hint = 'График перенастройки...|Печать графика перенастройки'
    end
    object AMaterialsReport: TAction
      Category = 'Model'
      Caption = 'Отчет о &типах сырья...'
      Hint = 'Отчет о типах сырья|Печать отчета о типах сырья'
      OnExecute = AMaterialsReportExecute
    end
    object ALoad: TAction
      Category = 'Model'
      Caption = '&Загрузить модель...'
      Hint = 'Загрузить модель|Загружает модель из файла'
      ImageIndex = 7
      OnExecute = ALoadExecute
    end
    object ASave: TAction
      Category = 'Model'
      Caption = '&Сохранить модель...'
      Hint = 'Сохранить модель|Сохраняет модель в файле'
      ImageIndex = 8
      OnExecute = ASaveExecute
    end
    object ABunkersReport: TAction
      Category = 'Model'
      Caption = 'Отчет о &бункерах...'
      Hint = 'Отчет о бункерах|Печать отчета о бункерах'
      OnExecute = ABunkersReportExecute
    end
    object AWorkGraphs: TAction
      Category = 'Model'
      Caption = 'Г&рафики загруженности...'
      Hint = 'Графики загруженности'
      OnExecute = AWorkGraphsExecute
    end
    object Areconflist: TAction
      Category = 'Model'
      Caption = 'График перенастроек...'
      Hint = 'График перенастроек'
      OnExecute = AreconflistExecute
    end
    object AOptimize: TAction
      Category = 'Model'
      Caption = 'Оптимизация...'
      Hint = 'Оптимизация графика перенастроек линий обработки'
      OnExecute = AOptimizeExecute
    end
    object AOptParams: TAction
      Category = 'Model'
      Caption = 'Настройка оптимизации...'
      Hint = 'Изменение настроек оптимизации'
      OnExecute = AOptParamsExecute
    end
  end
end

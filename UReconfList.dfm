inherited FReconfList: TFReconfList
  Left = 251
  Top = 161
  Width = 630
  Height = 440
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  BorderStyle = bsSizeable
  Caption = 'График перенастроек'
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 490
    Top = 0
    Width = 132
    Height = 384
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object Button1: TButton
      Left = 22
      Top = 34
      Width = 91
      Height = 31
      Caption = 'Добавить'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 22
      Top = 74
      Width = 91
      Height = 31
      Caption = 'Изменить'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 22
      Top = 114
      Width = 91
      Height = 31
      Caption = 'Удалить'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 22
      Top = 204
      Width = 91
      Height = 31
      Caption = 'Закрыть'
      ModalResult = 1
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 490
    Height = 384
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Header: THeaderControl
      Left = 0
      Top = 0
      Width = 490
      Height = 31
      DragReorder = False
      Sections = <
        item
          ImageIndex = -1
          Text = 'Наименование линии'
          Width = 180
        end
        item
          ImageIndex = -1
          Text = 'Номер смены'
          Width = 120
        end
        item
          ImageIndex = -1
          Text = 'Откуда'
          Width = 80
        end
        item
          ImageIndex = -1
          Text = 'Куда'
          Width = 80
        end>
      Style = hsFlat
      OnSectionResize = HeaderSectionResize
    end
    object Grid: TStringGrid
      Left = 0
      Top = 31
      Width = 490
      Height = 353
      Align = alClient
      ColCount = 4
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goRangeSelect, goRowSelect]
      TabOrder = 1
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 384
    Width = 622
    Height = 24
    Panels = <>
    SimplePanel = True
    SimpleText = 'Критерий оптимизации: не вычислен'
  end
end

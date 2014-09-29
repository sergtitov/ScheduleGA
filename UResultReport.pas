unit UResultReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
     StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls,
     tc, TeEngine, Series, TeeProcs, Chart, DBChart, QrTee;

type
  TResultReport = class(TQuickRep)
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QTime: TQRLabel;
    QRLabel3: TQRLabel;
    QRShape1: TQRShape;
    QLineName: TQRLabel;
    QLineWork: TQRLabel;
    QLineRest: TQRLabel;
    QRDBChart1: TQRDBChart;
    LineChart: TQRChart;
    Series1: TBarSeries;
    Series2: TBarSeries;
  private
  public
     Model : TModel;
     procedure LoadFromModel;
  end;

var
  ResultReport: TResultReport;

implementation

const
   TOP_LINE_MARGIN = 40;

{$R *.DFM}

{ TResultReport }

procedure TResultReport.LoadFromModel;
var
  MIndex : integer;
  i : integer;
  QLineName1, QLineWork1, QLineRest1, QMaterialType1 : TQRLabel;
begin
   QTime.Caption := Time2Works(Model.AllTime);

   with Model.Lines do
   for i := Low(List) to High(List) do
   begin
      QLineName1 := TQRLabel.Create(self);
//      QMaterialType1 := TQRLabel.Create(self);
      QLineWork1 := TQRLabel.Create(self);
      QLineRest1 := TQRLabel.Create(self);

//      QMaterialType1.Visible := false;

      QLineName1.Parent := self;
//      QMaterialType1.Parent := self;
      QLineWork1.Parent := self;
      QLineRest1.Parent := self;

      QLineName1.AutoSize := false;
//      QMaterialType1.AutoSize := false;
      QLineWork1.AutoSize := false;
      QLineRest1.AutoSize := false;

      QLineName1.Font.Name := 'MS Sans Serif';
      QLineName1.Font.Size := 10;
//      QMaterialType1.Font.Name := 'MS Sans Serif';
//      QMaterialType1.Font.Size := 10;
      QLineWork1.Font.Name := 'MS Sans Serif';
      QLineWork1.Font.Size := 10;
      QLineRest1.Font.Name := 'MS Sans Serif';
      QLineRest1.Font.Size := 10;

      QLineRest1.Alignment := taRightJustify;
      QLineWork1.Alignment := taRightJustify;

      QLineName1.Left := QLineName.Left;
//      QMaterialType1.Left := QMaterialType.Left;
      QLineWork1.Left := QLineWork.Left;
      QLineRest1.Left := QLineRest.Left;

      QLineName1.width := QLineName.width;
//      QMaterialType1.width := QMaterialType.width;
      QLineWork1.width := QLineWork.width;
      QLineRest1.width := QLineRest.width;

      QLineName1.top := QLineName.Top + (i + 1) * TOP_LINE_MARGIN;
//      QMaterialType1.top := QMaterialType.Top + (i + 1) * TOP_LINE_MARGIN;
      QLineWork1.top := QLineWork.Top + (i + 1) * TOP_LINE_MARGIN;
      QLineRest1.top := QLineRest.top + (i + 1) * TOP_LINE_MARGIN;


      QLineName1.Caption := (List[i] as TAssembleLine).Name;

{      MIndex := Model.Materials.FindByNumber(((List[i] as TAssembleLine).CurMaterialType));
      if MIndex <> -1 then
        QMaterialType1.Caption :=  Model.Materials.List[MIndex].Name
      else
        QMaterialType1.Caption := NoLink;
}
      QLineWork1.Caption := Time2Works((List[i] as TAssembleLine).WorkTime);
      QLineRest1.Caption := Time2Works((List[i] as TAssembleLine).RestTime);

      LineChart.Chart.SeriesList.Series[0].Add(round((List[i] as TAssembleLine).WorkTime / (8 * 3600)), QLineName1.Caption);
      LineChart.Chart.SeriesList.Series[1].Add(round((List[i] as TAssembleLine).RestTime / (8 * 3600)), QLineName1.Caption);

      LineChart.Top := QLineName.Top + (high(list) + 1) * 40 + 50;
   end;
end;

end.

unit UGraph;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, tc, TeEngine, Series,
  TeeProcs, Chart, DBChart, QrTee;

type
  TGraphReport = class(TQuickRep)
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QTime: TQRLabel;
    QRLabel3: TQRLabel;
    QMaterial: TQRLabel;
    QRDBChart1: TQRDBChart;
    Chart: TQRChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
  public
     Model : TModel;
     Material : integer;
     procedure LoadFromModel;
     constructor Create(Owner : TComponent);override;
  end;

var
  GraphReport: TGraphReport;

implementation

{$R *.DFM}

{ TQGraph }

constructor TGraphReport.Create;
begin
  inherited;
  Model := nil;
  Material := -1;
end;

procedure TGraphReport.LoadFromModel;
var
  I : integer;
begin
    if not assigned(Model) or (Material = -1) then exit;

    QTime.Caption := Time2Works(Model.AllTime);
    QMaterial.Caption := Model.Materials.List[Material].Name;

    with (Model.Materials.List[Material] as TMaterial) do
    for i := 0 to MAX_POINTS do
    begin
        Chart.Chart.SeriesList.Series[0].Add(XY[i].Refusal, ShortTime2Works(XY[i].T));
        Chart.Chart.SeriesList.Series[1].Add(XY[i].Queue, ShortTime2Works(XY[i].T));
    end;

end;

end.

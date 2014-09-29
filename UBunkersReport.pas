unit UBunkersReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, tc;

type
  TBunkersReport = class(TQuickRep)
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QTime: TQRLabel;
    QCommBunkers: TQRLabel;
    QBunkersLine: TQRShape;
    QBunkerName: TQRLabel;
    QBunkerAmount: TQRLabel;
    QGivenBunkers: TQRLabel;
    QBunkersLine_g: TQRShape;
    QBunkerName_g: TQRLabel;
    QBunkerAmount_g: TQRLabel;
  public
     Model : TModel;
     procedure LoadFromModel;
  end;

var
  BunkersReport: TBunkersReport;

implementation

{$R *.DFM}

const
  TOP_BUNKER_MARGIN = 40;

{ TBunkersReport }

procedure TBunkersReport.LoadFromModel;
var
  i, temp1, temp2 : integer;
  QBunkerName1, QBunkerAmount1  : TQRLabel;
  QBunkerName1_g, QBunkerAmount1_g : TQRLabel;
begin
   if not assigned(Model) then exit;
   QTime.Caption := Time2Works(Model.AllTime);

   with Model.CommBunkers do
   for i := Low(List) to High(List) do
   begin
      QBunkerName1 := TQRLabel.Create(self);
      QBunkerAmount1 := TQRLabel.Create(self);

      QBunkerName1.Parent := self;
      QBunkerAmount1.Parent := self;

      QBunkerName1.AutoSize := false;
      QBunkerAmount1.AutoSize := false;

      QBunkerName1.Font.Name := 'MS Sans Serif';
      QBunkerName1.Font.Size := 10;
      QBunkerAmount1.Font.Name := 'MS Sans Serif';
      QBunkerAmount1.Font.Size := 10;

      QBunkerAmount1.Alignment := taRightJustify;

      QBunkerName1.Left := QBunkerName.Left;
      QBunkerAmount1.Left := QBunkerAmount.Left;

      QBunkerName1.width := QBunkerName.width;
      QBunkerAmount1.width := QBunkerAmount.width;

      QBunkerName1.top := QBunkerName.Top + (i + 1) * TOP_BUNKER_MARGIN;
      QBunkerAmount1.top := QBunkerAmount.Top + (i + 1) * TOP_BUNKER_MARGIN;

      QBunkerName1.Caption := (List[i] as TBunker).Name;
      QBunkerAmount1.Caption := Massa2Str((List[i] as TBunker).CurAmount);
   end;

   temp1 := - (QGivenBunkers.Top - QBunkersLine_g.Top);
   temp2 := - (QGivenBunkers.Top - QBunkerName_g.Top);

   if Model.CommBunkers.Count > 0 then
     QGivenBunkers.Top := QBunkerName1.Top + 70
   else
     QGivenBunkers.Top := QBunkerName.Top + 70;

   QBunkersLine_g.Top := QGivenBunkers.Top + temp1;
   QBunkerName_g.Top := QGivenBunkers.Top + temp2;
   QBunkerAmount_g.Top := QBunkerName_g.Top;

   with Model.GivenBunkers do
   for i := Low(List) to High(List) do
   begin
      QBunkerName1_g := TQRLabel.Create(self);
      QBunkerAmount1_g := TQRLabel.Create(self);

      QBunkerName1_g.Parent := self;
      QBunkerAmount1_g.Parent := self;

      QBunkerName1_g.AutoSize := false;
      QBunkerAmount1_g.AutoSize := false;

      QBunkerName1_g.Font.Name := 'MS Sans Serif';
      QBunkerName1_g.Font.Size := 10;
      QBunkerAmount1_g.Font.Name := 'MS Sans Serif';
      QBunkerAmount1_g.Font.Size := 10;

      QBunkerAmount1_g.Alignment := taRightJustify;

      QBunkerName1_g.Left := QBunkerName_g.Left;
      QBunkerAmount1_g.Left := QBunkerAmount_g.Left;

      QBunkerName1_g.width := QBunkerName_g.width;
      QBunkerAmount1_g.width := QBunkerAmount_g.width;

      QBunkerName1_g.top := QBunkerName_g.Top + (i + 1) * TOP_BUNKER_MARGIN;
      QBunkerAmount1_g.top := QBunkerAmount_g.Top + (i + 1) * TOP_BUNKER_MARGIN;

      QBunkerName1_g.Caption := (List[i] as TBunker).Name;
      QBunkerAmount1_g.Caption := Massa2Str((List[i] as TBunker).CurAmount);
   end;
end;

end.

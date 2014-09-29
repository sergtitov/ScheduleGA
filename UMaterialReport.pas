unit UMaterialReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, tc;

type
  TMaterialsReport = class(TQuickRep)
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QTime: TQRLabel;
    QMaterials: TQRLabel;
    QBunkersLine: TQRShape;
    QMaterialName: TQRLabel;
    QDone: TQRLabel;
    QCurAmount: TQRLabel;
    QRefusal: TQRLabel;
  public
     Model : TModel;
     procedure LoadFromModel;
  end;

var
  MaterialsReport: TMaterialsReport;

implementation

const
  TOP_MATERIAL_MARGIN = 30;


{$R *.DFM}

{ TMaterialReport }

procedure TMaterialsReport.LoadFromModel;
var
  i : integer;
  QMaterialName1, QDone1, QCurAmount1, QRefusal1 : TQRLabel;
begin
   if not assigned(Model) then exit;
   QTime.Caption := Time2Works(Model.AllTime);

   with Model.Materials do
   for i := Low(List) to High(List) do
   begin
      QMaterialName1 := TQRLabel.Create(self);
      QDone1 :=  TQRLabel.Create(self);
      QCurAmount1 := TQRLabel.Create(self);
      QRefusal1 := TQRLabel.Create(self);

      QMaterialName1.Parent := MaterialsReport;
      QDone1.Parent := MaterialsReport;
      QCurAmount1.Parent := MaterialsReport;
      QRefusal1.Parent := MaterialsReport;

      QMaterialName1.AutoSize := false;
      QDone1.AutoSize := false;
      QCurAmount1.AutoSize := false;
      QRefusal1.AutoSize := false;

      QMaterialName1.Font.Name := 'MS Sans Serif';
      QMaterialName1.Font.Size := 10;
      QDone1.Font.Name := 'MS Sans Serif';
      QDone1.Font.Size := 10;
      QCurAmount1.Font.Name := 'MS Sans Serif';
      QCurAmount1.Font.Size := 10;
      QRefusal1.Font.Name := 'MS Sans Serif';
      QRefusal1.Font.Size := 10;

      QDone1.Alignment := taRightJustify;
      QCurAmount1.Alignment := taRightJustify;
      QRefusal1.Alignment := taRightJustify;

      QMaterialName1.Left := QMaterialName.Left;
      QDone1.Left := QDone.Left;
      QCurAmount1.Left := QCurAmount.Left;
      QRefusal1.Left := QRefusal.Left;

      QMaterialName1.width := QMaterialName.width;
      QDone1.width := QDone.width;
      QCurAmount1.width := QCurAmount.width;
      QRefusal1.width := QRefusal.width;

      QMaterialName1.top := QMaterialName.Top + i * TOP_MATERIAL_MARGIN + 60;
      QDone1.top := QDone.Top + i * TOP_MATERIAL_MARGIN + 60;
      QCurAmount1.top := QCurAmount.top + i * TOP_MATERIAL_MARGIN + 60;
      QRefusal1.top := QRefusal.top + i * TOP_MATERIAL_MARGIN + 60;

      QMaterialName1.Caption := (List[i] as TMaterial).Name;
      QDone1.Caption := Massa2Str((List[i] as TMaterial).Done);
      QCurAmount1.Caption := Massa2Str((List[i] as TMaterial).Queue);
      QRefusal1.Caption := Massa2Str((List[i] as TMaterial).AllRefusal);
   end;
end;

end.

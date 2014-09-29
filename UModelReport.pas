unit UModelReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, tc ;

type
  TModelReport = class(TQuickRep)
    QRBand1: TQRBand;
    QModel: TQRLabel;
    QRBand2: TQRBand;
    QTimeLabel: TQRLabel;
    QTime: TQRLabel;
    QMaterialTypes: TQRLabel;
    QMaterialsLine: TQRShape;
    QMaterialName: TQRLabel;
    QMaterialMx: TQRLabel;
    QMaterialSigma: TQRLabel;
    QLines: TQRLabel;
    QLinesLine: TQRShape;
    QLineName: TQRLabel;
    QLinePart: TQRLabel;
    QLineMType: TQRLabel;
    QBunkerName: TQRLabel;
    QBunkersLine: TQRShape;
    QBunkers: TQRLabel;
    QBunkerCurAmount: TQRLabel;
    QBunkerCapacity: TQRLabel;
    QBunkerMaterial: TQRLabel;
    QBunkers_g: TQRLabel;
    QBunkersLine_g: TQRShape;
    QBunkerName_g: TQRLabel;
    QBunkerCapacity_g: TQRLabel;
    QBunkerCurAmount_g: TQRLabel;
    QBunkerMaterial_g: TQRLabel;
    QMinPart: TQRLabel;
    QMaterialLamda: TQRLabel;
  public
     Model : TModel;
     procedure LoadFromModel;
  end;

var
  ModelReport: TModelReport;

implementation

const
   TOP_MATERIAL_MARGIN = 30;
   TOP_LINE_MARGIN = 30;
   TOP_BUNKER_MARGIN = 30;

{$R *.DFM}

{ TModelReport }

procedure TModelReport.LoadFromModel;
var
  i, temp1, temp2: integer;
  QMaterialName1, QMaterialMx1, QMaterialSigma1, QMaterialLamda1 : TQRLabel;

  QLineName1, QLinePart1, QLineMType1, QMinPart1 : TQrLabel;

  QBunkerName1, QBunkerCapacity1, QBunkerCurAmount1, QBunkerMaterial1: TQrLabel;

  QBunkerName1_g, QBunkerCapacity1_g, QBunkerCurAmount1_g, QBunkerMaterial1_g: TQrLabel;

  MIndex : integer;
begin
   if not assigned(Model) then exit;
   QTime.Caption := Time2Works(Model.AllTime);

//  Типы сырья
   with Model.Materials do
   for i := Low(List) to High(List) do
   begin
      QMaterialName1 := TQRLabel.Create(self);
      QMaterialMx1 := TQRLabel.Create(self);
      QMaterialSigma1 := TQRLabel.Create(self);
      QMaterialLamda1 := TQRLabel.Create(self);

      QMaterialName1.Parent := QRBand2;
      QMaterialMx1.Parent := QRBand2;
      QMaterialSigma1.Parent := QRBand2;
      QMaterialLamda1.Parent := QRBand2;

      QMaterialName1.AutoSize := false;
      QMaterialMx1.AutoSize := false;
      QMaterialSigma1.AutoSize := false;
      QMaterialLamda1.AutoSize := false;

      QMaterialName1.Font.Name := 'MS Sans Serif';
      QMaterialName1.Font.Size := 10;
      QMaterialMx1.Font.Name := 'MS Sans Serif';
      QMaterialMx1.Font.Size := 10;
      QMaterialSigma1.Font.Name := 'MS Sans Serif';
      QMaterialSigma1.Font.Size := 10;
      QMaterialLamda1.Font.Name := 'MS Sans Serif';
      QMaterialLamda1.Font.Size := 10;

      QMaterialSigma1.Alignment := taRightJustify;
      QMaterialMx1.Alignment := taRightJustify;
      QMaterialLamda1.Alignment := taRightJustify;

      QMaterialName1.Left := QMaterialName.Left;
      QMaterialMx1.Left := QMaterialMx.Left;
      QMaterialSigma1.Left := QMaterialSigma.Left;
      QMaterialLamda1.Left := QMaterialLamda.Left;

      QMaterialName1.width := QMaterialName.width;
      QMaterialMx1.width := QMaterialMx.width;
      QMaterialSigma1.width := QMaterialSigma.width;
      QMaterialLamda1.width := QMaterialLamda.width;

      QMaterialName1.top := QMaterialName.Top + i * TOP_MATERIAL_MARGIN + 60;
      QMaterialMx1.top := QMaterialMx.Top + i * TOP_MATERIAL_MARGIN + 60;
      QMaterialSigma1.top := QMaterialSigma.top + i * TOP_MATERIAL_MARGIN + 60;
      QMaterialLamda1.top := QMaterialLamda.top + i * TOP_MATERIAL_MARGIN + 60;

      QMaterialName1.Caption := (List[i] as TMaterial).Name;
      QMaterialMx1.Caption := FloatToStr((List[i] as TMaterial).Mx * 3.600);
      QMaterialSigma1.Caption := FloatToStr((List[i] as TMaterial).Sigma);
      QMaterialLamda1.Caption := FloatToStr((List[i] as TMaterial).Lamda * 3.600);
   end;

//  Линии обработки
   temp1 := - (QLines.Top - QLinesLine.Top);
   temp2 := - (QLines.Top - QLineName.Top);

   if Model.Materials.Count > 0 then
     QLines.Top := QMaterialName1.Top + 70
   else
     QLines.Top := QMaterialName.Top + 70;

   QLinesLine.Top := QLines.Top + temp1;
   QLineName.Top := QLines.Top + temp2;
   QLinePart.Top := QLineName.Top;
   QMinPart.Top := QLineName.Top;
   QLineMType.Top := QLineName.Top;

   with Model.Lines do
   for i := Low(List) to High(List) do
   begin
      QLineName1 := TQRLabel.Create(self);
      QLinePart1 := TQRLabel.Create(self);
      QLineMType1 := TQRLabel.Create(self);
      QMinPart1 := TQRLabel.Create(self);

      QLineName1.Parent := QRBand2;
      QLinePart1.Parent := QRBand2;
      QMinPart1.Parent := QRBand2;
      QLineMType1.Parent := QRBand2;

      QLineName1.AutoSize := false;
      QLinePart1.AutoSize := false;
      QMinPart1.AutoSize := false;
      QLineMType1.AutoSize := false;

      QLineName1.Font.Name := 'MS Sans Serif';
      QLineName1.Font.Size := 10;
      QLinePart1.Font.Name := 'MS Sans Serif';
      QLinePart1.Font.Size := 10;
      QMinPart1.Font.Name := 'MS Sans Serif';
      QMinPart1.Font.Size := 10;
      QLineMType1.Font.Name := 'MS Sans Serif';
      QLineMType1.Font.Size := 10;

      QLinePart1.Alignment := taRightJustify;
      QMinPart1.Alignment := taRightJustify;

      QLineName1.Left := QLineName.Left;
      QLinePart1.Left := QLinePart.Left;
      QMinPart1.Left := QMinPart.Left;
      QLineMType1.Left := QLineMType.Left;

      QLineName1.width := QLineName.width;
      QLinePart1.width := QLinePart.width;
      QMinPart1.width := QMinPart.width;
      QLineMType1.width := QLineMType.width;

      QLineName1.top := QLineName.Top + i  * TOP_LINE_MARGIN + 40;
      QLinePart1.top := QLinePart.Top + i * TOP_LINE_MARGIN + 40;
      QMinPart1.top := QMinPart.Top + i * TOP_LINE_MARGIN + 40;
      QLineMType1.top := QLineMType.top + i * TOP_LINE_MARGIN + 40;

      QLineName1.Caption := (List[i] as TAssembleLine).Name;
      QLinePart1.Caption := Massa2Str((List[i] as TAssembleLine).PartCapacity);
      QMinPart1.Caption := Massa2Str((List[i] as TAssembleLine).MinPart);

      MIndex := Model.Materials.FindByNumber(((List[i] as TAssembleLine).CurMaterialType));
      if MIndex <> -1 then
        QLineMType1.Caption :=  Model.Materials.List[MIndex].Name
      else
        QLineMType1.Caption := NoLink;
   end;

// Коммерческие Бункеры
   temp1 := - (QBunkers.Top - QBunkersLine.Top);
   temp2 := - (QBunkers.Top - QBunkerName.Top);

   if Model.Lines.Count > 0 then
     QBunkers.Top := QLineName1.Top + 70
   else
     QBunkers.Top := QLineName.Top + 70;

   QBunkersLine.Top := QBunkers.Top + temp1;
   QBunkerName.Top := QBunkers.Top + temp2;
   QBunkerCapacity.Top := QBunkerName.Top;
   QBunkerCurAmount.Top := QBunkerName.Top;
   QBunkerMaterial.Top := QBunkerName.Top;

   with Model.CommBunkers do
   for i := Low(List) to High(List) do
   begin
      QBunkerName1 := TQRLabel.Create(self);
      QBunkerCapacity1 := TQRLabel.Create(self);
      QBunkerCurAmount1 := TQRLabel.Create(self);
      QBunkerMaterial1 := TQRLabel.Create(self);

      QBunkerName1.Parent := QRBand2;
      QBunkerCapacity1.Parent := QRBand2;
      QBunkerCurAmount1.Parent := QRBand2;
      QBunkerMaterial1.Parent := QRBand2;

      QBunkerName1.AutoSize := false;
      QBunkerCapacity1.AutoSize := false;
      QBunkerCurAmount1.AutoSize := false;
      QBunkerMaterial1.AutoSize := false;

      QBunkerName1.Font.Name := 'MS Sans Serif';
      QBunkerName1.Font.Size := 10;
      QBunkerCapacity1.Font.Name := 'MS Sans Serif';
      QBunkerCapacity1.Font.Size := 10;
      QBunkerCurAmount1.Font.Name := 'MS Sans Serif';
      QBunkerCurAmount1.Font.Size := 10;
      QBunkerMaterial1.Font.Name := 'MS Sans Serif';
      QBunkerMaterial1.Font.Size := 10;

      QBunkerCapacity1.Alignment := taRightJustify;
      QBunkerCurAmount1.Alignment := taRightJustify;

      QBunkerName1.Left := QBunkerName.Left;
      QBunkerCapacity1.Left := QBunkerCapacity.Left;
      QBunkerCurAmount1.Left := QBunkerCurAmount.Left;
      QBunkerMaterial1.Left := QBunkerMaterial.Left;

      QBunkerName1.width := QBunkerName.width;
      QBunkerCapacity1.width := QBunkerCapacity.width;
      QBunkerCurAmount1.width := QBunkerCurAmount.width;
      QBunkerMaterial1.width := QBunkerMaterial.width;

      QBunkerName1.Height := 51;
      QBunkerCapacity1.Height := 51;
      QBunkerCurAmount1.Height := 51;
      QBunkerMaterial1.Height := 51;

      QBunkerName1.top := QBunkerName.Top + i  * TOP_BUNKER_MARGIN + 80;
      QBunkerCapacity1.top := QBunkerName.Top + i  * TOP_BUNKER_MARGIN + 80;
      QBunkerCurAmount1.top := QBunkerName.Top + i  * TOP_BUNKER_MARGIN + 80;
      QBunkerMaterial1.top := QBunkerName.Top + i  * TOP_BUNKER_MARGIN + 80;

      QBunkerName1.Caption := (List[i] as TBunker).Name;
      QBunkerCapacity1.Caption := Massa2Str((List[i] as TBunker).Capacity);
      QBunkerCurAmount1.Caption := Massa2Str((List[i] as TBunker).CurAmount);

      MIndex := Model.Lines.FindByNumber(((List[i] as TBunker).Line));
      if  MIndex <> -1 then
        QBunkerMaterial1.Caption := Model.Lines.List[MIndex].Name
      else
        QBunkerMaterial1.Caption := NoLink;

   end;


// Давальческие Бункеры
   temp1 := - (QBunkers_g.Top - QBunkersLine_g.Top);
   temp2 := - (QBunkers_g.Top - QBunkerName_g.Top);

   if Model.CommBunkers.Count > 0 then
     QBunkers_g.Top := QBunkerName1.Top + 70
   else
     QBunkers_g.Top := QBunkerName.Top + 70;

   QBunkersLine_g.Top := QBunkers_g.Top + temp1;
   QBunkerName_g.Top := QBunkers_g.Top + temp2;
   QBunkerCapacity_g.Top := QBunkerName_g.Top;
   QBunkerCurAmount_g.Top := QBunkerName_g.Top;
   QBunkerMaterial_g.Top := QBunkerName_g.Top;

   with Model.GivenBunkers do
   for i := Low(List) to High(List) do
   begin
      QBunkerName1_g := TQRLabel.Create(self);
      QBunkerCapacity1_g := TQRLabel.Create(self);
      QBunkerCurAmount1_g := TQRLabel.Create(self);
      QBunkerMaterial1_g := TQRLabel.Create(self);

      QBunkerName1_g.Parent := QRBand2;
      QBunkerCapacity1_g.Parent := QRBand2;
      QBunkerCurAmount1_g.Parent := QRBand2;
      QBunkerMaterial1_g.Parent := QRBand2;

      QBunkerName1_g.AutoSize := false;
      QBunkerCapacity1_g.AutoSize := false;
      QBunkerCurAmount1_g.AutoSize := false;
      QBunkerMaterial1_g.AutoSize := false;

      QBunkerName1_g.Font.Name := 'MS Sans Serif';
      QBunkerName1_g.Font.Size := 10;
      QBunkerCapacity1_g.Font.Name := 'MS Sans Serif';
      QBunkerCapacity1_g.Font.Size := 10;
      QBunkerCurAmount1_g.Font.Name := 'MS Sans Serif';
      QBunkerCurAmount1_g.Font.Size := 10;
      QBunkerMaterial1_g.Font.Name := 'MS Sans Serif';
      QBunkerMaterial1_g.Font.Size := 10;

      QBunkerCapacity1_g.Alignment := taRightJustify;
      QBunkerCurAmount1_g.Alignment := taRightJustify;

      QBunkerName1_g.Left := QBunkerName_g.Left;
      QBunkerCapacity1_g.Left := QBunkerCapacity_g.Left;
      QBunkerCurAmount1_g.Left := QBunkerCurAmount_g.Left;
      QBunkerMaterial1_g.Left := QBunkerMaterial_g.Left;

      QBunkerName1_g.width := QBunkerName_g.width;
      QBunkerCapacity1_g.width := QBunkerCapacity_g.width;
      QBunkerCurAmount1_g.width := QBunkerCurAmount_g.width;
      QBunkerMaterial1_g.width := QBunkerMaterial_g.width;

      QBunkerName1_g.Height := 51;
      QBunkerCapacity1_g.Height := 51;
      QBunkerCurAmount1_g.Height := 51;
      QBunkerMaterial1_g.Height := 51;

      QBunkerName1_g.top := QBunkerName_g.Top + i  * TOP_BUNKER_MARGIN + 80;
      QBunkerCapacity1_g.top := QBunkerName_g.Top + i  * TOP_BUNKER_MARGIN + 80;
      QBunkerCurAmount1_g.top := QBunkerName_g.Top + i  * TOP_BUNKER_MARGIN + 80;
      QBunkerMaterial1_g.top := QBunkerName_g.Top + i  * TOP_BUNKER_MARGIN + 80;

      QBunkerName1_g.Caption := (List[i] as TBunker).Name;
      QBunkerCapacity1_g.Caption := Massa2Str((List[i] as TBunker).Capacity);
      QBunkerCurAmount1_g.Caption := Massa2Str((List[i] as TBunker).CurAmount);

      MIndex := Model.Lines.FindByNumber(((List[i] as TBunker).Line));
      if  MIndex <> -1 then
        QBunkerMaterial1_g.Caption := Model.Lines.List[MIndex].Name
      else
        QBunkerMaterial1_g.Caption := NoLink;
   end;
end;


end.

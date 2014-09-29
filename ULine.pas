unit ULine;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UEmbedForm, StdCtrls, ExtCtrls,
  tc, Grids;

type
  TFLine = class(TEmbedForm)
    Panel4: TPanel;
    Label1: TLabel;
    Panel1: TPanel;
    Label5: TLabel;
    MaterialBox: TComboBox;
    Panel3: TPanel;
    grid: TStringGrid;
    Label2: TLabel;
    Panel2: TPanel;
    Bevel1: TBevel;
    Label3: TLabel;
    Panel5: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure gridKeyPress(Sender: TObject; var Key: Char);
  public
     procedure RefreshMaterialBox;

     procedure Load(Line : TAssembleLine);
     procedure Save(Line : TAssembleLine);

     procedure SetPartCapacity(value : massa);
     function GetPartCapacity : massa;

     procedure SetMinPart(value : massa);
     function GetMinPart : massa;

     procedure SetMaterialType(value : integer);
     function GetMaterialType : integer;

     property PartCapacity : massa read GetPartCapacity write SetPartCapacity;
     property MinPart : massa read GetMinPart write SetMinPart;
     property MaterialType : integer read GetMaterialType write SetMaterialType;
  end;

var
  FLine: TFLine;

implementation

Uses Umassa, UModel;

var
  FPartCapacity : TFMassa;
  FMinPart : TFMassa;
  NoMaterials : TLabel;

{$R *.DFM}

procedure TFLine.FormCreate(Sender: TObject);
begin
  inherited;
  Panel1.BorderStyle := bsNone;
  Panel5.BorderStyle := bsNone;

  NoMaterials := TLabel.Create(self);

  FPartCapacity := TFMassa.CreateEmbedded(self, Panel1);
  FPartCapacity.show;

  FMinPart := TFMassa.CreateEmbedded(self, Panel5);
  FMinPart.show;
end;

function TFLine.GetMaterialType: integer;
begin
   with MaterialBox do
     if ItemIndex = -1 then result := -1
     else
       result := (Items.Objects[ItemIndex] as TMaterial).Number;
end;

function TFLine.GetPartCapacity: massa;
begin
   result := FPartCapacity.Number;
end;

procedure TFLine.Load(Line: TAssembleLine);
var
  list : TObjectArray;
  row, col : integer;
  t : time;
begin
   list := FModel.Model.Materials.List;
   if Length(List) = 0 then
   begin
      NoMaterials := TLabel.Create(self);
      with NoMaterials do
      begin
         Visible := false;
         Parent := Panel3;
         Caption := mNoMaterials;
         Font.Color := clWhite;
         Font.Style := [fsBold];
         AutoSize := false;
         Align := alClient;
         Alignment := taCenter;
         Layout := tlCenter;
         Show;
      end;
      grid.hide;
      exit;
   end
   else
   begin
     NoMaterials.Hide;
     grid.show;
   end;

   //  устанавливаем размерность сетки
   grid.cells[0,0] := '(Типы сырья)';
   grid.ColCount := Length(list) + 1;
   grid.RowCount := Length(list) + 1;
   grid.FixedCols := 1;
   grid.FixedRows := 1;
   grid.ColWidths[0] := 150;

   //  заполняем заголовки
   for row := Low(list) to high(List) do
   begin
      grid.Cells[0,row + 1] := (List[row] as TMaterial).Name;
      grid.Cells[row + 1,0] := (List[row] as TMaterial).Name;
   end;

  // загружаем значения
  PartCapacity := Line.PartCapacity;
  MinPart := Line.MinPart;
  MaterialType := Line.CurMaterialType;

  for row := Low(list) to high(list) do
     for col := Low(list) to high(list) do
     begin
        t := Line.FReconfigure.GetReconfTime(
                      (List[row] as TMaterial).number,
                      (List[col] as TMaterial).number);

        if (abs(t + 1) > eps) then t := t / 3600;
        grid.Cells[row + 1, col + 1] := FloatToStr(t);
     end;
end;

procedure TFLine.Save(Line: TAssembleLine);
var
  list : TObjectArray;
  row, col : integer;
  t : time;
begin
  Line.PartCapacity := PartCapacity;
  Line.MinPart := MInPart;
  Line.CurMaterialType := MaterialType;

  list := FModel.Model.Materials.List;
  for row := Low(list) to high(list) do
     for col := Low(list) to high(list) do
     begin
        t := StrToFloat(grid.cells[row + 1, col + 1]);
        if abs(t + 1) > eps then t := t * 3600;

        Line.FReconfigure.SetReconfTime(
                      (List[row] as TMaterial).number,
                      (List[col] as TMaterial).number,  t);
     end;
end;

procedure TFLine.SetPartCapacity(value: massa);
begin
   FPartCapacity.Number := value;
end;

procedure TFLine.SetMaterialType(value: integer);
begin
   RefreshMaterialBox;
   MaterialBox.ItemIndex := FModel.Model.Materials.FindByNumber(value);
end;

procedure TFLine.RefreshMaterialBox;
var
  i : integer;
begin
  MaterialBox.Clear;
  with FModel.Model.Materials do
    for i := Low(List) to high(List) do
      MaterialBox.Items.AddObject(List[i].Name, List[i]);
end;


procedure TFLine.gridKeyPress(Sender: TObject; var Key: Char);
var
   t : real;
   e : ENotFloat;
begin
  inherited;
  if  (grid.row = grid.col) or
       not (
           (key in ['0'..'9'])    or
           (key = #8)             or
           (key = '-')            or
           (key = ',')
          )
      then key := #27;

//  try
//     t := StrToFloat(grid.cells[grid.row, grid.col]);
//     if (t < 0) and not(abs(t + 1) > eps) then
//         raise e.Create;
//  except
//     MessageDlg(e.Message , mtError, [mbOk], 0);
//  end;
end;

function TFLine.GetMinPart: massa;
begin
   result := FMinPart.Number;
end;

procedure TFLine.SetMinPart(value: massa);
begin
   FMinPart.Number := value;
end;

end.

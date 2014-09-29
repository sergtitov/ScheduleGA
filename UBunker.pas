unit UBunker;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UEmbedForm, ExtCtrls, StdCtrls,
  tc;

type
  TFBunker = class(TEmbedForm)
    Label1: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    Panel2: TPanel;
    Label5: TLabel;
    LineBox: TComboBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure RefreshLineBox;

    procedure Load(Bunker : TBunker);
    procedure Save(Bunker : TBunker);

    procedure SetCapacity(value : massa);
    function GetCapacity : massa;

    procedure SetCurAmount(Value : massa);
    function GetCurAmount : massa;

    procedure SetLine(value : integer);
    function GetLine : integer;

    property Capacity : massa read GetCapacity write SetCapacity;
    property CurAmount : massa read GetCurAmount write SetCurAmount;
    property Line : integer read GetLine write SetLine;
  end;

var
  FBunker: TFBunker;

implementation

uses UMassa, UModel;

var
  FCapacity,
  FCurAmount : TFMassa;

{$R *.DFM}

procedure TFBunker.FormCreate(Sender: TObject);
begin
  inherited;
  Panel1.BorderStyle := bsNone;
  Panel2.BorderStyle := bsNone;

  FCapacity := TFMassa.CreateEmbedded(self, Panel1);
  FCurAmount := TFMassa.CreateEmbedded(self, Panel2);

  FCapacity.Show;
  FCurAmount.Show;
end;

function TFBunker.GetCapacity: massa;
begin
   result := FCapacity.Number;
end;

function TFBunker.GetCurAmount: massa;
begin
   result := FCurAmount.Number;
end;

function TFBunker.GetLine: integer;
begin
   with LineBox do
     if ItemIndex = -1 then result := -1
     else
       result := (Items.Objects[ItemIndex] as TAssembleLine).Number;
end;

procedure TFBunker.Load(Bunker: TBunker);
begin
   Capacity := Bunker.Capacity;
   CurAmount := Bunker.CurAmount;
   Line := Bunker.Line;
end;

procedure TFBunker.RefreshLineBox;
var
  i : integer;
begin
  LineBox.Clear;
  with FModel.Model.Lines do
    for i := Low(List) to high(List) do
      LineBox.Items.AddObject(List[i].Name, List[i]);
end;

procedure TFBunker.Save(Bunker: TBunker);
begin
  Bunker.Capacity := Capacity;
  Bunker.CurAmount := CurAmount;
  Bunker.Line := Line;
end;

procedure TFBunker.SetCapacity(value: massa);
begin
   FCapacity.Number := value;
end;

procedure TFBunker.SetCurAmount(Value: massa);
begin
   FCurAmount.Number := value;
end;

procedure TFBunker.SetLine(value: integer);
begin
   RefreshLineBox;
   LineBox.ItemIndex := FModel.Model.Lines.FindByNumber(value);
end;

end.

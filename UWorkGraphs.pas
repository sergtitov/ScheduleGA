unit UWorkGraphs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, tc;

type
  TFWorkGraphs = class(TForm)
    Button1: TButton;
    Button2: TButton;
    GBox: TComboBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure GBoxDropDown(Sender: TObject);
  private
    function GetMNumber: integer;
    { Private declarations }
  public
      Model : TModel;
      procedure Load;
      property MNumber : integer read GetMNumber;
  end;

var
  FWorkGraphs: TFWorkGraphs;

implementation

uses UGraph, UModel;

{$R *.DFM}

procedure TFWorkGraphs.Load;
var
  i : integer;
begin
  if not assigned(Model) then exit;
  GBox.Clear;
  with Model.Materials do
    for i := Low(List) to high(List) do
      GBox.Items.AddObject(List[i].Name, List[i]);
end;


procedure TFWorkGraphs.FormCreate(Sender: TObject);
begin
    Model := nil;
end;

function TFWorkGraphs.GetMNumber: integer;
begin
   with GBox do
     if ItemIndex = -1 then result := -1
     else
       with Model.Materials do
         result := FindByNumber((Items.Objects[ItemIndex] as TMaterial).Number);
end;

procedure TFWorkGraphs.Button2Click(Sender: TObject);
begin
      if MNumber = -1 then exit;
      if assigned(GraphReport) then GraphReport.free;
      GraphReport := TGraphReport.Create(nil);
      with GraphReport do
      begin
        GraphReport.Model := FWorkGraphs.Model;
        Material := MNumber;
        LoadFromModel;
        Update;
        Preview;
      end;
end;

procedure TFWorkGraphs.GBoxDropDown(Sender: TObject);
begin
   Load;
end;

end.

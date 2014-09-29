unit URParams;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, tc, UTime;

type
  TFRParams = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LineBox: TComboBox;
    Panel1: TPanel;
    FromBox: TComboBox;
    ToBox: TComboBox;
    Button2: TButton;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  public
      Item : RItem;
      Model : TModel;

      procedure RefreshLineBox;
      procedure RefreshFromBox;
      procedure RefreshToBox;      

      procedure SetLine(value : integer);
      function GetLine : integer;

      procedure SetTime(value : time);
      function GetTime : time;

      procedure SetFrom(value : integer);
      function GetFrom : integer;

      procedure SetTo(value : integer);
      function GetTo : integer;

      procedure Load;
      procedure Save;

      property pLine : integer read GetLine write SetLine;
      property pTime : time read GetTime write SetTime;
      property pFrom : integer read GetFrom write SetFrom;
      property pTo   : integer read GetTo write SetTo;
  end;

var
  FRParams: TFRParams;


implementation


var
  FTime : TFTime;

{$R *.DFM}

procedure TFRParams.FormActivate(Sender: TObject);
begin
    Load;
end;

procedure TFRParams.Button1Click(Sender: TObject);
var
  l : TAssembleLine;

begin
  if (pLine = -1) or (pFrom = -1) or (pTo = -1) then
  begin
    MessageDlg('Такая перенастройка невозможна!', mtError, [mbOk], 0);
    exit;
  end;

  l := Model.Lines.List[Model.Lines.FindByNumber(pLine)] as TAssembleLine;
  if (L.FReconfigure.GetReconfTime(pFrom, pTo) = -1) then
  begin
    MessageDlg('Выбранная линия не может быть так перенастроена!' , mtError, [mbOk], 0);
    exit;
  end;

  Save;
  ModalResult := mrOk;
end;

procedure TFRParams.Load;
begin
   pTime := Item.rTime;
   pFrom := Item.rFrom;
   pTo   := Item.rTo;
   pLine := Item.rLine;
end;

procedure TFRParams.Save;
begin
    Item.rTime := pTime;
    Item.rFrom := pFrom;
    Item.rTo   := pTo;
    Item.rLine := pLine;
end;

function TFRParams.GetFrom: integer;
begin
   with FromBox do
     if ItemIndex = -1 then result := -1
     else
       result := (Items.Objects[ItemIndex] as TMaterial).Number;
end;

function TFRParams.GetLine: integer;
begin
   with LineBox do
     if ItemIndex = -1 then result := -1
     else
       result := (Items.Objects[ItemIndex] as TAssembleLine).Number;
end;

function TFRParams.GetTime: time;
begin
   result := FTime.Number;
end;

function TFRParams.GetTo: integer;
begin
   with ToBox do
     if ItemIndex = -1 then result := -1
     else
       result := (Items.Objects[ItemIndex] as TMaterial).Number;
end;

procedure TFRParams.SetFrom(value: integer);
begin
   RefreshFromBox;
   FromBox.ItemIndex := Model.Materials.FindByNumber(value);
end;

procedure TFRParams.SetLine(value: integer);
begin
   RefreshLineBox;
   LineBox.ItemIndex := Model.Lines.FindByNumber(value);
end;

procedure TFRParams.SetTime(value: time);
begin
    FTime.Number := value;
end;

procedure TFRParams.SetTo(value: integer);
begin
   RefreshToBox;
   ToBox.ItemIndex := Model.Materials.FindByNumber(value);
end;

procedure TFRParams.FormCreate(Sender: TObject);
begin
    Panel1.BorderStyle := bsNone;

    FTime := TFTime.CreateEmbedded(self, Panel1);
    FTime.Show;
end;

procedure TFRParams.RefreshLineBox;
var
  i : integer;
begin
  LineBox.Clear;
  with Model.Lines do
    for i := Low(List) to high(List) do
      LineBox.Items.AddObject(List[i].Name, List[i]);
end;


procedure TFRParams.RefreshFromBox;
var
  i : integer;
begin
  FromBox.Clear;
  with Model.Materials do
    for i := Low(List) to high(List) do
      FromBox.Items.AddObject(List[i].Name, List[i]);
end;

procedure TFRParams.RefreshToBox;
var
  i : integer;
begin
  ToBox.Clear;
  with Model.Materials do
    for i := Low(List) to high(List) do
      ToBox.Items.AddObject(List[i].Name, List[i]);
end;

end.

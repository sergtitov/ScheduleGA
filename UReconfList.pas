unit UReconfList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UEmbedForm, StdCtrls, ExtCtrls, ComCtrls, Grids, tc;

type
  TFReconfList = class(TEmbedForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Panel2: TPanel;
    Header: THeaderControl;
    Grid: TStringGrid;
    StatusBar1: TStatusBar;
    procedure HeaderSectionResize(HeaderControl: THeaderControl;
      Section: THeaderSection);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
      Model : TModel;

      procedure Load;
      function  Change(Item : RItem) : boolean;
  end;

var
  FReconfList: TFReconfList;

implementation

uses URParams, UModel;

{$R *.DFM}

procedure TFReconfList.HeaderSectionResize(
  HeaderControl: THeaderControl; Section: THeaderSection);
begin
  if Section.Index = 0 then
    Grid.ColWidths[Section.Index] := Section.Width - 4
  else
    Grid.ColWidths[Section.Index] := Section.Width;
end;

procedure TFReconfList.FormActivate(Sender: TObject);
begin
    Grid.ColWidths[0] := Header.Sections[0].Width - 4;
    Grid.ColWidths[1] := Header.Sections[1].Width;
    Grid.ColWidths[2] := Header.Sections[2].Width;
    Grid.ColWidths[3] := Header.Sections[3].Width;
    Load;
end;

procedure TFReconfList.Button1Click(Sender: TObject);
var
  Item : RItem;
begin
  Item := RItem.Create(Model.ReconfList);
  if not Change(Item) then exit;
  Model.ReconfList.Append(Item);
  Load;
end;

procedure TFReconfList.Button3Click(Sender: TObject);
begin
   if Model.ReconfList.Count < 1 then
   begin
       MessageDlg('В списке перенастройки отсутствуют объекты!', mtError, [mbOk], 0);
       exit;
   end;
   if MessageDlg('Удалить выделенный элемент?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;   
   Model.ReconfList.Delete(grid.Row);
   Load;
end;

procedure TFReconfList.Load;
var
  i : integer;
  id : Integer;
begin
    StatusBar1.SimpleText :=  format('Критерий оптимизации: %d', [Round(FModel.ModelCopy.OptimKoef / 1000)]);
    Model.ReconfList.SortAll;
   for i := 0 to grid.RowCount do
   begin
           grid.cells[0, i] := '';
           grid.cells[1, i] := '';
           grid.cells[2, i] := '';
           grid.cells[3, i] := '';
    end;

    grid.RowCount := Model.ReconfList.Count;
    With Model.ReconfList do
    for i := Low(List) to High(List) do
    with (List[i] as RItem) do
      begin
         id := Model.Lines.FindByNumber(rLine);
         if id <> -1 then
           grid.cells[0, i] := Model.Lines.List[id].Name
         else
           grid.cells[0, i] := NoLink;

         grid.cells[1, i] := ShortTime2Works(rTime);

         id := Model.Materials.FindByNumber(rFrom);
         if id <> -1 then
           grid.cells[2, i] := Model.Materials.List[id].Name
         else
           grid.cells[2, i] := NoLink;

         id := Model.Materials.FindByNumber(rTo);
         if id <> -1 then
           grid.cells[3, i] := Model.Materials.List[id].Name
         else
           grid.cells[3, i] := NoLink;
      end;
end;

function TFReconfList.Change(Item: RItem) : boolean;
begin
    FRParams.Item := Item;
    FRParams.Model := Model;
    FRParams.ShowModal;
    result := (FRParams.ModalResult = mrOk)
end;

procedure TFReconfList.Button2Click(Sender: TObject);
begin
    if Model.ReconfList.Count < 1 then
    begin
        MessageDlg('В списке перенастройки отсутствуют объекты!', mtError, [mbOk], 0);
        exit;
    end;
    Change(Model.ReconfList.List[grid.row] as RItem);
    Load;
end;

end.

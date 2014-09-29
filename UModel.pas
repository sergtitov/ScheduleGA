unit UModel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, ExtCtrls, StdCtrls, ImgList, ActnList, tc;

type
  TFModel = class(TForm)
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    ToolBar1: TToolBar;
    Panel3: TPanel;
    Panel4: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    TreeView1: TTreeView;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ModelParamsActions: TActionList;
    AAddElement: TAction;
    ADeleteElement: TAction;
    AApply: TAction;
    AllImages: TImageList;
    OpenD: TOpenDialog;
    SaveD: TSaveDialog;
    ASave: TAction;
    ALoad: TAction;
    Status: TStatusBar;
    TreeImages: TImageList;
    ToolButton8: TToolButton;
    APrint: TAction;
    ToolButton9: TToolButton;
    NoObjectLabel: TLabel;
    AClear: TAction;
    ToolButton10: TToolButton;
    procedure AApplyExecute(Sender: TObject);
    procedure ALoadExecute(Sender: TObject);
    procedure ASaveExecute(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AAddElementExecute(Sender: TObject);
    procedure TreeView1Editing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure ADeleteElementExecute(Sender: TObject);
    procedure TreeView1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure TreeView1Edited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure TreeView1Changing(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure TreeView1Expanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure APrintExecute(Sender: TObject);
    procedure AClearExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    Model : TModel;
    ModelCopy : TModel;
    ModelName : string;
    Modified : boolean;    
    procedure InitTreeView;
    procedure SaveToModel;
    procedure LoadFromModel;
    procedure Ref;
  end;


var
  FModel: TFModel;

implementation

uses UAllTime, UBunker, UMaterial, ULine, UModelReport;

{$R *.DFM}

procedure TFModel.AApplyExecute(Sender: TObject);
begin
   SaveToModel;
   ModalResult := mrOK;
end;

procedure TFModel.ALoadExecute(Sender: TObject);
begin
    if not OpenD.Execute then exit;
    if visible then TreeView1.FullCollapse;
    if visible then TreeView1Change(TreeView1,TreeView1.Selected);
    Model.LoadFromFile (OPenD.FileName);
    Modified := false;
    if visible then LoadFromModel;
    ModelName := ExtractFileName(OpenD.FileName);
    MessageDlg(LoadSuccesfully, mtInformation, [mbOk], 0);
end;

procedure TFModel.ASaveExecute(Sender: TObject);
begin
   if not SaveD.Execute then exit;
   SaveToModel;
   TreeView1.FullCollapse;
   Model.SaveToFile (SaveD.FileName);
   Modified := false;
   ModelName := ExtractFileName(SaveD.FileName);   
   MessageDlg(SaveSuccesfully, mtInformation, [mbOk], 0);
end;

procedure TFModel.TreeView1Click(Sender: TObject);
begin
  TreeView1Change(Sender, TreeView1.Selected);
end;


procedure TFModel.FormCreate(Sender: TObject);
begin
  InitTreeView;
  Model := TModel.Create;
  ModelCopy := TModel.Create;
  ModelName := NO_NAME;
  Modified := false;

  FAllTime := TFAllTime.CreateEmbedded(self, Panel2);
  FAllTime.SetBounds (10, 30, FAllTime.width, FAllTime.Height);

  FBunker := TFBunker.CreateEmbedded(self, Panel2);
  FBunker.SetBounds(10, 30, FBunker.width, FBunker.Height);

  FMaterial := TFMaterial.CreateEmbedded(self, Panel2);
  FMaterial.SetBounds(10, 30, FMaterial.width, FMaterial.Height);

  FLine := TFLine.CreateEmbedded (self, Panel2);
  FLine.SetBounds(10, 30, FLine.width, FLine.Height);
end;



procedure TFModel.InitTreeView;
var
  Data : ^TNodeData;
  ModelFolder : TTreeNode;
  BunkerFolder : TTreeNode;
  GivenFolder : TTreeNode;
  CommFolder : TTreeNode;
  LineFolder : TTreeNode;
  MaterialFolder : TTreeNode;
begin
   with TreeView1 do
   begin
      repeat
        Items[0].Delete;
      until items.count = 0;

      Data := nil;
      GetMem(Data, sizeof(TNodeData));
      Data^.NodeType := ntModelFolder;
      Data^.LinkedObject := Model;
      ModelFolder := Items.AddObjectFirst(nil, 'Модель', Data);

      Data := nil;
      GetMem(Data, sizeof(TNodeData));
      Data^.NodeType := ntBunkerFolder;
      Data^.LinkedObject := nil;
      BunkerFolder := Items.AddChildObject(ModelFolder, 'Бункеры', Data);
      BunkerFolder.ImageIndex := 2;
      BunkerFolder.SelectedIndex := 2;

      Data := nil;
      GetMem(Data, sizeof(TNodeData));
      Data^.NodeType := ntCommFolder;
      Data^.LinkedObject := nil;
      CommFolder := Items.AddChildObject(BunkerFolder, 'Коммерческое', Data);
      CommFolder.ImageIndex := 2;
      CommFolder.SelectedIndex := 2;

      Data := nil;
      GetMem(Data, sizeof(TNodeData));
      Data^.NodeType := ntGivenFolder;
      Data^.LinkedObject := nil;
      GivenFolder := Items.AddChildObject(BunkerFolder, 'Давальческое', Data);
      GivenFolder.ImageIndex := 2;
      GivenFolder.SelectedIndex := 2;

      Data := nil;
      GetMem(Data, sizeof(TNodeData));
      Data^.NodeType := ntLineFolder;
      Data^.LinkedObject := nil;
      LineFolder := Items.AddChildObject(ModelFolder, 'Линии обработки', Data);
      LineFolder.ImageIndex := 2;
      LineFolder.SelectedIndex := 2;

      Data := nil;
      GetMem(Data, sizeof(TNodeData));
      Data^.NodeType := ntMaterialFolder;
      Data^.LinkedObject := nil;
      MaterialFolder := Items.AddChildObject(ModelFolder, 'Типы сырья', Data);
      MaterialFolder.ImageIndex := 2;
      MaterialFolder.SelectedIndex := 2;

      Data := nil;
      GetMem(Data, sizeof(TNodeData));
      Data^.NodeType := ntAllTime;
      Data^.LinkedObject := nil;
      MaterialFolder := Items.AddChildObject(ModelFolder, 'Время моделирования', Data);
      MaterialFolder.ImageIndex := 3;
      MaterialFolder.SelectedIndex := 3;
   end;
   AAddElement.Enabled := false;
   ADeleteElement.Enabled := false;
end;

procedure TFModel.AAddElementExecute(Sender: TObject);
var
  SelNode, node : TTreeNode;
  Data : ^TNodeData;
  Bunker : TBunker;
  Line : TAssembleLine;
  Material : TMaterial;
begin
  node := nil;
  SelNode := TreeView1.Selected;
  case  TNodeData(SelNode.Data^).NodeType of
    ntCommFolder,
    ntGivenFolder :
       begin
         Data := nil;
         case  TNodeData(SelNode.Data^).NodeType of
           ntCommFolder  : Bunker := TBunker.Create(Model.CommBunkers);
           ntGivenFolder : Bunker := TBunker.Create(Model.GivenBunkers);
         end;

         GetMem(Data, sizeof(TNodeData));
         Data^.NodeType := ntBunker;
         case  TNodeData(SelNode.Data^).NodeType of
           ntCommFolder  : Model.CommBunkers.Append(Bunker);
           ntGivenFolder : Model.GivenBunkers.Append(Bunker);
         end;
         Data^.LinkedObject := Bunker;
         node := TreeView1.Items.AddChildObject(SelNode, Bunker.Name , Data);
         node.ImageIndex := 1;
         node.SelectedIndex := 1;
       end;

    ntLineFolder :
       begin
         Data := nil;
         Line := TAssembleLine.Create(Model.Lines);
         GetMem(Data, sizeof(TNodeData));
         Data^.NodeType := ntLine;
         Model.Lines.Append (Line);
         Data^.LinkedObject := Line;
         node := TreeView1.Items.AddChildObject(SelNode, Line.Name , Data);
         node.ImageIndex := 4;
         node.SelectedIndex := 4;
       end;

    ntMaterialFolder:
       begin
         Data := nil;
         Material := TMaterial.Create(Model.Materials);
         GetMem(Data, sizeof(TNodeData));
         Data^.NodeType := ntMaterial;
         Model.Materials.Append(Material);
         Data^.LinkedObject := Material;
         node := TreeView1.Items.AddChildObject(SelNode, Material.Name, Data);
         node.ImageIndex := 5;
         node.SelectedIndex := 5;
       end;
  end;
  SelNode.Expand(false);
  if assigned(node) then
  begin
    node.Selected := true;
    node.EditText;
  end;
  TreeView1Click(TreeView1);
end;

procedure TFModel.TreeView1Editing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
var
  Data : TNodeData;
begin
   Data := TNodeData(TreeView1.Selected.Data^);
   case Data.NodeType  of
      ntBunker,
      ntLine,
      ntMaterial :
                 AllowEdit := true;
      else
                 AllowEdit := false;
   end;
end;

procedure TFModel.ADeleteElementExecute(Sender: TObject);
var
  Data : TNodeData;
begin
   Data := TNodeData(TreeView1.Selected.Data^);
   if not (Data.LinkedObject is TListObject) then
   begin
     ShowMessage('ooops!');
     exit;
   end;

   if Data.NodeType = ntMaterial then
      if Model.IsMaterialUsed((Data.LinkedObject as TMaterial).Number) then
      begin
        MessageDlg(mCantDeleteMaterial,mtWarning, [mbOK], 0);
        exit;
      end;

   if Data.NodeType = ntLine then
      if Model.IsLineUsed((Data.LinkedObject as TAssembleLine).Number) then
      begin
        MessageDlg(mCantDeleteLine,mtWarning, [mbOK], 0);
        exit;
      end;

   (Data.LinkedObject as TListObject).ObjectList.Delete(TreeView1.Selected.Index);
   Data.LinkedObject.free;
   TreeView1.Items.Delete(TreeView1.Selected);
   TreeView1Click(TreeView1);
end;


procedure TFModel.TreeView1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case Key of
     VK_F2 : TreeView1.Selected.editText;
     VK_NEXT : TreeView1.Selected.Expand(false);
     VK_PRIOR : TreeView1.Selected.Collapse(false);
   end;
end;


procedure HideAllEditors;
begin
   FAllTime.hide;
   FBunker.Hide;
   FMaterial.Hide;
   FLine.Hide;
end;

procedure TFModel.TreeView1Change(Sender: TObject; Node: TTreeNode);
var
  Data : TNodeData;
begin
   Data := TNodeData(TreeView1.Selected.Data^);
   case Data.NodeType  of
      ntBunker,
      ntLine,
      ntMaterial :
              begin
                AAddElement.Enabled := false;
                ADeleteElement.Enabled := true;
              end;
      ntModelFolder,
      ntAllTime,
      ntBunkerFolder :
              begin
                AAddElement.Enabled := false;
                ADeleteElement.Enabled := false;
              end;
   else
              begin
                AAddElement.Enabled := true;
                ADeleteElement.Enabled := false;
              end;
   end;

   case Data.NodeType of
     ntAllTime :
       begin
         NoObjectLabel.Hide;
         FAllTime.Load(Model);
         FAllTime.Show;
         FAllTime.ActivateFocus;
       end;

     ntBunker :
       begin
         NoObjectLabel.Hide;
         FBunker.Load(Data.LinkedObject as TBunker);
         FBunker.Show;
       end;

     ntMaterial :
       begin
         NoObjectLabel.Hide;
         FMaterial.Load(Data.LinkedObject as TMaterial);
         FMaterial.Show;
       end;

     ntLine :
       begin
         NoObjectLabel.Hide;
         FLine.Load(Data.LinkedObject as TAssembleLine);
         FLine.Show;
       end;

     else
       begin
         HideAllEditors;
         NoObjectLabel.Show;
         NoObjectLabel.BringToFront;
       end;
   end;
end;

procedure TFModel.TreeView1Changing(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
var
  Data : TNodeData;
begin
   if TreeView1.Selected = nil then exit;
   Data := TNodeData(TreeView1.Selected.Data^);
   HideAllEditors;
   case Data.NodeType of

     ntAllTime   : FAllTime.Save(Model);

     ntBunker    : FBunker.Save(Data.LinkedObject as TBunker);

     ntMaterial  : FMaterial.Save(Data.LinkedObject as TMaterial);

     ntLine      : FLine.Save(Data.LinkedObject as TAssembleLine);

   end;
end;


procedure TFModel.TreeView1Edited(Sender: TObject; Node: TTreeNode;
  var S: String);
begin
    (TNodeData(Node.Data^).LinkedObject as TListObject).Name := S;
end;


procedure TFModel.LoadFromModel;
var
  i : integer;
  Data : ^TNodeData;
  node , root: TTreeNode;
begin
    TreeView1.FullCollapse;
    InitTreeView;
    root := TreeView1.Items[0];
    //  коммерческие бункеры
    with Model.CommBunkers  do
    for i := Low(List) to High(List) do
    begin
         Data := nil;
         GetMem(Data, sizeof(TNodeData));
         Data^.NodeType := ntBunker;
         Data^.LinkedObject := List[i];
         node := TreeView1.Items.AddChildObject(root.Item[0].Item[0] , List[i].Name , Data);
         node.ImageIndex := 1;
         node.SelectedIndex := 1;
    end;

    //  давальческие бункеры
    with Model.GivenBunkers  do
    for i := Low(List) to High(List) do
    begin
         Data := nil;
         GetMem(Data, sizeof(TNodeData));
         Data^.NodeType := ntBunker;
         Data^.LinkedObject := List[i];
         node := TreeView1.Items.AddChildObject(root.Item[0].Item[1], List[i].Name , Data);
         node.ImageIndex := 1;
         node.SelectedIndex := 1;
    end;

    //  Линии обработки
    with Model.Lines  do
    for i := Low(List) to High(List) do
    begin
         Data := nil;
         GetMem(Data, sizeof(TNodeData));
         Data^.NodeType := ntLine;
         Data^.LinkedObject := List[i];
         node := TreeView1.Items.AddChildObject(root.item[1], List[i].Name , Data);
         node.ImageIndex := 4;
         node.SelectedIndex := 4;
    end;

    //  Типы сырья
    with Model.Materials  do
    for i := Low(List) to High(List) do
    begin
         Data := nil;
         GetMem(Data, sizeof(TNodeData));
         Data^.NodeType := ntMaterial;
         Data^.LinkedObject := List[i];
         node := TreeView1.Items.AddChildObject(root.item[2], List[i].Name , Data);
         node.ImageIndex := 5;
         node.SelectedIndex := 5;
    end;
end;

procedure TFModel.SaveToModel;
var
 temp : boolean;
begin
   TreeView1Changing(TreeView1, TreeView1.Selected, temp);
end;


procedure TFModel.Ref;
begin
   TreeView1Change(TreeView1, TreeView1.Selected);
end;

procedure TFModel.FormActivate(Sender: TObject);
begin
//  LoadFromModel;
  TreeView1.OnExpanding := TreeView1Expanding;
  TreeView1.FullCollapse;
  HideAllEditors;
  Modified := true;
//  Ref;
end;

procedure TFModel.TreeView1Expanding(Sender: TObject; Node: TTreeNode;
  var AllowExpansion: Boolean);
begin
  if TNodeData(Node.Data^).NodeType = ntModelFolder then
      LoadFromModel;
  TreeView1.OnExpanding := nil;
  TreeView1.Items[0].Expand(false);
  AllowExpansion := false;
end;

procedure TFModel.APrintExecute(Sender: TObject);
begin
   SaveToModel;
   if assigned(ModelReport) then ModelReport.free;
   ModelReport := TModelReport.Create(nil);
   ModelReport.Model := Model;
   ModelReport.loadFromModel;
   ModelReport.Update;
   ModelReport.Preview;
end;

procedure TFModel.AClearExecute(Sender: TObject);
begin
  if visible then TreeView1.FullCollapse;
  if visible then TreeView1Change(TreeView1,TreeView1.Selected);
  Model.Clear;
  if visible then LoadFromModel;
end;

procedure TFModel.FormDestroy(Sender: TObject);
begin
   Model.Free;
   ModelCopy.Free;
end;

end.


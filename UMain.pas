unit UMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ActnList,
  tc, ToolWin, ComCtrls, ExtCtrls, StdCtrls, shellapi;

type
  TMain = class(TForm)
    MainMenu1: TMainMenu;
    NFile: TMenuItem;
    Nexit: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    ActionList1: TActionList;
    AExit: TAction;
    NParams: TMenuItem;
    NLines: TMenuItem;
    AModel: TAction;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    AAbout: TAction;
    AHelp: TAction;
    ControlBar1: TControlBar;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    ALinesReport: TAction;
    AModelReport: TAction;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ASolve: TAction;
    N11: TMenuItem;
    N12: TMenuItem;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    N13: TMenuItem;
    StatusBar1: TStatusBar;
    N14: TMenuItem;
    N15: TMenuItem;
    AReconfReport: TAction;
    AMaterialsReport: TAction;
    N16: TMenuItem;
    ALoad: TAction;
    ASave: TAction;
    ABunkersReport: TAction;
    N17: TMenuItem;
    ToolButton10: TToolButton;
    AWorkGraphs: TAction;
    N18: TMenuItem;
    Areconflist: TAction;
    N19: TMenuItem;
    AOptimize: TAction;
    N20: TMenuItem;
    AOptParams: TAction;
    N21: TMenuItem;
    N22: TMenuItem;
    procedure AExitExecute(Sender: TObject);
    procedure AModelExecute(Sender: TObject);
    procedure ALinesReportExecute(Sender: TObject);
    procedure AModelReportExecute(Sender: TObject);
    procedure ASolveExecute(Sender: TObject);
    procedure ABunkersReportExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure ALoadExecute(Sender: TObject);
    procedure ASaveExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AMaterialsReportExecute(Sender: TObject);
    procedure AAboutExecute(Sender: TObject);
    procedure AWorkGraphsExecute(Sender: TObject);
    procedure AreconflistExecute(Sender: TObject);
    procedure AHelpExecute(Sender: TObject);
    procedure AOptimizeExecute(Sender: TObject);
    procedure AOptParamsExecute(Sender: TObject);
  private
    procedure SHint(Sender : TObject);
  public
    procedure RefreshCapt;
  end;


var
  Main: TMain;

implementation

uses UModel, UResultReport, UModelReport, UBunkersReport, UMaterialReport,
  UAbout, UWorkGraphs, UReconfList, UOpt, UOptParams;

{$R *.DFM}

procedure TMain.AExitExecute(Sender: TObject);
begin
   close;
end;

procedure TMain.AModelExecute(Sender: TObject);
begin
   FModel.ShowModal;
end;

procedure TMain.ALinesReportExecute(Sender: TObject);
begin
   if assigned(ResultReport) then ResultReport.free;
   ResultReport := TResultReport.Create(nil);
   ResultReport.Model := FModel.ModelCopy;
   ResultReport.loadFromModel;
   ResultReport.Update;
   ResultReport.Preview;
end;

procedure TMain.AModelReportExecute(Sender: TObject);
begin
  FModel.APrintExecute(nil);
end;

procedure TMain.ASolveExecute(Sender: TObject);
var
  p : TProgressBar;
begin
  try
    Screen.Cursor := crHourGlass;
    p := TProgressBar.Create(nil);
    p.Smooth := true;
    p.Parent := StatusBar1;
    p.top := 4;
    p.left := 254;
    p.height := 15;
    p.visible := true;
    StatusBar1.Update;
    with FModel do
    begin
      ModelCopy.LoadFromModel(Model);
      ModelCopy.Solve(p);
    end;
  finally
    Screen.Cursor := crDefault;
    if assigned(p) then p.free;
  end;
end;

procedure TMain.ABunkersReportExecute(Sender: TObject);
begin
   if assigned(BunkersReport) then BunkersReport.free;
   BunkersReport := TBunkersReport.Create(nil);
   BunkersReport.Model := FModel.ModelCopy;
   BunkersReport.loadFromModel;
   BunkersReport.Update;
   BunkersReport.Preview;
end;

procedure TMain.FormActivate(Sender: TObject);
begin
//   ToolBar1.ButtonHeight := MenuBar1.Height;
end;

procedure TMain.FormCreate(Sender: TObject);
begin
    Application.OnHint := SHint;
end;

procedure TMain.SHint;
begin
   StatusBar1.Panels[0].Text := Application.Hint;
   FModel.Status.Panels[0].Text := Application.Hint;
end;

procedure TMain.FormPaint(Sender: TObject);
begin
   RefreshCapt;
end;

procedure TMain.RefreshCapt;
begin
   Caption := CAPT + ' - ' + FModel.ModelName;
end;

procedure TMain.ALoadExecute(Sender: TObject);
begin
    FModel.ALoadExecute(Sender);
    RefreshCapt;
end;

procedure TMain.ASaveExecute(Sender: TObject);
begin
    FModel.ASaveExecute(Sender);
    RefreshCapt;
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if FModel.Modified then
   if MessageDlg('Сохранить модель?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        ASaveExecute(self);
end;

procedure TMain.AMaterialsReportExecute(Sender: TObject);
begin
   if assigned(MaterialsReport) then MaterialsReport.free;
   MaterialsReport := TMaterialsReport.Create(nil);
   with MaterialsReport do
   begin
     Model := FModel.ModelCopy;
     LoadFromModel;
     Update;
     Preview;
   end;
end;

procedure TMain.AAboutExecute(Sender: TObject);
begin
   FAbout.ShowModal;
end;

procedure TMain.AWorkGraphsExecute(Sender: TObject);
begin
    FWorkGraphs.Model := FModel.ModelCopy;
    FWorkGraphs.ShowModal;
end;

procedure TMain.AreconflistExecute(Sender: TObject);
begin
   FReconfList.Model := FModel.Model;
   FReconflist.ShowModal;
end;

procedure TMain.AHelpExecute(Sender: TObject);
begin
   ShellExecute(Handle, PChar('open'), 'Руководство пользователя.doc', '', '', SW_SHOWMAXIMIZED);
end;

procedure TMain.AOptimizeExecute(Sender: TObject);
var
  m : TMemoryStream;
begin
        // Оптимизация графика перенастроек линий обработки зерна
        if (MessageDlg('После оптимизации график перенастроек будет изменен. Продолжить?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
        begin
          try
            Screen.Cursor := crHourGlass;
            FOpt.Show;
//            p := TProgressBar.Create(nil);
//            p.Smooth := true;
//            p.Parent := StatusBar1;
//            p.top := 4;
//            p.left := 254;
//            p.height := 15;
//            p.visible := true;
//            StatusBar1.Update;
            with FModel do
            begin
              ModelCopy.LoadFromModel(Model);
              ModelCopy.Optimize(FOpt);

              m := TMemoryStream.Create;
              ModelCopy.ReconfList.Save(m);
              Model.ReconfList.Clear;
              m.Seek(0, soFromBeginning);
              Model.ReconfList.Load(m);
            end;
          finally
            Screen.Cursor := crDefault;
            FOpt.Close;
            m.free;
//            if assigned(p) then p.free;
          end;
        end;
end;

procedure TMain.AOptParamsExecute(Sender: TObject);
begin
        FOptParams.M := FModel.Model;
        FOptParams.ShowModal;
end;

end.

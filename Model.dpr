{$H-}   // string = ShortString
program Model;

{%ToDo 'Model.todo'}

uses
  Forms,
  UMain in 'UMain.pas' {Main},
  tc in 'tc.pas',
  UModel in 'UModel.pas' {FModel},
  UEmbedForm in 'UEmbedForm.pas' {EmbedForm},
  UTime in 'UTime.pas' {FTime},
  UAllTime in 'UAllTime.pas' {FAllTime},
  UBunker in 'UBunker.pas' {FBunker},
  UMassa in 'UMassa.pas' {FMassa},
  ULine in 'ULine.pas' {FLine},
  UMaterial in 'UMaterial.pas' {FMaterial},
  UResultReport in 'UResultReport.pas' {ResultReport: TQuickRep},
  UModelReport in 'UModelReport.pas' {ModelReport: TQuickRep},
  UBunkersReport in 'UBunkersReport.pas' {BunkersReport: TQuickRep},
  UMaterialReport in 'UMaterialReport.pas' {MaterialsReport: TQuickRep},
  UAbout in 'UAbout.pas' {FAbout},
  UWorkGraphs in 'UWorkGraphs.pas' {FWorkGraphs},
  UGraph in 'UGraph.pas' {GraphReport: TQuickRep},
  USpeed in 'USpeed.pas' {FSpeed},
  UReconfList in 'UReconfList.pas' {FReconfList},
  URParams in 'URParams.pas' {FRParams},
  UDouble in 'UDouble.pas' {FDouble},
  UOpt in 'UOpt.pas' {FOpt},
  URDTSC in 'URDTSC.pas',
  UOptParams in 'UOptParams.pas' {FOptParams};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Моделирование';
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TFModel, FModel);
  Application.CreateForm(TMaterialsReport, MaterialsReport);
  Application.CreateForm(TFAbout, FAbout);
  Application.CreateForm(TFWorkGraphs, FWorkGraphs);
  Application.CreateForm(TGraphReport, GraphReport);
  Application.CreateForm(TFSpeed, FSpeed);
  Application.CreateForm(TFReconfList, FReconfList);
  Application.CreateForm(TFRParams, FRParams);
  Application.CreateForm(TFDouble, FDouble);
  Application.CreateForm(TFOpt, FOpt);
  Application.CreateForm(TFOptParams, FOptParams);
  Application.Run;
end.

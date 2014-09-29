unit UAllTime;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UEmbedForm, ExtCtrls, StdCtrls, UTime, tc;

type
  TFAllTime = class(TEmbedForm)
    Label1: TLabel;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure SetTime(value : time);
    function GetTime : time;
    procedure ActivateFocus;
    procedure Load(AModel : TModel);
    procedure Save(AModel : TModel);

    property aTime : time read GetTime write SetTime;
  end;

var
  FAllTime: TFAllTime;


implementation

var  FTime :  TFTime;

{$R *.DFM}

procedure TFAllTime.ActivateFocus;
begin
   FTime.MaskEdit1.SetFocus;
end;

procedure TFAllTime.FormCreate(Sender: TObject);
begin
  inherited;
  FTime := TFTime.CreateEmbedded(self, Panel1);
  FTime.Show;
end;

function TFAllTime.GetTime: time;
begin
   result := FTime.Number;
end;

procedure TFAllTime.Load;
begin
   aTime := AModel.AllTime;
end;

procedure TFAllTime.Save(AModel: TModel);
begin
   AModel.AllTime := aTime;
end;

procedure TFAllTime.SetTime(value: time);
begin
   FTime.Number := value;
end;

end.

unit UOptParams;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Spin, tc;

type
  TFOptParams = class(TForm)
    Button1: TButton;
    Button2: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    TrackBar1: TTrackBar;
    SpinEdit1: TSpinEdit;
    procedure TrackBar1Change(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
     M : TModel;

     procedure SetShowProgress(value : boolean);
     function GetShowProgress : boolean;
     property ShowProgress : boolean read GetShowProgress write SetShowProgress;

     procedure SetPointCount(value : integer);
     function GetPointCount : integer;
     property PointCount : integer read GetPointCount write SetPointCount;

     procedure Load;
     procedure Save;
  end;

var
  FOptParams: TFOptParams;

implementation

{$R *.DFM}

procedure TFOptParams.TrackBar1Change(Sender: TObject);
begin
        SpinEdit1.Value := TrackBar1.Position ;
end;

procedure TFOptParams.SpinEdit1Change(Sender: TObject);
begin
        TrackBar1.Position := SpinEdit1.Value;
end;

function TFOptParams.GetPointCount: integer;
begin
     result := TrackBar1.Position;
end;

function TFOptParams.GetShowProgress: boolean;
begin
   result := CheckBox1.Checked;
end;

procedure TFOptParams.SetPointCount(value: integer);
begin
    TrackBar1.Position := value;
end;

procedure TFOptParams.SetShowProgress(value: boolean);
begin
    CheckBox1.Checked := value;
end;

procedure TFOptParams.Load;
begin
    ShowProgress := m.FShowProgress;
    PointCount := m.point_count;
end;

procedure TFOptParams.Save;
begin
    m.point_count := PointCount;
    m.FShowProgress := ShowProgress;
end;

procedure TFOptParams.Button2Click(Sender: TObject);
begin
        close;
end;

procedure TFOptParams.Button1Click(Sender: TObject);
begin
        Save;
        close;
end;

procedure TFOptParams.FormActivate(Sender: TObject);
begin
        Load;
end;

end.

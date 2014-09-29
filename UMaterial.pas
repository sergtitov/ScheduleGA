unit UMaterial;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UEmbedForm, ExtCtrls, StdCtrls,
  tc;

type
  TFMaterial = class(TEmbedForm)
    Label1: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    Panel2: TPanel;
    Label4: TLabel;
    Panel4: TPanel;
    Label3: TLabel;
    Panel3: TPanel;
    Label6: TLabel;
    Panel5: TPanel;
    Label5: TLabel;
    Panel6: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
     procedure Load(Material : TMaterial);
     procedure Save(Material : TMaterial);

     procedure SetMx(value : massa);
     function GetMx : massa;

     procedure SetSigma(value : massa);
     function GetSigma : massa;

     procedure SetLamda(value : massa);
     function GetLamda : massa;

     procedure SetQueue(value : massa);
     function GetQueue : massa;

     procedure SetLimit(value : massa);
     function GetLimit : massa;

     procedure SetKoef(value : double);
     function GetKoef : double;

     property Lamda : massa read GetLamda write SetLamda;
     property mx : massa read GetMx write SetMx;
     property Sigma : massa read GetSigma write SetSigma;
     property Queue : massa read GetQueue write SetQueue;
     property Limit : massa read GetLimit write SetLimit;
     property Koef : double read GetKoef write SetKoef;     
  end;

var
  FMaterial: TFMaterial;

implementation

Uses UMassa, USpeed, UDouble;

var
   Fmx            : TFSpeed;
   FKoef          : TFDouble;
   FSigma         : TFMassa;
   FLamda         : TFSpeed;
   FQueue,
   FLimit         : TFMassa;

{$R *.DFM}

procedure TFMaterial.FormCreate(Sender: TObject);
begin
  inherited;
  Panel1.BorderStyle := bsNone;
  Panel2.BorderStyle := bsNone;
  Panel4.BorderStyle := bsNone;
  Panel3.BorderStyle := bsNone;
  Panel5.BorderStyle := bsNone;
  Panel6.BorderStyle := bsNone;

  Fmx := TFSpeed.CreateEmbedded(self, Panel1);
  Fsigma := TFMassa.CreateEmbedded(self, Panel2);
  FLamda := TFSpeed.CreateEmbedded(self, Panel4);
  FQueue := TFMassa.CreateEmbedded(self, Panel3);
  FLimit := TFMassa.CreateEmbedded(self, Panel5);
  FKoef := TFDouble.CreateEmbedded(self, Panel6);

  Fmx.Show;
  Fsigma.Show;
  FLamda.Show;
  FQueue.Show;
  FLimit.Show;
  FKoef.Show;
end;

function TFMaterial.GetLamda: massa;
begin
   result := FLamda.Number;
end;

function TFMaterial.GetMx: massa;
begin
   result := Fmx.Number;
end;

function TFMaterial.GetSigma: massa;
begin
   result := Fsigma.Number;
end;

function TFMaterial.GetLimit: massa;
begin
   result := FLimit.Number;
end;

function TFMaterial.GetQueue: massa;
begin
   result := FQueue.Number;
end;

function TFMaterial.GetKoef: double;
begin
   result := FKoef.Number;
end;


procedure TFMaterial.Load(Material: TMaterial);
begin
   mx    := Material.mx;
   sigma := Material.sigma;
   Lamda := Material.Lamda;
   Queue := Material.Queue;
   Limit := Material.Limit;
   Koef  := Material.Koef;
end;

procedure TFMaterial.Save(Material: TMaterial);
begin
   Material.mx    := mx;
   Material.sigma := sigma;
   Material.Lamda := Lamda;
   Material.Queue := Queue;
   Material.Limit := Limit;
   Material.Koef := Koef;
end;

procedure TFMaterial.SetLamda(value: massa);
begin
   FLamda.Number := value;
end;

procedure TFMaterial.SetMx(value: massa);
begin
   Fmx.Number := value;
end;

procedure TFMaterial.SetSigma(value: massa);
begin
   Fsigma.Number := value;
end;

procedure TFMaterial.SetLimit(value: massa);
begin
   FLimit.Number := value;
end;

procedure TFMaterial.SetQueue(value: massa);
begin
   FQueue.Number := value;
end;

procedure TFMaterial.SetKoef(value: double);
begin
   FKoef.Number := value;
end;

end.

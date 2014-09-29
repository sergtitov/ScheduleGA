unit UOpt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls;

type
  TFOpt = class(TForm)
    p_opt: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    LCount: TLabel;
    LBest: TLabel;
    Label3: TLabel;
    LAll: TLabel;
    Label4: TLabel;
    LTime: TLabel;
  private
    { Private declarations }
  public
      procedure SetCount(value : integer);
      property Count : integer Write SetCount;

      procedure SetBest(value : integer);
      property Best : integer Write SetBest;
  end;

var
  FOpt: TFOpt;

implementation

{$R *.DFM}

{ TFOpt }

procedure TFOpt.SetBest(value: integer);
begin
     LBest.Caption := IntToStr(value);
end;

procedure TFOpt.SetCount(value: integer);
begin
     LCount.Caption := IntToStr(value);
end;

end.

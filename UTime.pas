unit UTime;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UEmbedForm, StdCtrls, Mask,
  tc;

type
  TFTime = class(TEmbedForm)
    Label1: TLabel;
    Label3: TLabel;
    MaskEdit1: TEdit;
    procedure MaskEdit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MaskEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
     function GetNumber : time;
     procedure SetNumber(value : time);
     property Number : time read GetNumber write SetNumber;
  end;


implementation

{$R *.DFM}

procedure TFTime.MaskEdit1Change(Sender: TObject);
begin
  Label3.Caption := format('%.2f', [Number /  (30 * 3 * 8 * 3600 )]);
end;

function TFTime.GetNumber: time;
begin
  try
    result := StrToFloat(MaskEdit1.Text) * 8 * 3600;
  except
    result := 0;
    Number := 0;
  end;
end;

procedure TFTime.SetNumber(value: time);
begin
   if Value >= 0 then
      MaskEdit1.Text := FloatToStr(value / (8 * 3600));
end;

procedure TFTime.FormCreate(Sender: TObject);
begin
  inherited;
  Number := 8 * 3 * 30 * 3600;
end;

procedure TFTime.MaskEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not ((Key in ['0'..'9']) or (key = #8)) then key := #27;
end;

end.

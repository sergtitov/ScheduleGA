unit USpeed;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UEmbedForm, StdCtrls, tc;

type
  TFSpeed = class(TEmbedForm)
    Edit1: TEdit;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
     function GetNumber : massa;
     procedure SetNumber(value : massa);

     property Number : massa read GetNumber write SetNumber;

  end;

var
  FSpeed: TFSpeed;

implementation

{$R *.DFM}

procedure TFSpeed.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not(
          (Key in ['0'..'9']) or
          (key = #8) or
          (key = ',')
        ) then
   key := #27;
end;

procedure TFSpeed.FormCreate(Sender: TObject);
begin
  inherited;
  Number := 1;
end;


function TFSpeed.GetNumber: massa;
begin
   try
     result := StrToFloat(Edit1.Text) / 3.600;
   except
     Number := 0;
     result := 0;
   end;
end;

procedure TFSpeed.SetNumber(value: massa);
begin
   if Value >= 0 then
      Edit1.Text := FloatToStr(value * 3.600);
end;

end.

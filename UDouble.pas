unit UDouble;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UEmbedForm, StdCtrls, tc;

type
  TFDouble = class(TEmbedForm)
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
  FDouble: TFDouble;

implementation

{$R *.DFM}

procedure TFDouble.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not(
          (Key in ['0'..'9']) or
          (key = #8) or
          (key = ',')
        ) then
   key := #27;
end;

procedure TFDouble.FormCreate(Sender: TObject);
begin
  inherited;
  Number := 1;
end;


function TFDouble.GetNumber: massa;
begin
   try
     result := StrToFloat(Edit1.Text);
   except
     Number := 0;
     result := 0;
   end;
end;

procedure TFDouble.SetNumber(value: massa);
begin
    Edit1.Text := FloatToStr(value);
end;

end.

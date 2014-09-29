unit UMassa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UEmbedForm, StdCtrls,
  tc;

type
  TFMassa = class(TEmbedForm)
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
     function GetNumber : massa;
     procedure SetNumber(value : massa);

     property Number : massa read GetNumber write SetNumber;
  end;


implementation

{$R *.DFM}

{ TFMassa }

function TFMassa.GetNumber: massa;
begin
   try
     result := StrToFloat(Edit1.Text);
   except
     Number := 0;
     result := 0;
   end;
end;

procedure TFMassa.SetNumber(value: massa);
begin
   if Value >= 0 then
      Edit1.Text := FloatToStr(value);
end;

procedure TFMassa.FormCreate(Sender: TObject);
begin
  inherited;
  Number := 1000;
end;

procedure TFMassa.Button1Click(Sender: TObject);
begin
  Number := Number * 1000;
  Edit1.SetFocus;
end;

procedure TFMassa.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not(
          (Key in ['0'..'9']) or
          (key = #8) or
          (key = ',')
        ) then
   key := #27;
end;

procedure TFMassa.Edit1Change(Sender: TObject);
begin
  Label2.Caption := format('%.2f', [Number /  1000]);
end;

end.

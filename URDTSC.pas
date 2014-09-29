unit URDTSC;

interface


function RDTSC:comp;
function CompToStr(N : comp) : string;

implementation

Uses sysutils;

function RDTSC:comp;
var
  TimeStamp : record
    case byte of
      1 : (Whole : comp);
      2 : (Lo, Hi : LongInt);
  end;

begin
   asm
      db $0F; db $31;
   {$ifdef CPU386}
      mov [TimeStamp.Lo], eax
      mov [TimeStamp.Hi], edx
   {$else}
      db D32
      mov word ptr TimeStamp.Lo, ax
      db 32
      mov word ptr TimeStamp.Hi, dx
   {$endif}
   end;
   result := TimeStamp.Whole;
end;


function CompToStr(N : comp) : string;
begin
   result := format('%.0n', [N]);
end;

end.




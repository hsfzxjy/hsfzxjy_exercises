type
    rec = record
        a : array [1..2] of longint;
    end;

var
    a, b: rec;
begin
    fillchar(a, sizeof(a), 0);
    a.a[1] := 1;
    b := a;
    b.a[1] := 2;
    writeln(a.a[1]);
end.
const
    jindu = 1000000;
var
    a: array [1..10000] of longint;
    la: longint;

procedure mul(n: longint);
var
    i, x: longint;
begin
    x := 0;
    for i := 1 to la do 
    begin
        a[i] := x+a[i] * n;
        x := a[i] div jindu;
        a[i] := a[i] mod jindu;
    end;
    while x<>0 do 
    begin
        inc(la);
        a[la] := x mod jindu;
        x := x div jindu;
    end;
end;

var
    i, n, x, t, ans: longint;
    b: Boolean;

function stat(x: longint): Longint;
begin
    //writeln(x);
    stat := 0;
    while x<>0 do 
    begin
        stat := stat+x mod 10;
        x := x div 10;
    end;
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);
    
    read(n);
    la := 1;
    a[1] := 1;
    for i := 2 to n do mul(i);
    for i := 1 to la do ans := ans + stat(a[i]);

    if ans = 1 then
        b := False
    else if ans = 2 then 
        b := True
    else
    begin
        t := trunc(sqrt(ans));
        i := 2;
        b := True;
        while (I<=t) and (ans mod I<>0) do inc(i);
        if I<=T then b := False;
    end;
    write(ans);
    if b then writeln('T') else writeln('F');


    close(input); close(output);
end.
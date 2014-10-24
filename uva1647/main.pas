const
    JINDU = 100000;
    WEI = 5;
var
    n: Integer;

procedure PrintANumber(x: longint);
var
    t: longint;
begin
    if x = 0 then
        write('00000')
    else
    begin
        t := JINDU;
        while t > x * 10 do 
        begin
            write(0);
            t := t div 10;
        end;
        write(x);
    end;
end;

var
    ans: array [1..300] of longint;
    len, i: integer;

procedure calc2;
var
    i, x, t, mul: longint;
begin
    len := 1;
    ans[1] := 1;
    t := n-1;
    while t > 0 do
    begin
        if t < 6 then 
            mul := 1 << t
        else 
            mul := 64;
        x := 0;
        for i := 1 to len do
        begin
            ans[i] := ans[i] * mul + x;
            x := ans[i] div JINDU;
            ans[i] := ans[i] mod JINDU;
        end;
        if x > 0 then
        begin
            inc(len);
            ans[len] := x;
        end;
        dec(t, 6);
    end; 
end;

procedure div3;
var
    i, x, t: longint;
begin
    i := len;
    x := 0;
    while i > 0 do
    begin
        t := (x * JINDU + ans[i]);
        ans[i] := t div 3;
        x := t mod 3;
        dec(i);
    end;
    while ans[len] = 0 do dec(len);
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    while not eof do
    begin
        readln(n);
        if n=1 then
        begin
            writeln(0);
            continue;
        end;
        fillchar(ans, sizeof(ans), 0);
        calc2;
        if odd(n) then
            dec(ans[1])
        else
            inc(ans[1]);
        div3;
        write(ans[len]);
        for i := len-1 downto 1 do 
            PrintANumber(ans[i]);
        writeln;
    end;

    close(input); close(output);
end.
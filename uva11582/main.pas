var
    a,b: qword;
    _, n, i, k, cnt: longint;
    f: array [1..1000000] of longint;

function superMod(a, b: qword; m: longint): longint;
var
    x: qword;
begin
    if b = 0 then
        exit(1);
    x := superMod(a, b shr 1, m);
    superMod := x * x mod m;
    if odd(b) then
        superMod := superMod * a mod m;
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);
    readln(_);
    while _ > 0 do
    begin
        dec(_);
        readln(a, b, n);
        if a = 0 then
        begin
            writeln(0);
            continue;
        end;
        if n = 1 then
        begin
            writeln(0);
            continue;
        end;
        f[1] := 1;
        f[2] := 1;
        cnt := 2;
        while not ((f[cnt-1] = 1) and (f[cnt] = 0)) do
        begin
            inc(cnt);
            f[cnt] := (f[cnt-1] + f[cnt-2]) mod n;
        end;
        //while x > int64(1 <<60) do
        //    x := x - int64((cnt << 59));
        a := a mod qword(cnt);
        k := superMod(a, b, cnt);
        writeln(f[k]);
    end;
    close(output); close(input);
end.

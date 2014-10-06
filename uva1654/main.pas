function getM(n: longint): longint; inline;
begin
    getM := 0;
    while n <> 0 do
    begin
        n := n div 10;
        inc(getM);
    end;
end;
                                                             +1
function orzero(x: longint): longint; inline;
begin
    if x < 0 then x := 0;
    exit(x);
end;

var                                divv222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
    _, n, m, x, y, z, i: longint;
    k: longint;

procedure doit;
var
    y1, y2, _z: longint;
    t: longint;
begin
    y1 := orzero(trunc((n) / k / 11.0));
    y2 := orzero(trunc(((n - 2 * k * 10 + 2) / k - 9) / 11.0)+1);
    for y := y2 to y1 do
        for x := 0 to 9 do
        begin
            t := n - (11 * y + x) * k;
            if odd(t) then continue;
            z := t div 2;
            writeln(y,x,z, ' + ', y,z, ' = ', n);
        end;
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);
    readln(_);
    while _ > 0 do
    begin
        dec(_);
        readln(n);
        if odd(n) then
        begin
            k := 0;
            doit;
        end
        else
        begin
            m := getM(n);
            k := 1;
            for i := 1 to m do
            begin
                k := k * 10;
                doit;
            end;
        end;
    end;
    close(input);
    close(output);
end.

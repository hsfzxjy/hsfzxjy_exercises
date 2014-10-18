var
    n, _, i: longint;

function h: int64; inline;
var
    k, t: longint;
begin
    h := 0;
    t := trunc(sqrt(n));
    k := 1;
    while k <=t do
    begin
        h := h + n div k;
        inc(k);
    end;
    h := h * 2 - t * t;
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(_);
    while _ > 0 do
    begin
        dec(_);
        readln(n);
        if n <= 0 then
            writeln(0)
        else
            writeln(h);
    end;

    close(input);
    close(output);
end.
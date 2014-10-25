var
    n, maxcost, colorn: longint;
    count, minc, index, available: array [0..100] of int64;
    i, j, k : longint;
    color, cost: longint;
    ans: int64;
{$ inline on }
function min(x, y: longint): longint; inline;
begin
    if x<y then exit(x) else exit(y);
end;
begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(n, colorn, maxcost);
    for i := 1 to n do 
    begin
        readln(color, cost);
        inc(index[color]);

        for j := 0 to colorn-1 do 
            minc[j] := min(minc[j], cost);

        if minc[color] > maxcost then
            inc(count[color], available[color])
        else
        begin
            available[color] := index[color];
            if cost > maxcost then
                dec(available[color]);
            inc(count[color], index[color] - 1);
        end;
        minc[color] := cost;
    end;
    ans := 0;
    for i := 0 to colorn-1 do 
        ans := ans + count[i];
    writeln(ans);

    close(input); close(output);
end.
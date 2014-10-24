type
    Rec = packed record
        weight, max: longint;
    end;
var
    map: array [1..10000, 1..10000] of Rec;
    i, j, k: longint;
    n, m, q, z, x, y, t: integer;
function min(x,y:longint): longint;
begin
     if x<y then exit(x) else exit(y);
end;
begin
    assign(input, './main.in'); reset(input);
    assign(output, './main.out'); rewrite(output);
    read(n);
    read(m);
    for i := 1 to m do
    begin
        read(x, y, z);
        //map[x, y].weight := z;
        //map[y, x].weight := z;
        map[x, y].max := z;
        map[y, x].max := z;
    end;
    for k := 1 to n do
        for i := 1 to n do
            for j := 1 to n do
            begin
                t := min(map[i, k].max, map[j, k].max);
                if t > map[i, j].max then
                    map[i, j].max := t;
            end;
    readln(q);
    for i := 1 to q do
    begin
        readln(X, y);
        if map[x, y].max = 0 then
            writeln(-1)
        else
            writeln(map[x, y].max);
    end;
    close(input); close(output);
end.

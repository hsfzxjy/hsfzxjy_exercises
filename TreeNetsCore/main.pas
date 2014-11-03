var
    dis: array [1..300, 1..300] of longint;
    route: array [1..300] of longint;
    tot: longint;
    n, i, j, k, x, y, s, st, ed, maxd: longint;

function max(x, y: longint): longint;
begin
    if x>y then exit(x) else exit(y);
end;

function min(x, y: longint): longint;
begin
    if x<y then exit(x) else exit(y);
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    filldword(dis, sizeof(dis) div 4, maxlongint div 5);

    readln(n, s);
    while not eof do
    begin
        read(x, y, k);
        dis[x, y] := k;
        dis[y, x] := dis[x, y];
    end;

    maxd := 0;

    for i := 1 to n do
        dis[i, i] := 0;

    for k := 1 to n do
        for i := 1 to n do
            for j := 1 to n do
            begin
                dis[i][j] := min(dis[i][k]+dis[k][j], dis[i][j]);
                if (maxd<dis[i][j]) and (dis[i][j]<>maxlongint div 5) then
                begin
                    maxd := dis[i][j];
                    st := i;
                    ed := j;
                end;
            end;
    tot := 0;
    for i := 1 to n do
        if (maxd = dis[st, i]+dis[i, ed]) then
        begin
            inc(tot);
            route[tot] := i;
        end;

    maxd := maxlongint;

    for i := 1 to tot do
        for j := 1 to tot do
        begin
            if dis[route[i], route[j]]>s then continue;
            k := max(min(dis[st, route[i]], dis[st, route[j]]), min(dis[ed, route[i]], dis[ed, route[j]]));
            if k<maxd then
                maxd := k;
        end;
    writeln(maxd);

    close(input); close(output);
end.

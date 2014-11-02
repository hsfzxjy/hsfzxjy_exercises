const
    QN = 1000000;

var
    q: array [1..QN] of longint;
    inq: array [1..100000] of Boolean;
    head, buy, earn, cost: array [1..100000] of longint;
    n, i, x, y, d, h, t, m: longint;
    tot: longint;
    edges: array [1..1000000] of record
        y: longint;
        next: longint;
    end;

procedure addedge(x, y: longint);
begin
    inc(tot);
    edges[tot].next := head[x];
    edges[tot].y := y;
    head[x] := tot;
end;
{$R-}
begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    filldword(earn, 100000, -1);

    read(n, m);
    for i := 1 to n do
    begin
        read(cost[i]);
        buy[i] := cost[i];
    end;
    while not eof do
    begin
        read(x, y, d);
        addedge(x, y);
        if d = 2 then
        addedge(y, x);
    end;
    t := 0; h := 1; q[1] := 1; inq[1] := True; earn[1] := 0;
    while h <> t do
    begin
        t := (t+1) mod QN;
        d := q[t];
        inq[d] := False;

        i := head[d];
        while i<>0 do
        begin
            x := edges[i].y;
            if (buy[x]>buy[d]) or (earn[x]<earn[d]) then
            begin
                if (buy[x] > buy[d]) then
                    buy[x] := buy[d];
                if earn[x]<earn[d] then
                    earn[x] := earn[d];
                if cost[x] - buy[x] > earn[x] then
                    earn[x] := cost[x] - buy[x];
                if not inq[x] then
                begin
                    inq[x] := True;
                    h := (h+1) mod QN;
                    q[h] := x;
                end;
            end;
            i := edges[i].next;
        end;
    end;
    if earn[n]<=0 then
        writeln(-1)
    else
        writeln(earn[n]);

    close(input); close(output);
end.

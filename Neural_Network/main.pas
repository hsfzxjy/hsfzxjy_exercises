type
    TEdge = record
        from: integer;
        weight: longint;
        next: longint;
    end;
var
    edges: array [1..100000] of TEdge;
    head: array [1..100] of longint;
    C, U: array [1..100] of longint;
    visited: array [1..100] of Boolean;
    degree: array [1..100] of longint;
    ans: array [1..100, 1..2] of longint;
    tot: longint;
    ne, n, i, x, y, weight, p: longint;

procedure addedge(x, y, weight: longint);
begin
    inc(ne);
    edges[ne].next := head[y];
    edges[ne].weight := weight;
    edges[ne].from := x;
    head[y] := ne;
    inc(degree[x]);
end;

function solve(x: longint): longint;
var
    i, y: longint;
begin
    if not visited[x] and (C[x]<>0) then
        visited[x] := True;
    if visited[x] then
        exit(C[x]);

    visited[x] := True;
    dec(C[x], U[x]);
    i := head[x];
    while i<>0 do
    begin
        y := solve(edges[i].from);
        //if y<0 then y := 0;
        inc(C[x], y * edges[i].weight);
        i := edges[i].next;
    end;
    if C[x]<0 then C[x] := 0;
    solve := C[x];
end;

begin
    assign(input, 'main.in'); reseT(input);
    assign(output, 'main.out'); rewrite(output);

    read(n, p);
    for i := 1 to n do read(C[i], U[i]);
    for i := 1 to p do
    begin
        read(x, y, weight);
        addedge(x, y, weight);
    end;
    tot := 0;
    for i := 1 to n do
        if degree[i] = 0 then
        begin
            inc(tot);
            ans[tot][1] := i;
            ans[tot][2] := solve(i);
            if ans[tot][2] <= 0 then dec(tot);
        end;

    if tot = 0 then
        writeln('NULL')
    else
        for i :=1 to tot do
            writeln(ans[i][1], ' ', ans[i][2]);

    close(input); close(output);
end.

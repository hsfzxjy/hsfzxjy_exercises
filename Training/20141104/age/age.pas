type
    TEdge = record
        x, y : longint;
    end;

var
    en: array [1..3000] of longint;
    edges: array[1..3000, 1..3000] of TEdge;
    money: array[1..3000] of longint;
    n, m: longint;
    tot: longint;

function min(x, y: longint): longint;
begin
    if x>y then exit(y) else exit(x);
end;

procedure addedge(x, y: longint);
var
    E: ^TEdge;
begin
    inc(en[x]);
    E := @edges[x][en[x]];
    E^.x := x;
    E^.y := y;
end;

var
    sets: array [1..3000] of longint;

function find(x: longint): longint;
begin
    if sets[x]=x then exit(x);
    sets[x] := find(sets[x]);
    exit(sets[x]);
end;

procedure combine(x, y: longint);
var
    ty, tx: longint;
begin
    tx := find(x);
    ty := find(y);
    if tx<>ty then
        sets[tx] := ty;
end;

var
    dfn, low, stack, nm: array [1..3000] of longint;
    visited, instack, calc: array [1..3000] of Boolean;
    top, index, c: longint;

procedure dfs(x: longint);
var
    i: longint;
    y: longint;
    k: longint;
begin
    inc(index);
    low[x] := index;
    dfn[x] := index;
    visited[x] := True;

    stack[top] := x;
    inc(top);
    instack[x] := true;
    for i := 1 to en[x] do
    begin
        y := edges[x][i].y;
        if not visited[y] then
        begin
            dfs(Y);
            low[x] := min(low[x], low[y]);
        end
        else if instack[y] then
        begin
            low[x] := min(low[x], low[y]);
        end;
    end;
    if dfn[x] = low[x] then
    begin
        k := maxlongint;
        repeat
            dec(top);
            y := stack[top];
            instack[y] := false;
            combine(x, y);
            k := min(k, money[y]);
        until x = y;
        nm[find(x)] := k;
        calc[find(x)] := True;
        if k = maxlongint then inc(c) else tot := tot + k;
    end;
end;

procedure qltfl;
var
    i, j: longint;
    tx, ty: longint;
begin
    for i := 1 to n do sets[i] := i;
    top := 1;
    for i := 1 to n do if not visited[i] then
    dfs(i);

    for i := 1 to n do
        for j := 1 to en[i] do
        begin
            tx := find(edges[i][j].x);
            ty := find(edges[i][j].y);
            if tx = ty then continue;
            if calc[ty] then
            begin
                calc[ty] := False;
                if nm[ty] = maxlongint then
                    dec(c)
                else
                    tot := tot - nm[ty];
            end;
        end;
    if c = 0 then
    begin
        writeln('YES');
        writeln(tot);
    end
    else
    begin
        writeln('NO');
    end;
end;

var
    i: longint;
    x, y: longint;

begin
    assign(input, 'age.in'); reset(input);
    assign(output, 'age.out'); rewrite(output);

    read(n, m);
    filldword(money, sizeof(money) >> 2, maxlongint);
    for i := 1 to m do
    begin
         read(x);
         read(money[x]);
    end;
    read(m);
    for i := 1 to m do
    begin
        read(x, y);
        addedge(x, y);
    end;

    qltfl;

    close(input); close(output);
end.

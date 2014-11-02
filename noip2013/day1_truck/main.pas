type
    TEdge = record
        x, y: longint;
        weight: longint;
    end;

operator <(x, y: TEdge)res: Boolean;
begin
    res := (x.weight<y.weight);
end;

var
    edges: array [1..50000] of TEdge;
    n, m: longint;

procedure sort(l, r: longint);
var
    i, j: longint;
    m, t: TEdge;
begin
    i := l;
    j := r;
    m := edges[(i+j)>>1];
    repeat
        while m<edges[i] do inc(i);
        while edges[j]<m do dec(j);
        if i<=j then
        begin
            t := edges[i];
            edges[i] := edges[j];
            edges[j] := t;
            inc(i);
            dec(j);
        end;
    until i>j;
    if i<r then sort(i, r);
    if l<j then sort(l, j);
end;

var
    sets: array [1..10000] of longint;
    map: array [1..10000, 1..10000] of longint;

var
    head: array [1..10000] of longint;
    nedges: array [1..20000] of record
        weight : longint;
        y: longint;
        next: longint;
    end;
    tot: longint;

procedure addedge(x, y: longint; weight: longint);
begin
    inc(tot);
    nedges[tot].next := head[x];
    nedges[tot].weight := weight;
    nedges[tot].y := y;
    head[x] := tot;
    map[x, y] := weight;
end;

function find(x: longint): longint;
begin
    if x = sets[x] then
        exit(x);
    sets[x] := find(sets[x]);
    exit(sets[x]);
end;

function combine(x, y: longint): Boolean;
var
    tx, ty: longint;
begin
    tx := find(x);
    ty := find(y);
    if tx = ty then
        exit(false);
    sets[tx] := ty;
    exit(true);
end;

procedure kruscal;
var
    i: longint;
begin
    sort(1, m);
    for i := 1 to n do
        sets[i] := i;
    tot := 0;
    for i := 1 to m do
        if combine(edges[i].x, edges[i].y) then
        begin
            addedge(edges[i].x, edges[i].y, edges[i].weight);
            addedge(edges[i].y, edges[i].x, edges[i].weight);
        end;
end;

var
    depth: array [1..10000] of longint;
    father: array [1..10000, 0..16] of longint;
    dp: array [1..10000, 0..16] of longint;

function min(x, y: longint): longint;
begin
    if x<y then exit(x) else exit(Y);
end;

procedure dfs(x: longint);
var
    i, j: longint;
begin
    depth[x] := depth[father[x][0]]+1;
    j := 1;
    if map[x][father[x][0]]=0 then
        map[x][father[x][0]] := maxlongint;

    dp[x][0] := map[x][father[x][0]];
    while 1<<j<=depth[x]-1 do
    begin
        father[x][j] := father[father[x][j-1]][j-1];
        dp[x][j] := min(dp[x][j-1], dp[father[x][j-1]][j-1]);
        inc(j);
    end;

    i := head[x];
    while i<>0 do
    begin
        if nedges[i].y = father[x][0] then
        begin
            i := nedges[i].next;
            continue;
        end;
        father[nedges[i].y][0] := x;
        dfs(nedges[i].y);
        i := nedges[i].next;
    end;
end;

function lca(x, y: longint): longint;
var
    t, i, j: longint;
begin
    if depth[x]<depth[y] then
    begin
        t := x; x := y; y := t;
    end;

    t := depth[x] - depth[y];
    j := 0;
    while 1<<j<=t do
    begin
        if t and (1<<j) <> 0 then
            x := father[x][j];
        inc(j);
    end;
    if x = y then exit(x);
    for j := 16 downto 0 do
        if father[x][j] <> father[y][j] then
        begin
            x := father[x][j];
            y := father[y][j];
        end;

    exit(father[x][0]);
end;

function calc(x, y: longint): longint; // x is child of y
var
    t, j: longint;
begin
    t := depth[x] - depth[y];
    j := 0;
    calc := maxlongint;
    while x<>y do
    begin
        if t and (1<<j) <> 0 then
        begin
            calc := min(calc, dp[x][j]);
            x := father[x][j];
        end;
        inc(j);
    end;
end;

var
    i, t, x, y: longint;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(n, m);
    for i :=1 to m do
        read(edges[i].x, edges[i].y, edges[i].weight);

    kruscal;
    for i := 1 to n do
    begin
        if father[i][0]<>0 then continue;
        father[i][0] := i;
        dfs(i);
    end;
    read(m);
    for i := 1 to m do
    begin
        read(x, y);
        if find(x) <> find(y) then
            writeln(-1)
        else
        begin
            t := lca(x, y);
            writeln(min(calc(x, t), calc(y, t)));
        end;
    end;


    close(input); close(output);
end.

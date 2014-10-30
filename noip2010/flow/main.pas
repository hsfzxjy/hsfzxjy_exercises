//Accepted!!!!
type
    arr = array [1..2] of longint;
operator <(x, y: arr)res: boolean;
begin
    res := (x[1]<y[1]) or (x[1]=y[1]) and (x[2]<y[2]);
end;
const
    dx: array [1..4] of longint = (-1, 1, 0, 0);
    dy: array [1..4] of longint = (0, 0, 1, -1);
var
    n, m, i, j: longint;
    map: array [0..501, 0..501] of longint;
    color: array [0..501, 0..501] of boolean;
    range: array [0..501] of arr;
    cnt: longint;

procedure init;
begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);
    readln(n, m);
    for i := 1 to n do
        for j := 1 to m do
            read(map[i, j]);
end;

procedure dfs(x, y: longint);
var
    i: longint;
    tx, ty: longint;
begin
    if x = n then
        inc(cnt);

    for i := 1 to 4 do
    begin
        tx := x + dx[i];
        ty := y + dy[i];
        if (tx<1) or (ty<1) or (tx>n) or (ty>m) or color[tx, ty] or (map[tx, ty] >= map[x, y]) then continue;
        color[tx, ty] := true;
        dfs(tx, ty);
    end;
end;

procedure sort(l, r: longint);
var
    i, j: longint;
    m, t: arr;
begin
    i := l; j := r; m := range[(i+j)>>1];
    repeat
        while range[i]<m do inc(i);
        while m<range[j] do dec(j);
        if i<=j then
        begin
            t := range[i];
            range[i] := range[j];
            range[j] := t;
            inc(i);
            dec(j);
        end;
    until i>j;
    if i<r then sort(i, r);
    if l<j then sort(l, j);
end;

procedure solve;
var
    index: longint;
    _type: Longint;
    left: longint;

    procedure dfs2(x, y: longint);
    var
        i, tx, ty: Integer;
    begin
        color[x, y] := true;
        if x = 1 then
            range[y][_type] := index;
        for i := 1 to 4 do
        begin
            tx := x + dx[i];
            ty := y + dy[i];
            if (tx<1) or (ty<1) or (tx>n) or (ty>m) or color[tx, ty] or (map[tx, ty] <= map[x, y]) then continue;
            dfs2(tx, ty);
        end;
    end;
begin
    fillchar(color, sizeof(color), 0);
    _type := 1;
    for index := 1 to m do
        if not color[n, index] then dfs2(n, index);
    fillchar(color, sizeof(color), 0);
    _type := 2;
    for index := m downto 1 do
        if not color[n, index] then dfs2(n, index);
    //for i := 1 to m do
      //  writeln(range[i][1], ' ', range[i][2]);
    //sort(1, m);
    i := 1;
    cnt := 0;
    left := 1;

    while (i<=m) and (left<=m) do
    begin
        while (i<m) and (range[i+1][1]<=left) do inc(i);
        inc(cnt);
        left := range[i][2]+1;
    end;
    writeln(cnt);
end;

begin
    init;
    cnt := 0;
    for i := 1 to m do
        if not color[1, i] then
            dfs(1, i);
    if cnt < m then
    begin
        writeln(0);
        writeln(m - cnt);
        exit;
    end;
    writeln(1);
    solve;
    close(input); close(output);
end.

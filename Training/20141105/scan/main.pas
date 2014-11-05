const
    dx: array [1..6] of longint = (0, 0, 0, 0, 1, -1);
    dy: array [1..6] of longint = (0, 0, 1, -1, 0, 0);
    dz: array [1..6] of Longint = (1, -1, 0, 0, 0, 0);

var
    map: array [1..50, 1..50, 1..50] of longint;
    visited: array [1..50, 1..50, 1..50] of Boolean;
    l, w, h, m: Longint;

procedure init;
var
    i, j, k: Integer;
begin
    readln(l, w, h);
    readln(m);
    for i := 1 to l do
        for j := 1 to w do
            for k := 1 to h do
                read(map[i, j, k]);
end;

var
    q: array [1..125000] of record x, y, z: longint; end;
    head, tail: longint;

procedure dfs(x, y, z: longint);
var
    i, tx, ty, tz: longint;
begin
    visited[x, y, z] := True;

    q[1].x := x;
    q[1].y := y;
    q[1].z := z;
    head := 0;
    tail := 1;
    while head<>tail do 
    begin
        inc(head);
        x := q[head].x;
        y := q[head].y;
        z := q[head].z;
        for i := 1 to 6 do
        begin
            tx := x+dx[i];
            ty := y+dy[i];
            tz := z+dz[i];
            if (tx<=0) or (tx>l) or (ty<=0) or (ty>w) or (tz<=0) or (tz>h) or (abs(map[x, y, z]-map[tx, ty, tz])>m) then continue;
            if visited[tx,ty,tz] then continue;
            visited[tx, ty, tz] := True;
            inc(tail);
            with q[tail] do 
            begin
                x := tx;
                y := ty;
                z := tz;
            end;
        end;
    end;
end;

var
    i,j,k, tot: longint;

begin
    assign(input, 'scan11.in'); reset(input);
    assign(output, 'scan11.out'); rewrite(output);

    init;
    for i := 1 to l do
        for j := 1 to w do
            for k := 1 to h do
                if not visited[i, j, k] then
                begin
                    inc(tot);
                    dfs(i, j, k);
                end;
    writeln(tot);

    close(input); close(output);
end.

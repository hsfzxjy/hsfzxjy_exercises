//Accepted.
const
    dx: array [1..4] of integer = (1, 0, 0, -1);
    dy: array [1..4] of integer = (0, 1, -1, 0);
    dir: array [1..4] of char = ('e', 'n', 's', 'w');

var
    a: array [1..50, 1..2] of integer; //障碍物
    k, i, n, _, x, y: integer;
    ans: array [1..20] of char;
    tot: longint;
    vis: array [-220..220, -220..220] of boolean;

function judge(x1, y1, x2, y2: longint): Boolean;
var
    i: Integer;
begin
    judge := False;
    if x1 = x2 then
    begin
        for i := 1 to k do 
            if (a[i, 1] = x1) and ((a[i, 2] - y1)*(a[i, 2] - y2) <= 0) then exit;
    end
    else
        for i := 1 to k do
            if (a[i, 2] = y2) and ((a[i, 1] - x1)*(a[i, 1] - x2) <= 0) then exit; 
    judge := True;
end;

procedure print;
var
    i: Integer;
begin
    for i := 1 to n do write(ans[i]);
    writeln;
    inc(tot);
end;

procedure dfs(t, x, y, d, s: integer);
var
    i, sum: Integer;
    tx, ty: longint;
begin
    if t = n then 
    begin
        if (x = 0) and (y = 0) then print;
        exit;
    end;

    sum := s - t - 1;
    inc(t);

    for i := 1 to 4 do
    begin
        if (i = d) or (i + d = 5) then continue;
        tx := x + dx[i] * t;
        ty := y + dy[i] * t;
        if vis[tx, ty] then continue;
        if abs(tx) + abs(ty) > sum then continue;
        if not judge(x, y, tx, ty) then continue;
        ans[t] := dir[i];
        vis[tx, ty] := True;
        dfs(t, tx, ty, i, sum);
        vis[tx, ty] := False;
    end;
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(_);
    while _ > 0 do 
    begin
        dec(_);
        read(n, k);
        fillchar(vis, sizeof(vis), 0);
        for i := 1 to k do 
            read(a[i, 1], a[i, 2]);
        fillchar(ans, sizeof(ans), 0);
        tot := 0;
        dfs(0, 0, 0, -1, n * (n+1) div 2);
        writeln('Found ', tot, ' golygon(s).');
        writeln;
    end;

    close(input); close(output);
end.
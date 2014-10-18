var
    n, des, x, y, _: Integer;
    cnt: int64;
    ans: array [1..20] of integer;
    vis: array [1..20] of boolean;
    map: array [1..20, 1..20] of boolean;
    trunk: array [1..20] of boolean;

function max(x, y: integer): integer; inline;
begin
    if x > y then exit(x) else exit(y);
end;

procedure PreProcess(x: integer);
var
    i: integer;
begin
    trunk[x] := True;
    for i := 1 to n do
        if map[x, i] and not trunk[i] then
            PreProcess(i);
end;

procedure print(tot: integer);
var
    i: integer;
begin
    for i := 1 to tot-1 do 
        write(ans[i], ' ');
    writeln(ans[tot]);
    inc(cnt);
end;

procedure dfs(x, t: integer);
var
    i: integer;
begin
    if x = des then
    begin
        print(t);
        exit;
    end;

    for i := 1 to n do
    begin
        if vis[i] or not map[x, i] or not trunk[i] then continue;
        ans[t+1] := i;
        vis[i] := True;
        dfs(i, t+1);
        vis[i] := False;
    end;
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    _ := 0;

    while not eof do
    begin
        readln(des);
        inc(_);
        writeln('CASE ', _, ':');
        fillchar(map, sizeof(map), 0);
        fillchar(vis, sizeof(vis), 0);
        n := 0;
        readln(x, y);
        while (x<>0) and (y<>0) do
        begin
            map[x, y] := True;
            map[y, x] := True;
            n := max(x, n);
            n := max(y, n);
            readln(x, y);
        end;
        cnt := 0;
        vis[1] := True;
        ans[1] := 1;
        fillchar(trunk, sizeof(trunk), 0);
        PreProcess(des);
        dfs(1, 1);
        writeln('There are ', cnt, ' routes from the firestation to streetcorner ', des, '.');
    end;

    close(input);
    close(output);
end.
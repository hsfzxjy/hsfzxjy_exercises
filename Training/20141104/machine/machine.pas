var
    g: array [1..100, 1..100] of Boolean;
    used: array [1..100] of Boolean;
    link:array[1..100] of longint;
    x, y, m, n, k, t, i: longint;
    tot: Longint;

function path(i: longint): Boolean;
var
    j: longint;
begin
    if used[i] then exit(false);
    used[i] := True;
    for j := 1 to m do
        if g[i][j] then
            if (link[j]=0) or path(link[j]) then
            begin
                link[j] := i;
                exit(True);
            end;
    exit(false);
end;

begin
    assign(input, 'machine1.in'); reset(input);
    assign(output, 'machine.out'); rewrite(output);

    read(n, m, k);
    for i := 1 to k do
    begin
        read(t, x, y);
        if (x = 0) or (y = 0) then continue;
        g[x][y] := True;
    end;

    for i := 1 to n do
    begin
        if path(i) then
            fillchar(used, sizeof(used), 0);    
    end;

    for i := 1 to m do
        if link[i]<>0 then inc(tot);
    writeln(tot);

    close(input); close(output);
end.

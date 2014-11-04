var
    child: array [1..300, 0..300] of longint;
    cnt, n, cur, x, y, p, i: longint;
    inf: array [1..300] of longint;

procedure search(k: longint);
var
    i, y, j, tmp: longint;
begin
    if cur > cnt then exit;
    tmp := cur;
    y := 0;
    for i := 1 to n do
        if inf[i] = k then
            for j := 1 to child[i][0] do
            begin
                inc(y);
                inf[child[i][j]] := k+1;
            end;
    if y = 0 then
    begin
        if cnt > cur then cnt := cur;
        exit;
    end;
    dec(y);
    cur := cur + y;
    for i := 1 to n do
        if inf[i] = k+1 then
        begin
            inf[i] := 0;
            search(k+1);
            inf[i] := k+1;
        end;
    cur := tmp;
    for i := 1 to n do 
        if inf[i] = k+1 then
            inf[i] := 0;
end;

procedure swap(var x, y: longint);
var
    t: Longint;
begin
    t := x; x := y; y := t;
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    read(n, p);
    for i := 1 to p do
    begin
        read(x, y);
        if x>y then swap(x, y);
        inc(child[x][0]);
        child[x][child[x][0]] := y;
    end;

    inf[1] := 1;

    cnt := maxlongint shr 1;
    cur := 1;

    search(1);
    writeln(cnt);

    close(input); close(output);
end.

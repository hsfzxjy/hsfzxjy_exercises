const
    delta :array [1..4, 1..2] of integer = ((-1, 0), (1, 0), (0, 1), (0, -1));
var
    _: Integer;
    name: string;
    n, m, i, j, x: Integer;
    ans: longint;
    map: array [0..101, 0..101] of integer;
    f: array [1..100, 1..100] of longint;

function max(x, y: longint): longint; inline;
begin
    if x>y then exit(x) else exit(y);
end;

function can(x, y: integer): Boolean; inline;
var
    i: Integer;
    tx, ty: integer;
begin
    can := true;
    for i := 1 to 4 do
    begin
        tx := x + delta[i, 1];
        ty := y + delta[i, 2];
        can := can and (map[x, y] >= map[tx, ty]);
        if not can then break;
    end;
end;

procedure dp(x, y: integer; len: longint);
var
    i: Integer;
    tx, ty: integer;
begin
    inc(len);
    if f[x, y] > len then exit;
    f[x, y] := len;
    ans := max(ans, len);
    for i := 1 to 4 do
    begin
        tx := delta[i, 1] + x;
        ty := delta[i, 2] + y;
        if (tx = 0) or (tx > n) or (ty = 0) or (ty > m) then continue;
        if map[x, y] <= map[tx, ty] then continue;
        dp(tx, ty, len);
    end;
end;

procedure ReadAndProcessName;
var
    s: string;
    i: integer;
begin
    readln(s);
    i := 1;
    name := '';
    n := 0;
    m := 0;
    while s[i] <> ' ' do
    begin
        name := name + s[i];
        inc(i);
    end;
    inc(i);
    while s[i] <> ' ' do
    begin
        n := n * 10 + ord(s[i]) - ord('0');
        inc(i);
    end;
    inc(i);
    while i <= length(s) do
    begin
        m := m * 10 + ord(s[i]) - ord('0');
        inc(i);
    end;
end;

begin
    assign(input, 'main.in');reset(input);
    assign(output, 'main.out');rewrite(output);
    readln(_);
    while _>0 do
    begin
        dec(_);
        fillchar(map, sizeof(map), 0);
        ReadAndProcessName;

        for i := 1 to n do
            for j := 1 to m do
            begin
                read(x);
                map[i, j] := x+1;
            end;
        readln;

        fillchar(f, sizeof(f), 0);
        ans := 0;
        for i := 1 to n do
            for j := 1 to m do
                if can(i, j) then
                    dp(i, j, 0);
        writeln(name, ': ', ans);
    end;
    close(input);close(output);
end.

const
    maxn = 1299709;
    maxd = trunc(sqrt(maxn));
var
    map: array [1..1299709] of boolean; //False for prime
    i, j: longint;
    n: longint;
function solve: longint;
var
    prev, next: boolean;
    a, b: longint;
begin
    if not map[n] then exit(0);
    prev := false;
    next := false;
    a := n;
    b := n;
    while not (prev and next) do
    begin
        if not next then inc(a);
        if not prev then dec(b);
        prev := prev or not map[b];
        next := next or not map[a];
    end;
    exit(a - b);
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);
    fillchar(map, sizeof(map), 0);
    for i := 2 to maxd do
    begin
        if map[i] then continue;
        j := i * i;
        while j<=maxn do
        begin
            map[j] := true;
            j := j + i;
        end;
    end;
    readln(n);
    while n<>0 do
    begin
        writeln(solve);
        readln(n);
    end;
    close(input);
    close(output);
end.

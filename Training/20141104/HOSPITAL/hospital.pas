var
    f: array [0..100, 0..100] of longint;
    a: array [1..100] of longint;
    i, j, k, l, m, n: longint;
    tot, cur: longint;

function max(x, y: longint): longint;
begin
    if x>y then exit(x) else exit(y);
end;

function min(x, y: longint): longint;
begin
    if x>y then exit(y) else exit(x);
end;

begin
    assign(input, 'hospital.in'); reset(input);
    assign(output, 'hospital.out'); rewrite(output);

    filldword(f, sizeof(f) >> 2, maxlongint div 5);

    read(n);
    for i := 1 to n do
    begin
        read(a[i], j, k);
        f[i, i] := 0;
        f[i, k] := 1;
        f[i, j] := 1;
        f[k, i] := 1;
        f[j, i] := 1;
    end;

    for k := 1 to n do
        for j := 1 to n do
            for i := 1 to n do
                f[i, j] := min(f[i, j], f[i, k]+f[j, k]);

    tot := maxlongint;
    for i := 1 to n do
    begin
        cur := 0;
        for j := 1 to n do
            inc(cur, a[j] * f[i, j]);
        if cur<tot then tot := cur;
    end;
    writeln(tot);

    close(input); close(output);
end.

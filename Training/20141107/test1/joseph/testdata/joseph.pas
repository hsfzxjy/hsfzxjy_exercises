var
    m, i, j, l, k: longint;
    a: array [0..30] of longint;
    b: Boolean;

function solve(m: longint): Boolean;
var
    i: Integer;
begin
    fillchar(a, sizeof(a), 0);
    for i := 1 to k do
    begin
        a[i] := (m-1+a[i-1]) mod (k<<1-i+1);
        if a[i]<k then exit(false);
    end;
    exit(True);
end;

begin
    assign(input, 'joseph.in'); reset(input);
    assign(output, 'joseph.out'); rewrite(output);

    read(k);

    m := k+1;
    while not solve(m) do inc(m);

    writeln(m);

    close(input); close(output);
end.

var
    i, n, k, j: longint;
    a: array [1..100] of longint;
    b: array [1..200, 1..2] of longint;
    f: array [1..200, 1..200] of int64;
    ans: int64;

function max(x, y: int64): int64;
begin
    if x>y then exit(x) else exit(y);
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output,'main.out'); rewrite(output);

    read(n);
    for i := 1 to n do read(a[i]);
    for i := 1 to n-1 do
    begin
        b[i][1] := a[i];
        b[i+n][1] := a[i];
        b[i][2] := a[i+1];
        b[i+n][2] := a[i+1];
    end;
    b[n][1] := a[n];
    b[n][2] := a[1];
    b[2*n][1] := a[n];
    b[2*n][2] := a[1];

    for k := 2 to n do 
        for i := 1 to 2*n-k+1 do 
            for j := i+1 to i+k-1 do 
                f[i, i+k-1] := max(f[i, j-1] + f[j, i+k-1] + b[i][1] * b[j][1] * b[i+k-1][2],
                    f[i, i+k-1]);

    ans := 0;
    for i := 1 to n do 
        ans := max(ans, f[i][i+n-1]);
    writeln(ans);

    close(input); close(output);
end.
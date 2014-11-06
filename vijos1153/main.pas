var
    f: array [1..200,1..200] of int64;
    tot: int64;
    a: array [1..200] of longint;
    sum: array [0..200] of longint;

function calc(x: longint): longint;
begin
    calc := abs(tot-2*x);
end;

function solve(i, j: longint): int64;
var
    t: longint;
begin
    if j = 0 then exit(0);
    if i<j then exit(0);
    if i = j then exit(sum[i]);
    if f[i][j]>0 then exit(f[i][j]);
    f[i][j] := solve(i-1,j);
    t := solve(i,j-1)+a[i];
    if calc(f[i][j])>calc(t) then
        f[i][j] := t;
    exit(f[i][j]);
end;

var
    i, j, n, t: longint;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    read(n);
    for i := 1 to n do
    begin
        read(a[i]);
        sum[i] := sum[i-1]+a[i];
    end;
    tot := sum[n];
    t := calc(solve(n, n>>1));
    writeln((tot-t)>>1, ' ', (tot+t)>>1);

    close(input); close(output);
end.

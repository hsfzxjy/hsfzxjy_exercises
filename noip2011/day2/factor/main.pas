const
    modn = 10007;
var
    a, b, k, m, n: longint;
    map: array[0..1000,0..1000] of int64;
function power(a, x: longint): int64;
var
    t: longint;
begin
    if x = 1 then
        exit(a);
    if x = 0 then
        exit(1);
    t := power(a, x shr 1);
    power := t * t mod modn;
    if odd(x) then
        power := power * a mod modn;
end;
function C(n, k: longint): int64;
begin
    if map[n, k] > 0 then
        exit(map[n, k]);
    if (n <= k) or (k = 0) then
        C := 1
    else if k = 1 then
        C := n
    else
        C := (C(n-1, k)+C(n-1, k-1)) mod modn;
    map[n, k] := C;
    //writeln('C(', n, ',', k,')=', C);
end;

var
    t: longint;
    ans: int64;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(a, b, k, n, m);
    a := a mod modn;
    b := b mod modn;
    ans := power(a, n);
    ans := ans * power(b, m) mod modn;
    if n > m then n := m;
    ans := ans * C(k, n) mod modn;
    writeln(ans);

    close(input); close(output);
end.

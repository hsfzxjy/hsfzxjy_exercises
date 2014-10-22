//Accepted.
var
    n, m, k, x: longint;
    ans, i: longint;

function superM(y: longint): longint;
var
    x: longint;
begin
    if y = 1 then
        exit(10 mod n);
    x := superM(y shr 1);
    x := (x * x) mod n;
    if odd(y) then
        x := (x * 10) mod n;
    exit(x);
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(n, m, k, x);
    writeln((x mod n + (m mod n) * superM(k)) mod n);

    close(input); close(output);
end.

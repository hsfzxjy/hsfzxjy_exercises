var
    primes: array [0..5000000] of longint;
    a: array [1..5000000] of boolean;
    i, l, r: longint;
    ans, an: int64;

procedure initp;
var
    i, j: longint;
begin
    fillchar(a, sizeof(a), True);
    a[1] := False;
    for i := 2 to 5000000 do
    begin
        if a[i] then
        begin
            inc(primes[0]);
            primes[primes[0]] := i;
        end;
        for j := 1 to primes[0] do
        begin
            if primes[j] * i > 5000000 then break;
            a[primes[j] * i] := False;
            if i mod primes[j] = 0 then
                break;
        end;
    end;
end;

procedure find(n: int64; x: longint; y: int64);
var
    i: longint;
    t, k: int64;
    tt: Double;
    b: boolean;
begin
    t := n;
    tt := ln(r/n);
    if (n>=l) and (n<=r) then
        if (y>ans) or (y = ans) and (n<an) then
        begin
            ans := y;
            an := n;
        end;

    for i := x to primes[0] do
    begin
        n := t;
        k := 0;
        b := False;
        repeat
            n := n * primes[i];
            inc(k);
            if (n<=r) then
            begin
                b := True;
                find(n, i+1, y * (k+1));
            end;
        until n>r;
        if not b then break;
        if y < ans / (1<<k) then
           exit;
    end;
end;

begin
    assign(input, 'divisors.in'); reset(input);
    assign(output, 'divisors.out'); rewrite(output);

    initp;
    readln(l, r);
    write('Between ',l,' and ',r, ', ');
    find(1, 1, 1);
    writeln(an, ' has a maximum of ', ans, ' divisors.');

    close(input); close(output);
end.

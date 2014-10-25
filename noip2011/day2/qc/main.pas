var
    l,r: array [1..200000] of longint;
    w,v: array [1..200000] of longint;
    x, Y, S, ans: int64;
    min, max, i, m, n: longint;
    left, right: longint;
    mid: longint;
    a, b: array [0..200000] of int64;

function solve(x: longint): int64;
begin
    fillchar(a, sizeof(a), 0);
    fillchar(b, sizeof(b), 0);
    for i := 1 to n do 
    begin
        a[i] := a[i-1];
        b[i] := b[i-1];
        if w[i] >= x then
        begin 
            a[i] := a[i] + v[i];
            b[i] := b[i] + 1;
        end;
    end;
    solve := 0;
    for i := 1 to m do 
    begin 
        solve := solve + (a[r[i]]-a[l[i]-1]) * (b[r[i]]-b[l[i]-1]);
    end;
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(n, m, S);
    min := maxlongint;
    max := 0;
    for i := 1 to n Do
    begin
        read(w[i], v[i]);
        if min > w[i] then
            min := w[i];
        if max < w[i] then
            max := w[i];
    end;
    for i := 1 to m do read(l[i], r[i]);

    left := min-1;
    right := max+1;
    ans := 1 shl 50;
    while left < right do 
    begin
        mid := (left + right) shr 1;
        Y := solve(mid);
        x := abs(Y-S);
        if x < ans then ans := x;
        if x = 0 then break;
        if Y < S then
            right := mid
        else
            left := mid+1;
    end;
    if Y > 2*S then Y := 0;
    writeln(ans);

    close(input); close(output);
end.
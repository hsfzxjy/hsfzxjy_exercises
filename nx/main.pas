const
    n = 10;
var
    a, tmp: array [1..10] of longint;
    cnt: int64;
    i, j: longint;

procedure nx(l, r: longint);
var
    mid, i, j, k: longint;
begin
    if l = r then
    begin
        tmp[l] := a[l];
        exit;
    end;
    mid := (l + r) shr 1;
    nx(l, mid);
    nx(mid+1, r);
    i := l;
    j := mid+1;
    k := l;
    while k <= r do 
    begin
        if (j>r) or (i<=mid) and (a[i]<a[j]) then
        begin
            tmp[k] := a[i];
            inc(i);
        end
        else
        begin
            cnt := cnt + mid - i + 1;
            if (i<=mid) and (a[i] = a[j]) then
                dec(cnt);
            tmp[k] := a[j];
            inc(j);
        end;
        inc(k);
    end;
    for i := l to r do 
        a[i] := tmp[i];
end;

begin
    assign(output, 'main.out'); rewrite(output);

    randomize;
    for i := 1 to 9 do 
    begin
        a[i] := random(100);
        write(a[i], ' ');
    end;
    a[10] := a[4];
    writeln(a[10]);
    writeln('Solve 1: ');
    cnt := 0;
    for i := 1 to n-1 do 
        for j := i+1 to n do 
            if a[i] > a[j] then inc(cnt);

    writeln(cnt);
    cnt := 0;
    writeln('Solve 2: ');
    nx(1, 10);
    writeln(cnt);

    close(output);
end.
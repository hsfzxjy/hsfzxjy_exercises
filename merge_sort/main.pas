var
    a: array [1..10] of integer = (3, 4, 5, 6, 1, 4, 7, 8, 9, 10);
    b: array [1..10] of integer;

procedure merge(l1, r1, l2, r2: integer);
var
    i, j, k, l, m: Integer;
begin
    i := l1;
    j := l2;
    k := l1;
    while (i<=r1) and (j<=r2) do 
    begin
        if a[i] <= a[j] then
        begin
            b[k] := a[i];
            inc(i);
        end
        else
        begin
            b[k] := a[j];
            inc(j);
        end;
        inc(k);
    end;
    for l := i to r1 do
    begin
        b[k] := a[l];
        inc(k);
    end;
    for l := j to r2 do
    begin
        b[k] := a[l];
        inc(k);
    end;
    for i := l1 to r2 do
        a[i] := b[i];
end;

procedure sort(l, r: longint);
var
    mid: Integer;
begin
    if l = r then 
    begin
        b[l] := a[l];
        exit;
    end;
    mid := (l+r) >> 1;
    sort(l, mid);
    sort(mid+1, r);
    merge(l, mid, mid+1, r);
end;

var
    i: Integer;

begin
    sort(1, 10);
    for i := 1 to 10 do write(a[i], ' ');
end.
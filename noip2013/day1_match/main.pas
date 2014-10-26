//AC
const
    MODN = 99999997;
type
    rec = record value, index: longint; end;
    TArr = array [1..100000] of rec;
var
    n: longint;
    a, b, c, tmp: TArr;
    ok: Boolean;
    l, r, i, j: longint;
    cnt: int64;

procedure sort(var arr: TArr; l, r: longint);
var
    i, j: longint;
    m, t: rec;
begin
    i := l;
    j := r;
    m := arr[(i+j) shr 1];
    repeat
        while arr[i].value < m.value do inc(i);
        while arr[j].value > m.value do dec(j);
        if i <= j then
        begin
            t := arr[i];
            arr[i] := arr[j];
            arr[j] := t;
            inc(i);
            dec(j);
        end;
    until i >j;
    if i < r then sort(arr, i, r);
    if l < j then sort(arr, l, j);
end;



procedure nx(l, r: longint);
var
    mid, i, j, k: longint;
begin
    if l = r then
    begin
        tmp[l] := c[l];
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
        if (j>r) or (i<=mid) and (c[i].index<=c[j].index) then
        begin
            tmp[k] := c[i];
            inc(i);
        end
        else
        begin
            cnt := cnt + mid - i + 1;
            cnt := cnt mod MODN;
            tmp[k] := c[j];
            inc(j);
        end;
        inc(k);
    end;
    for i := l to r do 
        c[i] := tmp[i];
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(n);
    for i := 1 to n do
    begin
        read(a[i].value);
        a[i].index := i;
    end;
    for i := 1 to n do
    begin
        read(b[i].value);
        b[i].index := i;
    end;
    sort(a, 1, n);
    sort(b, 1, n);

    for i := 1 to n do
        c[a[i].index] := b[i];

    cnt := 0;
    nx(1, n);
    writeln(cnt);

    close(input); close(output);
end.

//TLE Score: 70 
const
    MODN = 99999997;
type
    rec = record value, index: longint; end;
    TArr = array [1..100000] of rec;
var
    n: longint;
    a, b, c: TArr;
    ok: Boolean;
    l, r, i, cnt, j: longint;

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

    for i := 1 to n-1 do
        for j := i + 1 to n do
            if c[i].index > c[j].index then cnt := (cnt+1) mod MODN;
    writeln(abs(cnt));
    close(input); close(output);
end.

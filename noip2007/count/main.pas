var
    a: array [1..200001] of longint;

procedure sort(l, r: longint);
var
    i, j, m, t: longint;
begin
    i := l;
    j := r;
    m := a[(i+j)>>1];
    repeat
        while a[i]<m do inc(i);
        while a[j]>m do dec(j);
        if i<=j then
        begin
            t := a[i];
            a[i] := a[j];
            a[j] := t;
            inc(i);
            dec(j);
        end;
    until i>j;
    if i<r then sort(i, r);
    if l<j then sort(l, j);
end;

var
    i, n: longint;
    cnt: longint;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(n);
    for i := 1 to n do 
        readln(a[i]);
    sort(1, n);

    i := 1;
    while i<=n do 
    begin
        cnt := 1;
        while (i<=n) and (a[i]=a[i+1]) do 
        begin
            inc(i);
            inc(cnt);
        end;
        writeln(a[i], ' ', cnt);
        inc(i);
    end;

    close(input); close(output);
end.
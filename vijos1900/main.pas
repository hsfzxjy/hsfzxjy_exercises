var
    a, b, t: array [1..100000] of word;
    cnt: longint;
procedure nx(l, r: longint);
var
    i, j, mid, k: longint;
begin
    if l = r then
    begin
        t[l] := b[l];
        exit;
    end;
    mid := (l+r)>>1;
    nx(l, mid);
    nx(mid+1,r);
    k:=l;
    i:=l;
    j:=mid+1;
    while k<=r do
    begin
        if (j>r) or (i<=mid) and (b[i]<=b[j]) then
        begin
            t[k]:=b[i];
            inc(i);
        end
        else
        begin
            cnt:=cnt+mid-i+1;
            t[k]:=b[j];
            inc(j);
        end;
        inc(k);
    end;
    for i := l to r do b[i]:=t[i];
end;
var
    n,i,j,__,_:longint;
    s: string;
    zero: longint;
    min: longint;
begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(__);
    for _:=1 to __ do
    begin
        write('Case #',_,': ');
        readln(s);
        n:=length(s);
        zero := 0;
        for i := 1 to n do
        begin
            case s[i] of
            'B':a[i]:=1;
            'R':a[i]:=0;
            end;
            b[i]:=a[i];
            if a[i] = 0 then inc(zero);
        end;
        cnt:=0;
        nx(1,n);
        min := cnt;
        for i := 2 to n do
        begin
            if a[i]=1 then
                dec(cnt, zero)
            else
                inc(cnt, n-zero-1);
            if cnt < min then min := cnt;
        end;
        writeln(min-zero+1);
    end;

    close(input); close(output);
end.

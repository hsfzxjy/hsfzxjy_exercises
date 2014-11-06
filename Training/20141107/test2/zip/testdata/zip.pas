var
    a,b,c: array [1..10000] of char;
    vs: array [1..10000] of boolean;
    p,n: longint;

procedure sort(l, r: longint);
var
    i, j: longint;
    m, t: char;
begin
    i := l;j:=r;m:=b[(i+j)>>1];
    repeat
        while b[i]<m do inc(i);
        while b[j]>m do dec(j);
        if i<=j then
        begin
            t:=b[i]; b[i]:= b[j];b[j]:=t;
            inc(i);dec(j);
        end;
    until i>j;
    if i<r then sort(i,r);
    if l<j then sort(l,j);
end;

var
    i,k,j: Integer;
    ch: char;

begin
    assign(input, 'zip.in'); reset(input);
    assign(output, 'zip.out'); rewrite(output);
    readln(n);
    for i := 1 to n do begin read(a[i]); b[i] := a[i]; end;
    read(p);
    sort(1,n);
    c[1]:=a[p];
    vs[p] := true;

    for i := 2 to n+1 do
    begin
        //writeln(p);
        //for j := 1 to n do write(vs[i]);
        c[i] := b[p];
        if i>n then break;
        ch := b[p];
        k := n;
        while (k>=1) do
        begin
            if (ch<>a[k]) then begin dec(k); continue; end;
            if not vs[k] then
                break;
            dec(k);
        end;
        //c[i] := a[k];
        vs[k] := true;
        p := k;
    end;
    for i := 1 to n do write(c[i]);
    writeln;

    close(input);close(output);
end.

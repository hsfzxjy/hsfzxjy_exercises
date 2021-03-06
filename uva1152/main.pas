type
    arr = array [1..4000] of integer;
var
    a,b,c,d: arr;
    i,j,k,n:integer;
    tot: int64;
procedure sort(l,r:integer;var a: arr);
var
    i,j,t,m:longint;
begin
    i := l;
    j := r;
    m := a[(l+r) shr 1];
    repeat
        while a[i]<m do inc(i);
        while a[j]>m do dec(j);
        if i<=j then
        begin
            t := a[i];
            a[i] := a[j];
            a[j] := t;
            inc(i); dec(j);
        end;
    until i>j;
    if i<r then sort(i,r,a);
    if l<j then sort(l,j,a);
end;
function find(x:integer;a:arr;l,r:longint): boolean; overload;
var
    m,ma: integer;
begin
    if l>r then exit(false);
    m := (l+r) shr 1;
    ma := a[m];
    if x = ma then
        exit(true);
    if x<ma then
        exit(find(x,a,l,m))
    else
        exit(find(x,a,m+1,r));
end;
function find(x:integer; a: arr): boolean; overload;
begin
    exit(find(x,a,1,n));
end;
begin
    assign(input, 'main.in');reset(input);
    assign(output,'main.out');rewrite(output);
    readln(n);
    for i := 1 to n do
        read(a[i],b[i],c[i],d[i]);
    sort(1,n,a);
    sort(1,n,b);
    sort(1,n,c);
    sort(1,n,d);
    tot := 0;
    for i := 1 to n do
        for j := 1 to n do
            for k := 1 to n do
              if find(-a[i]-b[j]-c[k], d) then inc(tot);
    writeln(tot);
    close(input);close(output);
end.

const
    zero = 1e-8;
var
    a: array [1..700, 1..2] of longint;
    ag: array [1..701] of double;
    i, n: longint;

function angle(p, p1: longint): double;
begin
    if a[p][1] = a[p1][1] then
        exit(maxlongint)
    else
        exit((a[p][2]-a[p1][2])/(a[p][1]-a[p1][1]));
end;

procedure sort(l, r: longint);
var
    m, t: Double;
    i, j: longint;
begin
    i := l;
    j := r;
    m := ag[(i+j)>>1];
    repeat
        while ag[i]<m do inc(i);
        while ag[j]>m do dec(j);
        if i<=j then
        begin
            t := ag[i];
            ag[i] :=ag[j];
            ag[j] := t;
            inc(i);
            dec(j);
        end;
    until i>j;
    if i<r then sort(i,r);
    if l<j then sort(l,j);
end;

var
    ans, j, k: longint;

begin
    assign(input, 'bomb.in'); reset(input);
    assign(output, 'bomb.out'); rewrite(output);

    readln(n);
    for i := 1 to n do
    begin
        read(a[i][1], a[i][2]);
    end;

    for i := 1 to n do
    begin
        for j := 1 to n do
            ag[j] := angle(i, j);
        sort(1, n);
        k := 1; j := 1;
        while (j<=n) do
        begin
            while (abs(ag[j]-ag[j+1])<=zero) and (j<=n) do begin inc(j); inc(k); end;
            if ans<k then ans:=k;
            inc(j);
        end;
    end;
    writeln(ans+1);

    close(input); close(output);
end.

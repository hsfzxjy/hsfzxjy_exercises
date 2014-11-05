var
    st, ed, m: longint;
    down, up: longint;
    a: array [0..10000000] of longint;
    visited: array [0..10000000] of boolean;
    ans: array [0..1000000] of longint;
    tot: longint;

procedure process(k: longint);
var
    i, j, n, y: Integer;
    x: longint;
begin
    fillchar(visited, sizeof(visited),0);
    for i := 0 to k-1 do
        for j := 0 to k-1 do
            if i<>j then
            begin
                x := 0; n := 0;
                while x<=up/k do
                begin
                    x := x*k;
                    if odd(n) then inc(x, i) else inc(x, j);
                    //writeln(x);
                    if not visited[x] and (x>=down) and (x<=up) then
                    begin
                        inc(a[x]);
                        visited[x] := True;
                        if (m = a[x]) then
                        begin
                            inc(tot);
                            ans[tot] := x;
                        end;
                    end;
                    inc(n);
                end;
            end;
end;

var
    i: longint;

procedure sort(l,r: longint);
var
    i, j, m, t: longint;
begin
    i := l; j := r; m := ans[(i+j)>>1];
    repeat
        while ans[i]<m do inc(i);
        while ans[j]>m do dec(j);
        if i<=j then
        begin
            t := ans[i];
            ans[i] := ans[j];
            ans[j] := t;
            inc(i); dec(j);
        end;
    until i>j;
    if i<r then sort(i,r);
    if l<j then sort(l,j);
end;

begin
    assign(input, 'num.in'); reseT(input);
    assign(output, 'num.out'); rewrite(output);

    read(st, ed, down, up, m);
    for i := st to ed do process(i);
    sort(1, tot);
    for i := 1 to tot do
        if a[ans[i]] = m then
            writeln(ans[i]);

    close(input); close(output);
end.

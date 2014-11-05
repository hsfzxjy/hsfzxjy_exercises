var 
    n, m, i: longint;
    a: array [1..100] of longint;
    ans: longint;

procedure find(x: longint;y: longint);
var
    i: longint;
begin
    if y>=m then
    begin
        if y = m then inc(ans);
        exit;
    end;
    for i := x to n do 
        find(i+1, y+a[i]);
end;

begin
    assign(input, 'compages.in'); reset(input);
    assign(output, 'compages.out'); rewrite(output);

    read(n,m);
    for i := 1 to n do read(a[i]);
    find(1,0);
    writeln(ans);

    close(input); close(output);
end.
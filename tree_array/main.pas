var
    n, i: longint;
    a, c: array [1..10000] of longint;

function lowbit(x: longint): longint;
begin
    lowbit := x and (-x);
end;

procedure add(index, x: longint);
begin
    inc(a[index], x);
    while index<=n do 
    begin
        inc(c[index], x);
        inc(index, lowbit(index));
    end;
end;

function sum(index: longint): longint;
begin
    sum := 0;
    while index>0 do
    begin
        inc(sum, c[index]);
        dec(index, lowbit(index));
    end;
end;

var
    s: longint;
    op: longint;
    x,y: longint;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(n);
    for i := 1 to n do
    begin
        read(a[i]);
        add(i, a[i]);
    end;

    while not eof do
    begin
        read(op);
        if op = 1 then //添加操作
        begin
           read(x, y);
           Add(x, y); 
        end
        else           //求和操作
        begin
            read(s);
            writeln(sum(s));
        end;
    end;

    close(input); close(output);
end.
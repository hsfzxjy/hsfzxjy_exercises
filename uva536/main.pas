var
    pre, mid, s: string;
    tree: array [1..50] of record
        l, r: integer;
        ch: char;
    end;
    cur: integer;
function init: integer;
var
    m: integer;
begin
    readln(s);
    m := length(s) >> 1 + 1;
    pre := Copy(s, 1, m-1);
    mid := Copy(s, m+1, length(s));
    init := m-1;
end;
function build(l1, l2, r2: integer): integer;
var
    m,len: integer;
    t: integer;
begin
    if l2 > r2 then exit(0);
    inc(cur);
    t := cur;
    build := t;
    tree[t].ch := pre[l1];
    if r2-l2 = 0 then
        exit;
    m := pos(pre[l1], mid);
    len := m - l2;
    tree[t].l := build(l1+1, l2, m-1);
    tree[t].r := build(l1+len+1, m+1, r2);
end;
procedure print(x: integer);
begin
    if x = 0 then exit;
    print(tree[x].l);
    print(tree[x].r);
    write(tree[x].ch);
end;
begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);
    while not eof do
    begin
        fillchar(tree, sizeof(tree), 0);
        cur := 0;
        build(1, 1, init);
        print(1);
        writeln;
    end;
    close(input);
    close(output);
end.

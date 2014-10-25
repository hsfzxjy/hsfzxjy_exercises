type
    TNode = record
        l, r: longint;
        li, ri: longint;
        value: longint;  //当下区间最小值
        delta: longint;  //待减的值
        lmin, rmin: longint;
        final: boolean;
    end;
var
    tree: array [1..4000000] of TNode;
    cnt: longint;
    data: array [1..1000000] of longint;
    ok: boolean;

{$inline on}
function min(x, y: longint): longint; inline;
begin
    if x < y then exit(x) else exit(y);
end;

function build(l, r: longint): longint;
var
    mid: longint;
    index: longint;
begin
    inc(cnt);
    index := cnt;
    build := index;
    tree[index].l := l;
    tree[index].r := r;
    tree[index].delta := 0;
    if l = r then
    begin
        tree[index].value := data[l];
        tree[index].final := true;
        exit;
    end;
    mid := (l + r) shr 1;
    tree[index].li := build(l, mid);
    tree[index].lmin := tree[tree[index].li].value;
    tree[index].ri := build(mid+1, r);
    tree[index].rmin := tree[tree[index].ri].value;
    tree[index].value := min(tree[index].rmin, tree[index].lmin);
end;

function build_min(index: longint): longint;
begin
    if tree[index].final then
        exit(tree[index].value);
    tree[index].lmin := build_min(tree[index].li);
    tree[index].rmin := build_min(tree[index].ri);
    tree[index].value := min(tree[index].lmin, tree[index].rmin);
    exit(tree[index].value);
end;

function reduce(index, l, r, d: longint): longint;
var
    mid: longint;
    dd: longint;
begin
    if (l = tree[index].l) and (r = tree[index].r) then
    begin
        if tree[index].delta + d > tree[index].value then
        begin
            ok := false;
            exit;
        end;
        if tree[index].final then
        begin
            dec(tree[index].value, d);
            exit(tree[index].value);
        end
        else
        begin
            inc(tree[index].delta, d);
            exit(tree[index].value - tree[index].delta);
        end;
    end;

    dd := d + tree[index].delta;

    mid := (tree[index].l + tree[index].r) shr 1;
    if mid >= r then
    begin
        tree[index].lmin := reduce(tree[index].li, l, r, dd);
        if not ok then exit;
        tree[index].rmin := reduce(tree[index].ri, mid+1, tree[index].r, tree[index].delta);
        tree[index].value := min(tree[index].lmin, tree[index].rmin);
        exit(tree[index].value);
    end
    else if mid < l then
    begin
        tree[index].rmin := reduce(tree[index].ri, l, r, dd);
        if not ok then exit;
        tree[index].lmin := reduce(tree[index].li, tree[index].l, mid, tree[index].delta);
        tree[index].value := min(tree[index].lmin, tree[index].rmin);
        exit(tree[index].value);
    end
    else
    begin
        tree[index].lmin := reduce(tree[index].li, l, mid, d);
        if not ok then exit;
        tree[index].rmin := reduce(tree[index].ri, mid+1, r, d);
        if not ok then exit;
        tree[index].value := min(tree[index].lmin, tree[index].rmin);
        exit(tree[index].value);
    end;
    tree[index].delta := 0;
end;

var
    i, n, m: longint;
    s, t, d: longint;
    ans: longint;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(n, m);
    for i := 1 to n do
    begin
        read(data[i]);
    end;
    readln;
    build(1, n);
    //build_min(1);
    ans := 0;
    ok := true;
    for i := 1 to m do
    begin
        readln(d, s, t);
        reduce(1, s, t, d);
        if not ok then
        begin
            ans := i;
            break;
        end;
    end;

    if ans > 0 then
    begin
        writeln(-1);
        writeln(ans);
    end
    else
        writeln(0);

    close(input); close(output);
end.

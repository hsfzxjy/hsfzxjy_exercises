type
    TEdge = record 
        start, terminal: longint;
        weight: longint;
    end;

operator <(a, b: TEdge)res: boolean;
begin
    res := a.weight < b.weight;
end;

var 
    edges: array [1..100000] of TEdge;
    sets: array [1..40000] of longint;
    n, i, j, k, m, x, y, ans: longint;
    Edge: TEdge;

function find(x: longint): longint;
begin
    if x = sets[x] then
        exit(x);
    sets[x] := find(sets[x]);
    exit(sets[x]);
end;

procedure qsort(l, r: longint);
var
    i, j: Longint;
    m, t: TEdge;
begin
    i := l;
    j := r;
    m := edges[(l+r)>>1];
    repeat
        while m<edges[i] do inc(i);
        while edges[j]<m do dec(j);
        if i<=j then
        begin
            t := edges[i];
            edges[i] := edges[j];
            edges[j] := t;
            inc(i);
            dec(j);
        end;
    until i>j;
    if i<r then qsort(i, r);
    if l<j then qsort(l,j);
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);
    readln(n, m);
    for i := 1 to m do 
    begin
        read(edge.start, edge.terminal, edge.weight);
        edges[i] := edge;
    end;
    for i := 1 to 2*n do 
        sets[i] := i;
    qsort(1, m);
    ans := 0;
    for i := 1 to m do 
    begin
        x := find(edges[i].start);
        y := find(edges[i].terminal);
        if x = y then
        begin
            ans := edges[i].weight;
            break;
        end;
        sets[y] := find(edges[i].start+n);
        sets[x] := find(edges[i].terminal+n);
    end;
    writeln(ans);

    close(output); close(input);
end.
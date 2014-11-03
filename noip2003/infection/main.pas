type
    TEdge = record
        y : longint;
        next: longint;
    end;
var
    head, chi: array [1..300] of longint;
    edges: array [1..300] of TEdge;
    cnt: longint;
    i, n, p, j, x, y, k, l: longint;
    q: array [1..300] of longint;
    h, t: longint;

procedure addedge(x, y: longint);
begin
    edges[i].next := head[x];
    edges[i].y := y;
    head[x] := i;
end;

function dfs(x: longint): longint;
var
  k: longint;
begin
  k := head[x];
  dfs := 0;
  while k<>0 do
  begin
    dfs := dfs + dfs(edges[k].y)+1;
    k := edges[k].next;
  end;
  chi[x] := dfs;
end;

label ttt;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    read(n, p);
    for i := 1 to p do
    begin
        read(x, y);
        addedge(x, y);
    end;
    dfs(1);

    h := 1; t:= 1; q[t] := 1;
    while h<=t do
    begin
        //inc(h);
        k := 0;
        for i := h to t do
            if k<chi[q[h]] then
            begin
                k := chi[q[h]];
                j := q[h];
            end;
        x := t;
        while h<=x do
        begin
            l := -1;
            if q[h] = j then
            begin
                k := head[q[h]];
                y := 0;
                while k<>0 do
                begin
                    if chi[edges[k].y]>y then
                    begin
                        y := chi[edges[i].y];
                        l := edges[i].y;
                    end;
                    k := edges[k].next;
                end;
            end;
            k := head[q[h]];
            while k<>0 do
            begin
                if l = edges[k].y then goto ttt;
                inc(t);
                q[t] := edges[k].y;
                inc(cnt);
ttt:                k := edges[k].next;
            end;

            inc(h);
        end;
    end;

    writeln(cnt);

    close(input); close(output);
end.


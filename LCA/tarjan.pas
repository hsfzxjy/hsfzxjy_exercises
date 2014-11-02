var
    sets: array [1..100] of longint;
    visited: array [1..100] of Boolean;
    a: array [1..100, 1..100] of Boolean;
    questions: array [1..1000] of record
        x, y: longint;
        ans: longint;
    end;
    qn, n, i, m, x, y, root: longint;

function find(x: longint): longint;
begin
    if x = sets[x] then exit(x);
    sets[x] := find(sets[x]);
    exit(sets[x]);
end;

procedure dfs(x: longint);
var
    i: longint;
begin
    visited[x] := true;
    for i := 1 to qn do
    begin
        if visited[questions[i].x] and visited[questions[i].y] then
            if questions[i].x = x then
                questions[i].ans := find(questions[i].y)
            else if questions[i].y = x then
                questions[i].ans := find(questions[i].x);
    end;
    for i := 1 to n do
    begin
        if not a[i, x] or visited[i] then continue;
        dfs(i);
        sets[find(i)] := x;
    end;
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    read(n, m);
    for i := 1 to n do
        sets[i] := i;
    for i := 1 to m do
    begin
        read(x, y);
        a[x, y] := true;
        a[y, x] := True;
    end;
    read(root);
    qn := 0;
    while not eof do
    begin
        inc(qn);
        read(questions[qn].x, questions[qn].y);
    end;
    dfs(root);
    for i := 1 to qn do
        writeln(questions[i].ans);

    close(input); close(output);
end.

var
    words: array [1..16, 1..2] of char;
    len: array [1..16] of longint;
    edges: array [1..16, 0..16] of integer;
    n, i, j: longint;
    s: string;
    ans: longint;
    visited: array [1..16] of Boolean;

procedure addedge(x, y: integer);
begin
    inc(edges[x][0]);
    edges[x][edges[x][0]] := y;
end;

procedure dfs(x, y: longint);
var
    i: longint;
begin
    if visited[x] then exit;
    visited[x] := true;
    y := y + len[x];
    if y>ans then ans := y;
    for i := 1 to edges[x][0] do
        dfs(i, y);
    visited[x] := False;
end;

begin
    assign(input, 'words.in'); reset(input);
    assign(output, 'words.out'); rewrite(output);

    readln(n);
    for i := 1 to n do
    begin
        readln(s);
        len[i] := Length(s);
        words[i][1] := s[1];
        words[i][2] := s[len[i]];
    end;

    for i := 1 to n do
        for j := 1 to n do
            if (i<>j) and (words[i][2] = words[j][1]) then
                addedge(i, j);

    ans := 0;

    for i := 1 to n do
    begin
        fillchar(visited, sizeof(visited), 0);
        dfs(i, 0);
    end;
    writeln(ans);

    close(input); close(output);
end.

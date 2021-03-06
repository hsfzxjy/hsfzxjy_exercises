const
    INF = maxlongint div 3;
var
    s1, s2: string;
    _,__:integer;
    p, f: array [0..30, 0..30] of longint;
    i, j, l1, l2: integer;
function min(x, y: longint): longint; inline;
begin
    if x<y then exit(x) else exit(y);
end;
begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);
    readln(__);
    for _ := 1 to __ do
    begin
        write('Case #', _,': ');
        readln(s1);
        readln(s2);
        l1 := length(s1);
        l2 := length(s2);
        filldword(p, length(p), INF);
        fillchar(f, sizeof(f), 0);
        for i := 0 to l2 do
        begin
            f[0, i] := 1;
            p[0, i] := 0;
        end;
        for i := 0 to l1 do
        begin
            f[i, 0] := 1;
            p[i, 0] := 0;
        end;
        for i := 1 to l1 do
            for j := 1 to l2 do
            begin
                if (s1[i] = s2[j]) then
                begin
                    p[i, j] := p[i-1, j-1] + 1;
                    f[i, j] := f[i, j] + f[i-1, j-1];
                end
                else
                begin
                    if p[i-1, j] > p[i, j-1] then
                        p[i, j] := p[i-1, j]
                    else
                        p[i, j] := p[i, j-1];
                    if p[i-1, j] = p[i, j] then
                        f[i, j] := f[i, j] + f[i-1, j];
                    if p[i, j-1] = p[i, j] then
                        f[i, j] := f[i, j] + f[i, j-1];
                end;
            end;
        writeln(l1+l2-p[l1, l2], ' ', f[l1, l2]);
    end;
    close(input); close(output);
end.

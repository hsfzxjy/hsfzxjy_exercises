var
    n, sum, i, j, a, b: longint;
    m, v, p: array [1..60] of longint;
    f: array [0..3200] of longint;
    link: array [1..60, 0..3] of longint;

function max(x, y: longint): longint;
begin
    if x>y then exit(x) else exiT(Y);
end;
begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(sum, n);
    sum := sum div 10;
    for i := 1 to n do 
    begin
        readln(m[i], v[i], p[i]);
        m[i] := m[i] div 10;
        if p[i]<>0 then 
        begin
            inc(link[p[i]][0]);
            link[p[i]][link[p[i]][0]] := i;
        end;
    end;
    for i := 1 to n do 
        for j := sum downto 1 do 
            if (p[i] = 0) and (j>=m[i]) then
            begin
                f[j] := max(f[j], f[j-m[i]]+m[i]*v[i]);
                a := link[i][1]; b:= link[i][2];
                if (link[i][0]>=1) and (j-m[i]>=m[a]) then
                    f[j] := max(f[j], f[j-m[i]-m[a]]+m[i]*v[i]+m[a]*v[a]);
                if link[i][0] = 2 then
                begin
                    if j-m[i]>=m[b] then
                        f[j] := max(f[j], f[j-m[i]-m[b]]+m[i]*v[i]+m[b]*v[b]);
                    if j-m[i]>=m[a]+m[b] then
                        f[j] := max(f[j], f[j-m[i]-m[b]-m[a]]+m[i]*v[i]+m[b]*v[b]+m[a]*v[a]);
                end;
            end;
    writeln(f[sum]*10);

    close(input); close(output);
end.
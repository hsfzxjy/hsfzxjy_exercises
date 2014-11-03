var
    f: array [0..60, -1..32000, 0..2] of int64;
    v: array [1..60] of integer;
    w: array [1..60] of integer;
    rel: array [1..60] of array of integer;
    isfu: array [1..60] of Boolean;
    i,j,k,l, n, tot, last, money: longint;
    ans: int64;

function max(a: array of int64): int64;
var
    i: Integer;
begin
    max := 0;
    for i := low(a) to high(a) do
        if max < a[i] then max := a[i];
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    read(money, n);
    for i := 1 to n do
    begin
        read(v[i], w[i], j);
        if j <> 0 then
        begin
            SetLength(rel[j], Length(rel[j])+1);
            rel[j][high(rel[j])] := i;
            isfu[i] := true;
        end;
    end;

    last := 0;
    for i := 1 to n do
    begin
        if isfu[i] then continue;
        for j := 0 to money do
        begin
            f[i][j][0] := max([f[last][j][0], f[i][j-1][0]]);
            f[i][j][1] := max([f[last][j][1], f[i][j-1][1]]);
            f[i][j][2] := max([f[last][j][2], f[i][j-1][2]]);

            if j<v[i] then continue;

            f[i][j][0] := max([f[i][j][0], f[last][j-v[i]][0]+v[i]*w[i],
                f[last][j-v[i]][1]+v[i]*w[i], f[last][j-v[i]][2]+v[i]*w[i]]);
            if length(rel[i])>=1 then
                for l := low(rel[i]) to high(rel[i]) do
                    if j-v[i]-v[rel[i][l]] >= 0 then
                        f[i][j][1] := max([
                            f[i][j][1],
                            f[last][j-v[i]-v[rel[i][l]]][0]+v[i]*w[i]+v[rel[i][l]]*w[rel[i][l]],
                            f[last][j-v[i]-v[rel[i][l]]][1]+v[i]*w[i]+v[rel[i][l]]*w[rel[i][l]],
                            f[last][j-v[i]-v[rel[i][l]]][2]+v[i]*w[i]+v[rel[i][l]]*w[rel[i][l]]
                        ]);
            if length(rel[i])=2 then
                    if j-v[i]-v[rel[i][0]] -v[rel[i][1]]>= 0 then
                        f[i][j][2] := max([
                            f[i][j][2],
                            f[last][j-v[i]-v[rel[i][0]] -v[rel[i][1]]][0]+v[i]*w[i]+v[rel[i][0]]*w[rel[i][0]]+v[rel[i][1]]*w[rel[i][1]],
                            f[last][j-v[i]-v[rel[i][0]] -v[rel[i][1]]][1]+v[i]*w[i]+v[rel[i][0]]*w[rel[i][0]]+v[rel[i][1]]*w[rel[i][1]],
                            f[last][j-v[i]-v[rel[i][0]] -v[rel[i][1]]][2]+v[i]*w[i]+v[rel[i][0]]*w[rel[i][0]]+v[rel[i][1]]*w[rel[i][1]]
                        ]);
        end;
        last := i;
    end;
    ans := 0;
    i := money;
    while (i>=0) and (ans=0) do
    begin
        ans := max([f[n][i][0], f[n][i][1], f[n][i][2]]);
        dec(i);
    end;
    writeln(ans);
    close(input); close(output);
end.

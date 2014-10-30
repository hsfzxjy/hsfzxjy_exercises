var
    count: array [1..4] of integer;
    value: array [0..1000] of longint;
    dp: array [-1..40, -1..40, -1..40, -1..40] of int64;
    n, m, i,j, k, l, x: longint;

function max(x, y, z, w: int64): int64;
begin
    if x > y then max := x else max := y;
    if max < z then max := z;
    if max < w then max := w;
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(n, m);
    for i := 1 to n do read(value[i-1]);
    for i := 1 to m do 
    begin
        read(j);
        inc(count[j]);
    end;

    fillchar(dp, sizeof(dp), 0);
    for i := 0 to count[1] do 
        for j := 0 to count[2] do 
            for k := 0 to count[3] do 
                for l := 0 to count[4] do 
                begin
                    x := value[i + j + j + k + k + k+l +l+l+l];
                    dp[i, j, k, l] := max(
                        dp[i-1, j, k, l] + x,
                        dp[i, j-1, k, l] + x,
                        dp[i, j, k-1, l] + x,
                        dp[i, j, k, l-1] + x
                    );
                end;
    writeln(dp[count[1], count[2], count[3], count[4]]);

    close(input); close(output);
end.
var
    map: array [1..10000, 1..4] of longint;
    ans, i, n, x, y: longint;
begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(n);
    for i := 1 to n do 
    begin
        readln(map[i][1], map[i][2], map[i][3], map[i][4]);
    end;
    readln(x, y);
    ans := -1;
    for i := n downto 1 do 
        if (map[i][1]<=x) and (map[i][2]<=y) and (map[i][3]+map[i][1]>=x) and (map[i][2]+map[i][4]>=y)
            then
            begin
                ans := i;
                break;
            end;
    writeln(ans);

    close(input); close(output);
end.
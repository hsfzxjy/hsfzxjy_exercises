var
    queue: array [1..1000] of longint;
    map: array [1..1001] of boolean;
    m, n, head, tail, i, j, cnt, x, len: longint;

begin
    fillchar(map, sizeof(map), 0);
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(m, n);
    tail := 1; head := 0; cnt := 0; len := 0;
    for i := 1 to n do 
    begin
        read(x);
        //writeln(cnt, x);
        if map[x] then continue;
        inc(cnt);
        if len = m then 
        begin
            map[queue[tail]] := false;
            tail := tail mod m + 1;
            dec(len);
        end;
        head := head mod m + 1;
        inc(len);
        queue[head] := x;
        map[x] := true;
    end;
    writeln(cnt);

    close(input); close(output);
end.
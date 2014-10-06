var
    f: array [1..50000] of extended;
    _, i: longint;
begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);
    f[1] := 1;
    for i := 2 to 50000 do 
        f[i] := (2*i-3) / (2*i-2) * f[i-1];
    readln(_);
    while _>0 do
    begin
        dec(_);
        readln(i);
        writeln((1-f[i >> 1]):0:4);
    end;
    close(input);
    close(output);
end.
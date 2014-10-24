var
    a, b, x, y: longint;

procedure exgcd(a, b: longint; var x, y: longint); 
begin
    if b = 0 then
    begin
        x := 1;
        y := 0;
        exit;           
    end;     
    exgcd(b, a mod b, y, x);
    y := y - (a div b) * x;
end;   
begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);
    readln(a,b);
    exgcd(a, b, x, y);
    while x <= 0 do x := x+ b;
    writeln(x);
    close(input); close(output);
end.
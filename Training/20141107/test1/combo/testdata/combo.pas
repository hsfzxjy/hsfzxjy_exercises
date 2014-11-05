var
    x: longint;
    i: longint;
    y: longint;

begin
    assign(input, 'combo.in'); reset(input);
    assign(output, 'combo.out'); rewrite(output);
    
    read(x);
    x := x<<1;
    for y := trunc(sqrt(x)) downto 2 do 
    begin
        if (x mod y<>0) or not (odd(y) xor odd(x div y)) then continue;
        i := x div y;
        i := (i-y+1)>>1;
        writeln(i, ' ', i+y-1);
    end;


    close(input); close(output);
end.
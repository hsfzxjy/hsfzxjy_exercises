const
    Match: array [0..9] of integer = (6, 2, 5, 5, 4, 5, 6, 3, 7, 6);

var
    i, j, n: Integer;
    tot: longint;

{$inline on}
function calc(x: longint): longint; inline;
begin
    if x = 0 then 
        exit(6)
    else
    begin
        calc := 0;
        while x>0 do 
        begin
            calc := calc + Match[x mod 10];
            x := x div 10;
        end;
    end;
end;

function pd(x, y: longint): Boolean;
begin
    exit(calc(x)+calc(y)+calc(x+y)=n);
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(n);
    dec(n, 4);
    for i := 0 to 1000 do 
        for j := 0 to 1000 do 
            if pd(i, j) then inc(tot);
    writeln(tot);

    close(input); close(output);
end.
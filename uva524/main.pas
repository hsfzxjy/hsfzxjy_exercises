var
    n: integer;
    ans: array [1..16] of integer;
    used: set of 1..16;
    primes: set of 1..31;
    cnt: integer;
procedure solve(t: integer);
var
    i: longint;
begin
    if t>n then
    begin
        if (ans[n]+ans[1]) in primes then
        begin
            for i := 1 to n-1 do 
                write(ans[i],' ');
            writeln(ans[n]);
        end;
        exit;
    end;
    for i := 2 to n do
    begin
        if i in used then continue;
        if (t>1) and not ((i+ans[t-1]) in primes) then continue;
        used := used + [i];
        ans[t] := i;
        solve(t+1);
        used := used - [i];
    end;
end;
begin
    primes := [2,3,5,7,11,13,17,19,23,29,31];
    ans[1] := 1;
    cnt := 0;
    while not eof do
    begin
        inc(cnt);
        if cnt>1 then writeln;
        writeln('Case ', cnt, ':');
        readln(n);
        used := [1];
        solve(2);
    end;
end.
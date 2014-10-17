const
    operators: array [1..4] of char = ('*', '+', '-', #0);
var
    s: string;
    _, n: integer;
    op: array [0..10] of char;
    yes: Boolean;

function toValue(ch: char): integer;
begin
    exit(ord(ch) - ord('0'));
end;

procedure calcAndPrint;
var
    numtop, opstop: Integer;
    num: array [1..10] of longint;
    ops: array [1..10] of char;
    i: integer;
begin
    i := 1;
    numtop := 1;
    num[numtop] := toValue(s[1]);
    opstop := 0;
    while i <= n do
    begin
        while (i < n) and (op[i] = #0) do
        begin
            inc(i);
            num[numtop] := num[numtop] * 10 + toValue(s[i]);
        end;
        if (op[i] in ['+', '-']) or (i >= n) then
        begin
            while (opstop > 0) and (ops[opstop] = '*') do
            begin
                dec(opstop);
                num[numtop - 1] := num[numtop] * num[numtop -1];
                dec(numtop);
            end;
        end;
        if i >= n then break;
        inc(opstop);
        ops[opstop] := op[i];
        inc(i);
        inc(numtop);
        num[numtop] := toValue(s[i]);
    end;
    i := 1;
    while i < numtop do
    begin
        if ops[i] = '+' then
            num[i+1] := num[i] + num[i+1]
        else
            num[i+1] := num[i] - num[i+1];
        inc(i);
    end;
    if (num[numtop] = 2000) and (opstop > 0) then
    begin
        yes := True;
        write('  ');
        for i := 1 to n do
        begin
            write(s[i]);
            if op[i] <> #0  then
                write(op[i]);
        end;
        writeln('=');
    end;
end;

procedure dfs(t: integer);
var
    i: Integer;
    ch: char;
begin
    if t = n then
    begin
        calcAndPrint;
        exit;
    end;
    for i := 1 to 4 do
    begin
        ch := operators[i];
        if (ch = #0) and (s[t] = '0') and ((t = 1) or (t > 1) and (op[t-1] <> #0)) then continue;
        op[t] := ch;
        dfs(t+1);
    end;
end;

var
    i: Integer;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(s);
    _ := 0;
    while not eof and (s[1] <> '=') do
    begin
        i := 1;
        while not (s[i] in ['0'..'9', '=']) do
        begin
            inc(i);
        end;
        delete(s, 1, i-1);
        n := pos('=', s) - 1;
        inc(_);
        writeln('Problem ', _);
        yes := False;
        fillchar(op, sizeof(op), 0);
        dfs(1);
        if not yes then
            writeln('  IMPOSSIBLE');
        readln(s);
    end;

    close(input); close(output);
end.

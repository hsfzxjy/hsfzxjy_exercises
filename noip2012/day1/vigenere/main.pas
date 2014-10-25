var
    text, code: Ansistring;
    i, j: longint;

function getbase(ch: char): integer;
begin
    if ch >= 'a' then
        exit(ord('a'))
    else
        exit(ord('A'));
end;

function process(t, code: char): char;
var
    ta, codea, tb, codeb, x: Integer;
begin
    tb := getbase(t);
    codeb := getbase(code);
    ta := ord(t) - tb;
    codea := ord(code) - codeb;
    x := ta - codea;
    if x < 0 then
        x := x + 26;
    exit(chr(tb + x));
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(code);
    readln(text);
    j := 1;
    for i := 1 to length(text) do 
    begin
        write(process(text[i], code[j]));
        inc(j);
        if j > length(code) then j := 1;
    end;

    close(input);close(output);
end.
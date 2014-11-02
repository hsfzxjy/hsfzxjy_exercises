var
    used: array ['A'..'Z'] of Boolean;
    code, fcode: array ['A'..'Z'] of char;
    i: longint;
    ch: char;
    s1, s2, s3: string;
begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(s1);
    readln(s2);
    readln(s3);

    for i := 1 to length(s1) do 
    begin
        if not (code[s1[i]] in [#0, s2[i]]) or not (fcode[s2[i]] in [#0, s1[i]]) then
        begin
            writeln('Failed');
            halt;
        end;
        code[s1[i]] := s2[i];
        fcode[s2[i]] := s1[i];
    end;

    for ch := 'A' to 'Z' do 
        if code[ch] = #0 then
        begin
            writeln('Failed');
            halt;
        end;

    for i := 1 to length(s3) do 
        write(code[s3[i]]);

    close(input); close(output);
end.
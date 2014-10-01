var
    a: qword;
    cnt: longint;
begin
    a := 18446744073709551615;
    cnt := 1500;
    writeln(a mod qword(cnt));
end.
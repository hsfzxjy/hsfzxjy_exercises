type
    Stack = object
        arr: array [1..1000] of integer;
        length: integer;
        constructor Create;
        function top: integer;
        procedure push(x:integer);
        function pop: integer;
        function empty: boolean;
    end;
var
    n, i, m: integer;
    a: array [1..1000] of integer;
    s: Stack;
    ok: boolean;
constructor Stack.Create();
begin
    self.length := 0;
end;
function Stack.top: integer;
begin
    top := arr[self.length];
end;
function Stack.pop: integer;
begin
    pop := top;
    dec(self.length);
end;
procedure Stack.push(x: integer);
begin
    inc(self.length);
    arr[self.length] := x;
end;
function Stack.empty: boolean;
begin
    empty := self.length = 0;
end;

begin
    assign(input, 'main.in');reset(input);
    read(n);
    while n<>0 do
    begin
        while true do
        begin
            read(a[1]);
            if a[1] = 0 then break;
            for i := 2 to n do 
                read(a[i]);
            m := 1;
            i := 1;
            ok := true;
            s.length := 0;
            while m <= n do
            begin
                if i = a[m] then
                begin
                    inc(m);
                    inc(i);
                    continue;
                end;
                if not s.empty and (s.top = a[m]) then
                begin
                    inc(m);
                    s.pop;
                    continue;
                end;
                if i>n then 
                begin
                    ok := false;
                    break;
                end;
                s.push(i);
                inc(i);
            end;
            if ok then
                writeln('Yes')
            else 
                writeln('No');
        end;
        read(n);
        if n<>0 then writeln;
    end;
    close(input);
end.
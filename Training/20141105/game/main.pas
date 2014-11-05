const
    delx: array [1..4] of Integer = (0, 0, -1, 1);
    dely: array [1..4] of integer = (-1, 1, 0, 0);

var
    ht: array [0..1<<16] of boolean;
    ans: array [1..100000, 1..4] of longint;
    cnt: longint;

function pos(x, y: longint): longint;
begin
    pos := x<<2+y;
end;

function can(p1, p2: longint; st: longint): boolean;
begin
    can := ((1<<p1 and st) >> p1) xor ((1<<p2 and st) >> p2) = 1;
end;

procedure swap(p1, p2: longint;var st: longint);
begin
    if (1<<p1 and st = 0) then
    begin
        st := st or (1<<p1);
        st := st and not (1<<p2);
    end
    else
    begin
        st := st or (1<<p2);
        st := st and not (1<<p1);
    end;
end;

var
    st, ed: longint;

{procedure dfs(tt: longint; x: longint);
var
    i, j, t, p1, p2, k, ti, tj: longint;
begin
    if x = ed then
    begin
        print(tt);
        exit;
    end;
    ht[x] := True;
    t := x;
    for i := 0 to 3 do
        for j := 0 to 3 do
        begin
            p1 := pos(i, j);
            for k := 1 to 4 do
            begin
                ti := i+delx[k];
                tj := j + dely[k];
                if (ti<0) or (ti>3) or (tj<0) or (tj>3) then continue;
                x := t;
                p2 := pos(ti, tj);
                if can(p1, p2, x) then
                begin
                    swap(p1, p2, x);
                    if not ht[x] then
                        dfs(tt+1, x);
                end;
            end;
        end;
end;}

var
    q: array [1..1000000] of record value: longint; step: longint; x1, x2, y1, y2, prev: longint; end;
    head, tail: longint;

procedure print(x: longint);
var
    i: longint;
begin
    writeln(q[x].step);
    repeat
        with q[x] do 
        begin
            inc(cnt);
            ans[cnt][1] := x1+1;
            ans[cnt][2] := y1+1;
            ans[cnt][3] := x2+1;
            ans[cnt][4] := y2+1;
        end;
        x := q[x].prev;
    until q[x].step = 0;
    for i := cnt downto 1 do writeln(ans[i][1], ans[i][2], ans[i][3], ans[i][4]);
end;

procedure bfs;
var
    i,j,k,p1,p2,ti,tj,t: Integer;
    x: longint;
begin
    head := 0;
    tail := 1; 
    q[1].value := st;
    q[1].step := 0;
    while head<>tail do 
    begin
        inc(head);
        x := q[head].value;
        t := x;
        for i := 0 to 3 do
            for j := 0 to 3 do
            begin
                p1 := pos(i, j);
                for k := 1 to 4 do
                begin
                    ti := i+delx[k];
                    tj := j + dely[k];
                    if (ti<0) or (ti>3) or (tj<0) or (tj>3) then continue;
                    x := t;
                    p2 := pos(ti, tj);
                    if can(p1, p2, x) then
                    begin
                        swap(p1, p2, x);
                        if not ht[x] then
                        begin
                            ht[x] := True;
                            inc(tail);
                            q[tail].value := x;
                            q[tail].step := q[head].step+1;
                            q[tail].prev := head;
                            q[tail].x1 := i;
                            q[tail].y1 := j;
                            q[tail].x2 := ti;
                            q[tail].y2 := tj;
                            if x = ed then 
                            begin
                                print(tail);
                                exit;
                            end;
                        end;
                    end;
                end;
            end;
    end;
end;

procedure init(var x: longint);
var
    i: Integer;
    k: char;
begin
    x := 0;
    for i := 1 to 16 do
    begin
        read(k);
        x := x + (ord(k)-48)<<(i-1);
        if i mod 4 = 0 then readln;
    end;
end;

begin
    assign(input, 'game.in'); reset(input);
    assign(output, 'game.out'); rewrite(output);

    init(st);
    init(ed);
    bfs;

    close(input); close(output);
end.

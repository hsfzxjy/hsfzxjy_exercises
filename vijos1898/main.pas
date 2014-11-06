type
    TStatus = array [1..3, 1..3] of shortint;
var
    q: array [1..10000000] of record s:TStatus; t:longint;end;
    ht: array [1..1000000000] of Boolean;

function hash(x: TStatus): Longint;
var
    i, j: Integer;
begin
    hash := 0;
    for i := 1 to 3 do
        for j := 1 to 3 do
            hash := hash*10+x[i][j];
end;

procedure move(var a: TStatus; i, dir: longint);
var
    t: Integer;
begin
    case dir of
    1:begin
        t := a[i][1];
        a[i][1]:=a[i][2];
        a[i][2]:=a[i][3];
        a[i][3]:=t;
    end;
    2:begin
        t := a[i][3];
        a[i][3]:=a[i][2];
        a[i][2]:=a[i][1];
        a[i][1]:=t;
    end;
    3:begin
        t := a[1][i];
        a[1][i] := a[2][i];
        a[2][i]:=a[3][i];
        a[3][i]:=t;
    end;
    4:begin
        t := a[3][i];
        a[3][i]:=a[2][i];
        a[2][i]:=a[1][i];
        a[1][i]:=t;
    end;
    end;
end;

var
    ed, st: TStatus;

function check(a: TStatus): Boolean;
var
    i, j: Integer;
begin
    check := True;
    for i := 1 to 3 do
        for j := 1 to 3 do
            if (ed[i][j]>0) and (ed[i][j]<>a[i][j]) then
                exit(false);
end;

function  bfs: longint;
var
    head, tail: longint;
    i,h,dir: longint;
    t: TStatus;
begin
    fillchar(ht, sizeof(ht), 0);
    head := 0; tail := 1; q[1].s := st; q[1].t := 0;
    while head<>tail do
    begin
        inc(head);
        for dir := 1 to 4 do
            for i := 1 to 3 do
            begin
                t := q[head].s;
                move(t,i,dir);
                if check(t) then
                begin
                    writeln(q[head].t+1);
                    exit;
                end;
                h := hash(t);
                if ht[h] then continue;
                ht[h] := True;
                inc(tail);
                q[tail].s := t;
                q[tail].t := q[head].t+1;
            end;
    end;
    writeln('No Solution!');
end;

function val(x: char): longint;
begin
    if x = '*' then exit(-1);
    exit(ord(x)-ord('0'));
end;

var
    t, i, j,_: Integer;
    s: string;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(t);
    for _ := 1 to t do
    begin
        write('Case #',_,': ');
        for i := 1 to 3 do
        begin
            for j := 1 to 3 do
                read(st[i][j]);
            readln;
        end;
        for i := 1 to 3 do
        begin
            readln(s);
            //writeln(s);
            for j := 1 to 3 do
                ed[i][j] := val(s[2*j-1]);
        end;

        bfs;
    end;

    close(input); close(output);
end.

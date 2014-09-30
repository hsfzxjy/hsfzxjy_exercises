//Accepted
type
    Cube = object
        a: array [1..3] of longint;
        procedure init(x,y,z: longint);
        function height(k: integer): longint;
        function low(k: integer): longint;
        function high(k: integer): longint;
    end;

function max(x,y: longint): longint;
begin
    if x>y then max := x else max := y;
end;

procedure swap(var x,y: longint);
var
    t: longint;
begin
    t := x;
    x := y;
    y := t;
end;

function Cube.height(k: integer): longint;
begin
    height := self.a[k];
end;

function Cube.high(k: integer): longint;
begin
    case k of
        1: high := a[3];
        2: high := a[3];
        3: high := a[2];
    end;
end;

function Cube.low(k: integer): longint;
begin
    case k of
        1: low := a[2];
        2,3: low := a[1];
    end;
end;

procedure Cube.init(x, y, z: longint);
begin
   if x>y then swap(x,y);
   if y>z then swap(y,z);
   if x>y then swap(x,y);
   a[1] := x;
   a[2] := y;
   a[3] := z;
end;

var
    f: array [1..30, 1..3] of longint;
    i,j,m,n,x,y,z: longint;
    cnt: longint;
    cubes: array [1..30] of Cube;

function dp(id, k: integer): longint;
var
    l, h, hi: longint;
    i, j: integer;
begin
    if f[id, k] > 0 then
        exit(f[id, k]);
    l := cubes[id].low(k);
    hi := cubes[id].height(k);
    h := cubes[id].high(k);

    f[id, k] := hi;

    for i := 1 to n do
    begin
        //if i = id then continue;
        for j := 1 to 3 do
        begin
            if not ((cubes[i].low(j) < l) and (cubes[i].high(j) < h)) then
                continue;
            f[id, k] := max(f[id, k], dp(i, j)+hi);
        end;
    end;

    dp := f[id, k];
end;

begin
    assign(input, 'main.in');reset(input);
    assign(output, 'main.out');rewrite(output);
    read(n);
    cnt := 0;
    while n > 0 do
    begin
        inc(cnt);
        for i := 1 to n do
        begin
            read(x,y,z);
            cubes[i].init(x,y,z);
        end;
        fillchar(f, sizeof(f), 0);

        m := 0;
        for i := 1 to n do
            for j := 1 to 3 do
                m := max(m, dp(i, j));

        writeln('Case ', cnt, ': maximum height = ', m);

        read(n);
    end;
    close(input);close(output);
end.

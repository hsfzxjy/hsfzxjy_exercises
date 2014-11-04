const
    INF = 1<<60;

var
    map: array [1..5000, 1..5000] of Double;
    coor: array [1..5000, 1..2] of double;
    ans: Double;
    i, j, n: longint;

{$inline on}
function dis(x, y: longint): Double; inline;
begin
    if (x = y) or (map[x, y]<>0) then exit(map[x, y]);
    map[x, y] := sqrt(sqr(coor[x][1]-coor[y][1])+sqr(coor[x][2]-coor[y][2]));
    exit(map[x, y]);
end;

type
    Rec = record
        index: longint;
        value: Double;
    end;

var
    lowest: array [1..5000] of rec;
    pos: array [1..5000] of longint;
    used: array [1..5000] of Boolean;

operator <(x, y: rec)res: Boolean;
begin
    res := x.value<y.value;
end;

procedure swap(x, y: longint); inline;
var
    t: rec;
begin
    t := lowest[x];
    lowest[x] := lowest[y];
    lowest[y] := t;
    pos[lowest[x].index] := x;
    pos[lowest[y].index] := y;
end;

procedure down(n: longint); inline;
var
    i: longint;
begin
    i := 2;
    while i<=n do
    begin
        if (i<n) and (lowest[i+1]<lowest[i]) then inc(i);
        if lowest[i]<lowest[i>>1] then
            swap(i>>1, i)
        else
            break;
        i := i<<1;
    end;
end;

procedure up(i, n: longint); inline;
var
    k: longint;
begin
    while i>1 do
    begin
        if lowest[i]<lowest[i>>1] then
            swap(i, i>>1)
        else
            break;
        i:=i>>1;
    end;
end;

function get_min(n: longint): rec; inline;
begin
    swap(n, 1);
    get_min := lowest[n];
    down(n-1);
end;

function decrease(i, n: longint): longint; inline;
var
    t: rec;
begin
    t := lowest[i];
    while (i>1) and (t<lowest[i>>1]) do
    begin
        lowest[i] := lowest[i>>1];
        pos[lowest[i].index] := i;
        i := i>>1;
    end;
    lowest[i] := t;
    pos[t.index] := i;
end;

function prim: Double;
var
    i, j,k, l: longint;
    min, t: Double;
begin
    lowest[1].value := 0;
    lowest[1].index := 1;
    pos[1] := 1;
    for i := 2 to n do
    begin
        lowest[i].value := INF;
        lowest[i].index := i;
        pos[i] := i;
    end;

    for i := 1 to n do
    begin
        with get_min(n-i+1) do
        begin
            k := index;
            min := value;
        end;
        ans := ans + min;
        used[k] := True;
        for j := 1 to n do
        begin
            l := pos[j];
            with lowest[l] do
                if not used[index] and (value>dis(index, k)) then
                begin
                    value := dis(index, k);
                    decrease(l, n-i);
                end;
        end;
    end;
    prim :=ans;
end;

begin
    assign(input, 'road.in'); reset(input);
    assign(output, 'road.out'); rewrite(output);

    read(n);
    for i := 1 to n do
        read(coor[i][1], coor[i][2]);

    writeln(prim:0:2);

    close(input); close(output);
end.

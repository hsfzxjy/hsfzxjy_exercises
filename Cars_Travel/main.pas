type
    TPoint = record
        x, y : longint;
    end;

operator -(x, y: TPoint)res: TPoint;
begin
    res.x := x.x - y.x;
    res.y := x.y - y.y;
end;

operator +(x, y: TPoint)res: TPoint;
begin
    res.x := x.x + y.x;
    res.y := x.y + y.y;
end;

operator *(x, y: TPoint)res: longint;
begin
    res := (x.x * y.x) + x.y * y.y;
end;

var
    a: array [4..403] of TPoint;
    T: array [1..100] of longint;
    map: array [4..403, 4..403] of double;

function dis(x, y: TPoint): double;
begin
    dis := sqrt(sqr(x.x-y.x)+sqr(x.y-y.y));
end;

procedure process(ii: longint);
var
    v1, v2, v3: TPoint;
    i, j, k: longint;
begin
    i := ii<<2;
    v1 := a[i] - a[i+1];
    v2 := a[i+1] - a[i+2];
    v3 := a[i+2] - a[i];
    if v1 * v2 = 0 then
        a[i+3] := a[i] + a[i+2] - a[i+1]
    else if v2 * v3 = 0 then
        a[i+3] := a[i] - a[i+2] + a[i+1]
    else
        a[i+3] := a[i+1] -a[i] + a[i+2];
    for j := i to i + 3 do
        for k := i to i + 3 do
            if j<>k then
            begin
                map[j, k] := T[ii] * dis(a[j], a[k]);
                map[k, j] := map[j, k];
            end;
end;

var
    q: array [1..1000] of longint;
    d: array [4..503] of double;
    sets: array [4..403] of Boolean;
    head, tail: longint;

var
    _: Integer;
    n, k, start, terminal: longint;
    i, j: longint;
    ans: Double;

function spfa(x: longint): double;
var
    i: longint;
    min: double;
begin
    fillchar(sets, sizeof(sets), 0);
    for i := 4 to n<<2+3 do
        d[i] := 1<<60;
    head := 0; tail := 1; q[1] := x; sets[x] := true; d[x] := 0;
    while head<>tail do
    begin
        head := (head+1) mod 1000;
        x := q[head];
        sets[x] := false;

        for i := 4 to n<<2+3 do
            if d[i]>map[i][x]+d[x] then
            begin
                d[i] := map[i][x] + d[x];
                if not sets[i] then
                begin
                    sets[i] := true;
                    tail := (tail + 1) mod 1000;
                    q[tail] := i;
                end;
            end;
    end;
    min := d[terminal<<2];
    for i := terminal<<2+1 to terminal<<2+3 do
        if min > d[i] then
            min := d[i];

    spfa := min;
end;

function min(x, y: Double): Double;
begin
    if x<y then exit(x) else exit(y);
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    read(_);
    while _>0 do
    begin
        dec(_);
        read(n, k, start, terminal);
        for i := 1 to n do
        begin
            read(a[i<<2].x, a[i<<2].y, a[i<<2+1].x, a[i<<2+1].y, a[i<<2+2].x, a[i<<2+2].y, T[i]);
            process(i);
        end;

        for i := 4 to n<<2+3 do
            for j := 4 to n<<2 + 3 do
                if i>>2 <> j >>2 then
                    map[i][j] := k * dis(a[i], a[j]);

        ans := 1<<60;
        for i := start<<2 to start<<2+3 do
            ans := min(ans, spfa(i));

        writeln(ans:0:1);
    end;

    close(input); close(output);
end.

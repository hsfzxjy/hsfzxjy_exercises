type
    TPoint = record 
        x, y: int64;
    end;

operator -(a, b: TPoint)res: TPoint;
begin
    res.x := a.x-b.x;
    res.y := a.y-b.y;
end;

operator *(a, b: TPoint)res: int64;
begin
    res := a.x*b.y-a.y*b.x;
end;

function intersect(a, b: TPoint;c, d: TPoint): Boolean;
begin
    intersect := ((a-c)*(a-d))*((b-c)*(b-d))<0;
    intersect := intersect and (((c-a)*(c-b)) * ((d-a) * (d-b))<0);
end;

var
    p: array [1..10] of TPoint;
    l: array [1..10] of longint;
    used: array [1..10] of Boolean;
    a: array [1..10, 1..10, 1..10, 1..10] of longint;
    ln: Longint;
    n: longint;
    tot: longint;
procedure dfs(t: longint);
begin
    if t>n then 
    begin
        inc(tot);
        exit;
    end;

    for i := 1 to n do 
    begin
        if (used[i]) or (i=w[t]) then continue;
        for j := 1 to t-1
        if a[i][l[t]][]
    end;
end;
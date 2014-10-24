const
    MAXP = 100000;
var
    arr: array [1..MAXP] of boolean;
    primes: array [1..100000] of longint;
    pn, i: longint;
procedure filter_primes;
var
    i, j, t: longint;
    br: boolean;
begin
    pn := 0;
    fillchar(arr, sizeof(arr), 0);
    fillchar(primes, sizeof(primes), 0);
    for i := 2 to MAXP do
    begin
        if not arr[i] then
        begin
            inc(pn);
            primes[pn] := i;
        end;
        j := 1;
        br := false;
        while j <= pn do
        begin
            if br then break;
            if arr[i] and (i mod primes[j] = 0) then
                br := true;
            t := primes[j] * i;
            if t > MAXP then break;
            arr[t] := true;
            inc(j);
        end;
    end;
end;


function judge(x: longint): boolean;
var
    i, t: longint;
begin
    if x <= MAXP then
        exit(not arr[x]);
    judge := true;
    t := trunc(sqrt(x));
    i := 1;
    while (primes[i]<=t) and (x mod primes[i] <> 0) do inc(i);
    if primes[i]<=t then judge := false;
end;

var
    minm: int64;
    n: longint;

function min(x, y: longint): longint;
begin
    if x < y then exit(x) else exit(y);
end;

procedure dfs(x, t: longint;m: int64);
var
    tn, tm: longint;
    p, i: longint;
begin
    if (x>1) and judge(x + 1) and (x+1>primes[t]) then
    begin
        m := m * (x+1);
        x := 1;
    end;

    if x = 1 then
    begin
        minm := min(m, minm);
        exit;
    end;

    tn := x;
    tm := m;
    for i := t+1 to pn do
    begin
        p := primes[i];
        x := tn;
        if p > x+1 then exit;
        if x mod (p-1) <> 0 then continue;
        x := x div (p-1);
        m := tm * p;
        while x mod p = 0 do
        begin
            if (m > maxlongint div p) or (m > minm) then exit;
            //if judge(x+1) then
            //    minm := min(m * (x+1), minm);
            dfs(x, i,m);
            x := x div p;
            m := m * p;
        end;
        dfs(x, i,m);
    end;
end;

var
    _: longint;

begin
    assign(input, 'main.in');  reset(input);
    assign(output, 'main.out'); rewrite(output);

    filter_primes;
    readln(n);
    _ := 0;
    while n <> 0 do
    begin
        inc(_);
        minm := 2000000000;
        if n = 1 then
            minm := 1
        else
            dfs(n, 1,1);
        writeln('Case ', _, ': ', n, ' ', minm);
        readln(n);
    end;

    close(input); close(output);
end.

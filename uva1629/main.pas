//WA
{$R-}
const INF = maxint div 5;
var
    f: array [0..20, 0..20, 0..20, 0..20] of integer;
    cherries: array [1..500, 1..2] of integer;
    map: array [0..20, 0..20] of boolean;
    n, m, i, k: integer;

function min(x, y: integer): integer; inline;
begin
    if x<y then exit(x) else exit(y);
end;

function cherryin(u, d, l, r: integer): integer; inline;
var
    i, j: integer;
begin
    cherryin := 0;
    for i := u+1 to d do
        for j := l+1 to r do
            if map[i, j] then
            begin
                inc(cherryin);
                if cherryin = 2 then exit;
            end;
end;

function dp(u, d, l, r: integer): integer;
var
    b: integer;
    i: integer;
begin
    if f[u, d, l, r] <> -1 then
        exit(f[u,d , l, r]);
    b := cherryin(u, d, l, r);
    if b = 1 then
    begin
        f[u, d, l, r] := 0;
        exit(0);
    end;
    if b = 0 then
    begin
        f[u, d, l, r] := INF;
        exit(INF);
    end;
    dp := INF;
    for i := u+1 to d-1 do
        dp := min(dp, dp(u, i, l, r)+dp(i, d, l, r)+r-l);
    for i := l+1 to r-1 do
        dp := min(dp, dp(u, d, l, i)+dp(u, d, i, r)+d-u);
    f[u, d, l, r] := dp;
end;

var
    _: integer;

begin
    assign(input, 'main.in');reset(input);
    assign(output, 'main.out');rewrite(output);
    _ := 0;
    readln(n, m, k);
    while n>0 do
    begin
        inc(_);
        fillchar(map, sizeof(map), 0);
        fillchar(f, sizeof(f), -1);
        for i := 1 to k do
        begin
            readln(cherries[i, 1], cherries[i, 2]);
            map[cherries[i, 1], cherries[i, 2]] := true;
        end;
        writeln('Case ',_,': ', dp(0,n,0,m));
        readln(n, m, k);
    end;
    close(input);close(output);
end.

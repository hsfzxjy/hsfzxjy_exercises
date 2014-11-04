var
    map: array [1..5000, 1..5000] of Double;
    coor: array [1..5000, 1..2] of longint;
    ans: Double;
    i, j, n: longint;

{$inline on}
function dis(x1, y1, x2, y2: Double): Double; inline;
begin
    dis := sqrt(sqr(x1-x2)+sqr(y1-y2));
end;

var
    lowest: array [1..5000] of Double;
    used: array [1..5000] of Boolean;

function prim: Double;
var
    i, j,k: longint;
    min: Double;
begin
    lowest[1] := 0;
    for i := 2 to n do 
    begin
        lowest[i] := map[1, i];
        writeln(lowest[i]:0:2);
    end;
    writeln;
    used[1] := true;
    for i := 2 to n do 
    begin
        min := maxlongint;
        for j := 1 to n do 
            if (lowest[j]<min) and not used[j] then
            begin
                min := lowest[j];
                k := j;
            end;
        writeln(k,' ', min:0:2);
        ans := ans + lowest[k];
        used[k] := True;
        writeln('###############');
        for j := 1 to n do 
            if not used[j] and (lowest[j]>map[j, k]) then
            begin
                lowest[j] := map[j, k];
                writeln(j, ' ', lowest[j]:0:2);
            end;
    end;
    prim :=ans;
end;

begin
    assign(input, 'road3.in'); reset(input);
    assign(output, 'road.out'); rewrite(output);
    
    read(n);
    for i := 1 to n do 
        read(coor[i][1], coor[i][2]);

    for i := 1 to n do 
        for j := 1 to n do 
            if i>j then
                map[i, j] := map[j, i]
            else
                map[i, j] := dis(coor[i][1], coor[i][2], coor[j][1], coor[j][2]);
    writeln(prim:0:2);

    close(input); close(output);
end.
//Unsolved.
type
    Arr = array of integer;
    LianTong = record
        group1, group2: Arr;
        d: integer;
    end;
var
    map: array [1..100, 1..100] of boolean; //True indicates i and j are not known by each other.
    visited: array [1..100] of record b: boolean; d: boolean; end;
    lts: array of LianTong;
    _,i,j,k, len, n:integer;
    b: boolean;
    error: boolean;

function doit(xx: integer): boolean;
var
    lt: LianTong;
    tmp: boolean;
    ta: Arr;
    l1, l2: integer;

    procedure dfs(x: integer);
    var
        i: Integer;
        tmpArr: Arr;
        b: boolean;
    begin
        visited[x].b := true;
        visited[x].d := tmp;
        if tmp then
            tmpArr := lt.group1
        else
            tmpArr := lt.group2;
        SetLength(tmpArr, Length(tmpArr)+1);
        tmpArr[High(tmpArr)] := x;
        tmp := not tmp;
        for i := 1 to n do
        begin
            if visited[i].b then 
            begin
                if visited[i].d = visited[x].d then
                begin
                    error := true;
                    exit;
                end
                else
                    continue;
            end;
            dfs(i);
            if error then exit;
        end;
        tmp := not tmp;
    end;

begin
    doit := true;
    inc(len);
    SetLength(lts, len);
    lt := lts[High(lts)];
    dfs(xx);
    if error then exit(false);
    l1 := length(lt.group1);
    l2 := length(lt.group2);
    if l1 < l2 then
    begin
        ta := lt.group1;
        lt.group1 := lt.group2;
        lt.group2 := ta;
    end;
    lt.d := abs(l1 - l2);
end;

var
    f: array [0..100] of longint;
    states: array of -1..1;
    l1, l2: longint;
    list1, list2: array [1..100] of integer;

begin
    assign(input, 'main.in');reset(input);
    assign(output, 'main.out');rewrite(output);
    readln(_);
    readln;
    while _>0 do 
    begin
        dec(_);
        readln(n);
        fillchar(map, sizeof(map), 0);
        fillchar(lts, sizeof(lts), 0);
        for i := 1 to n do
        begin
            read(j);
            while j<>0 do
            begin
                map[i, j] := true;
                read(j);
            end;
            readln;
        end;
        readln;
        for i := 1 to n do
            for j := 1 to i do
            begin
                b := not (map[i, j] and map[j, i]);
                map[i, j] := b;
                map[j, i] := b;
            end;

        len := 0;
        error := false;
        for i := 1 to n do
            if not visited[i].b then 
                if not doit(i) then
                    break;
        if error then 
        begin
            readln(n);
            writeln('No solution.');
            writeln;
            continue;
        end;

        fillchar(f, sizeof(f), 0);
        fillchar(states, sizeof(states), 0);
        SetLength(states, len);
        f[0] := lts[0].d;
        states[0] := 1;
        for i := 1 to len-1 do
        begin
            if abs(f[i-1]+lts[i].d) < abs(f[i-1]-lts[i].d) then
            begin
                states[i] := 1;
                f[i] := f[i-1]+lts[i].d;
            end
            else
            begin
                states[i] := -1;
                f[i] := f[i-1]-lts[i].d;                
            end;
        end;

        l1 := 0; l2 := 0;
        for i := 0 to len-1 do
        begin
            if states[i] > 0 then
            begin
                for j := Low(lts[i].group1) to High(lts[i].group1) do
                    list1[l1+1+j] := lts[i].group1[j];
                for j := Low(lts[i].group2) to High(lts[i].group2) do
                    list2[l1+1+j] := lts[i].group2[j];
                l1 := l1 + length(lts[i].group1);
                l2 := l2 + length(lts[i].group2);                
            end
            else
            begin
                for j := Low(lts[i].group1) to High(lts[i].group1) do
                    list2[l1+1+j] := lts[i].group1[j];
                for j := Low(lts[i].group2) to High(lts[i].group2) do
                    list1[l1+1+j] := lts[i].group2[j];
                l1 := l1 + length(lts[i].group2);
                l2 := l2 + length(lts[i].group1);                  
            end;
        end;

        write(l1, ' ');
        for i := 1 to l1-1 do write(list1[i],' ');
        writeln(list1[l1]);
        write(l2, ' ');
        for i := 1 to l2-1 do write(list2[i],' ');
        writeln(list1[l2]);        
        writeln;
    end;
    close(input);close(output);
end.
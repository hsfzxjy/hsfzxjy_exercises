type
    TState = record
        map: array [1..7, 1..10] of integer;
    end;
var
    head, tail: longint;
    start: TState;
    maxstep: longint;
    ok: boolean;

function dfs(k: longint; state: TState): boolean; forward;
var
    ans: array [1..100000, 1..3] of longint;

procedure print(k: longint);
var
    i: longint;
begin
    ok := True;
    for i := 1 to k do
        writeln(ans[i][1], ' ', ans[i][2], ' ', ans[i][3]);
end;


function check(k: longint;var state: TState): Boolean;
var
    xx, yy, i, j, d: Integer;
    min, max: integer;
    changed: Boolean;
    color: array [1..5, 1..7] of boolean;
begin
    changed := False;
    fillchar(color, sizeof(color), 0);
    with state do
    begin
        for i := 1 to 5 do
        begin
            j := 1;
            while (j<=7) and (map[i][j] <> 0) do
            begin
                if (map[i][j] = map[i][j+1]) and (map[i][j+1]=map[i][j+2]) then
                begin
                    color[i][j] := true;
                    color[i][j+1]:=true;
                    color[i][j+2]:=true;
                    changed := True;
                end;
                if (map[i][j]=map[i+1][j]) and (map[i+1][j] = map[i+2][j]) then
                begin
                    color[i][j] := true;
                    color[i+1][j] := true;
                    color[i+2][j] := true;
                    changed := true;
                end;
                inc(j);
            end;
        end;
        for i := 1 to 5 do
            for j := 1 to 7 do
                if color[i][j] then
                    map[i][j] := -1;

        for i := 1 to 5 do
        begin
            yy := 1;
            for j := 1 to 7 do
            begin
                if map[i][j] = 0 then break;
                if map[i][j] = -1 then
                begin
                    map[i][j] := 0;
                    continue;
                end;
                map[i][yy] := map[i][j];
                if yy<j then
                    map[i][j] := 0;
                inc(yy);
            end;
        end;

        check := True;
        for i := 1 to 5 do
            if map[i][1] <> 0 then
            begin
                check := False;
                break;
            end;

        if check then
        begin
            print(k);
        end
        else if not changed then
            dfs(k, state)
        else
            check := check(k, state);
    end;
end;

procedure move(var state: TState; x, y: integer; dir: integer);
var
    d, i, j, t: longint;
begin
    d := state.map[x, y];
    if state.map[x+dir][y] = 0 then
    begin
        i := y;
        while (y<7) and (state.map[x][i] <> 0) do
        begin
            state.map[x][i] := state.map[x][i+1];
            state.map[x][i+1] := 0;
            inc(i);
        end;
        i := y;
        while (i>1) and (state.map[x+dir][i-1] = 0) do
            dec(i);
        state.map[x+dir][i] := d;
    end
    else
    begin
        t := state.map[x][y];
        state.map[x][y] := state.map[x+dir][y];
        state.map[x+dir][y] := t;
    end;
end;

function dfs(k: longint; state: TState): boolean;
var
    i, j: Integer;
    tmp: TState;
begin
    if k >= maxstep then exit;
    for i := 1 to 5 do
    begin
        for j := 1 to 7 do
        begin
            if state.map[i][j] = 0 then continue;
            tmp := state;
            if (i < 5) and (state.map[i][j] <> state.map[i+1][j]) then
            begin
                move(tmp, i, j, 1);

                ans[k+1][1] := i-1;
                ans[k+1][2] := j-1;
                ans[k+1][3] := 1;
                check(k+1, tmp);
                if ok then exit;
            end;

            tmp := state;
            if (i > 1) and (state.map[i-1][j] = 0) then
            begin
                move(tmp, i, j, -1);

                ans[k+1][1] := i-1;
                ans[k+1][2] := j-1;
                ans[k+1][3] := -1;
                check(k+1, tmp);
                if ok then exit;
            end;
        end;
    end;
end;

var
    i, j, x: Integer;
    cnt: longint;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    fillchar(start, sizeof(start), 0);
    read(maxstep);
    for i := 1 to 5 do
    begin
        j := 1;
        read(x);
        while x<>0 do
        begin
            start.map[i][j] := x;
            read(x);
            inc(j);
        end;
    end;
    ok := False;
    dfs(0, start);
    if not ok then writeln(-1);

    close(input); close(output);
end.

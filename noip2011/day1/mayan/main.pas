const
    MAXQ = 1000000;
type
    TState = record
        map: array [1..5, 1..7] of integer;
        x, y: integer;
        dir: longint;
        prev: longint;
        step: longint;
    end;
var
    q: array [1..MAXQ] of TState;
    head, tail: longint;
    start, terminal: TState;
    maxstep: longint;

function next(x: longint): longint;
begin
    if x < MAXQ then
        next := x + 1
    else
        next := x mod MAXQ + 1;
end;

function check(var state: TState): Boolean;
var
    xx, yy, i, j, d: Integer;
    min, max: integer;
    changed: Boolean;
begin
    changed := False;
    with state do
    begin
        for i := 1 to 5 do
        begin
            j := 1;
            while (j<=7) and (map[i][j] <> 0) do
            begin
                d := map[i][j];
                if d = -1 then
                begin
                    inc(j);
                    continue;
                end;

                min := i;
                while (min > 1) and (map[min-1][j] = d) do dec(min);
                max := i;
                while (max<5) and (map[max+1][j] = d) do inc(max);
                if max - min >=2 then
                begin
                    for xx := min to max do map[xx][j] := -1;
                    changed := True;
                end;

                min := j;
                while (min > 1) and (map[i][min-1] = d) do dec(min);
                max := j;
                while (max < 7) and (map[i][max+1] = d) do inc(max);
                if max - min >=2 then
                begin
                    for yy := min to max do map[i][yy] := -1;
                    changed := True;
                end;
                inc(j);
            end;
        end;

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
        if not changed then
            exit
        else if not check then
            check := check(state);
    end;
end;

procedure move(var state: TState; x, y: integer; dir: integer);
var
    d, i, j, t: longint;
begin
    inc(state.step);
    state.x := x;
    state.y := y;
    state.dir := dir;
    d := state.map[x, y];
    if state.map[x+dir][y] = 0 then
    begin
        i := y;
        while (y<7) and (state.map[x][i+1] <> 0) do
        begin
            state.map[x][i] := state.map[x][i+1];
            inc(i);
        end;
        i := y;
        while (i>1) and (state.map[x+dir][i-1] <> 0) do
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

function bfs: Boolean;
var
    state: TState;
    i, j: integer;
    ok: boolean;
begin
    head := 1; tail := 0; q[1] := start;
    while head <> tail do
    begin
        tail := next(tail);
        for i := 1 to 5 do
        begin
            j := 1;
            while q[tail].map[i][j] <> 0 do
            begin
                state := q[tail];
                if (i < 5) and (state.map[i][j] <> state.map[i+1][j]) then
                begin
                    move(state, i, j, 1);
                    state.prev := tail;
                    if check(state) then
                    begin
                        head := next(head);
                        q[head] := state;
                        exit(True);
                    end;
                    if state.step <= maxstep then
                    begin
                        head := next(head);
                        q[head] := state;
                    end;
                end;
                inc(j);
                state := q[tail];
                if (i > 1) and (state.map[i-1][j] = 0) then
                begin
                    move(state, i, j, -1);
                    state.prev := tail;
                    ok := check(state);
                    if check(state) then
                    begin
                        head := next(head);
                        q[head] := state;
                        exit(True);
                    end;
                    if state.step <= maxstep then
                    begin
                        head := next(head);
                        q[head] := state;
                        if ok then exit(True);
                    end;
                end;
            end;
        end;
    end;
    exit(False);
end;

var
    i, j, x: Integer;
    cnt: longint;
    ans: array [1..100000, 1..3] of integer;

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
    start.prev := -1;
    if not bfs then
        writeln(-1)
    else
    begin
        x := head;
        cnt := 0;
        while q[x].prev <> -1 do
        begin
            ans[cnt+1][1] := q[x].x;
            ans[cnt+1][2] := q[x].y;
            ans[cnt+1][3] := q[x].dir;
            inc(cnt);
            x := q[x].prev;
        end;
        writeln(cnt);
        for i := 1 to cnt do
        begin
            writeln(ans[i][1], ' ', ans[i][2], ' ', ans[i][3]);
        end;
    end;

    close(input); close(output);
end.

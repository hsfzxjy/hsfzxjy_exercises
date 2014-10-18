{$inline on}
type
    TState = packed record
        code: array [1..9] of byte;
        depth: longint;
        x,y: byte;
    end;
    PState = ^TState;
const
    xvect: array [1..6] of byte = (4, 5, 6, 1, 2, 3);
    yvect: array [1..6] of byte = (6, 3, 2, 5, 4, 1);
    xdir:  array [1..4] of integer = (0, 0, -1, 1);
    ydir:  array [1..4] of integer = (-1, 1, 0, 0);
    initialState: TState = (
        code: (1, 1, 1, 1, 1, 1, 1, 1, 1);
        depth: 0;
        x: 0;
        y: 0
    );
    HASHMAX = 40353610;
    MAXQUEUE = 100000;
var
    ht: array [1..HASHMAX] of boolean;
    q: array [1..MAXQUEUE] of TState;
    head, tail: longint;
    ans, tmp: longint;
    target: array [1..9] of byte;
    maxd, i: longint;
    sx, sy: integer;
    ch: char;
    state: TState;

function IsTarget(st: TState): boolean; inline;
var
    i: Integer;
begin
    for i := 1 to 9 do
        if (st.code[i] + 1) >> 1 <> target[i] then
            exit(False);
    exit(True);
end;

function nextIndex(x: longint): longint; inline;
begin
    if x < MAXQUEUE then
        exit(x+1);
    exit(x mod MAXQUEUE + 1);
end;

function makePos(x, y: integer): integer; inline;
begin
    makePos := (y-1) * 3 + x;
end;

function hash(st: TState): longint; inline;
var
    i: Integer;
begin
    hash := st.code[1];
    for i := 2 to 9 do
        hash := hash * 7 + st.code[i];
end;

function checkOrInsert(st: TState): boolean; inline; // False for inserted.
var
    h: Longint;
begin
    h := hash(st);
    if ht[h] then
        exit(False);
    ht[h] := True;
    exit(True);
end;

function move(var st: TState; dir: integer): boolean; inline;
var
    tx, ty: integer;
    space, newPos, t: ^byte;
begin
    tx := st.x + xdir[dir];
    ty := st.y + ydir[dir];
    if (tx <= 0) or (tx > 3) or (ty <= 0) or (ty > 3) then exit(False);
    space := @st.code[makePos(st.x, st.y)];
    newPos := @st.Code[makePos(tx, ty)];
    t := space;
    space := newPos;
    newPos := t;
    if dir<=2 then
        newPos^ := yvect[space^]
    else
        newPos^ := xvect[space^];
    space^ := 0;
    inc(st.depth);
    st.x := tx;
    st.y := ty;
    exit(True);
end;

function bfs: longint; inline;
var
    st: TState;
    dir: integer;
begin
    if IsTarget(state) then
        exit(0);

    fillchar(ht, sizeof(ht), 0);
    fillchar(q, sizeof(q), 0);

    head := 0;
    tail := 1;
    q[tail] := state;
    checkOrInsert(state);
    while tail <> head do
    begin
        head := nextIndex(head);
        for dir := 1 to 4 do
        begin
            st := q[head];
            if not move(st, dir) then continue;
            if st.depth > 940 then continue;
            if IsTarget(st) then exit(st.depth);
            if not checkOrInsert(st) then continue;
            tail := nextIndex(tail);
            q[tail] := st;
        end;
    end;
    exit(-1);
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    while not eof do
    begin
        readln(sx, sy);
        if sx = 0 then break;
        state := initialState;
        state.x := sx;
        state.y := sy;
        state.code[makePos(sx, sy)] := 0;
        fillchar(target, sizeof(target), 0);

        for i := 1 to 9 do
        begin
            read(ch);
            case ch of
                'W': target[i] := 1;
                'B': target[i] := 2;
                'R': target[i] := 3;
                'E': target[i] := 0;
            end;
            read(ch);
            if i mod 3 = 0 then readln;
        end;
        writeln(bfs);
    end;

    close(input); close(output);
end.

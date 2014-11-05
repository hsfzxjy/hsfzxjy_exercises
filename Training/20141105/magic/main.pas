type
    sss = set of 1..100;
    TMap = array [1..4, 1..4] of integer;

var
    map: TMap;
    x, y: longint;
    row, col, rc, cc: array [1..4] of longint;
    sq, sqn: array [1..4] of longint;
    xie, xien: array [1..2] of longint;
    mid, midn: longint;

function calc(x, y: integer): integer;
begin
    if (x<=2) then calc := 1 else calc := 3;
    if (y>2) then inc(calc);
end;

procedure print;
var
    i, j: longint;
begin
    for i := 1 to 4 do
    begin
        for j := 1 to 3 do write(map[i, j], ' ');
        writeln(map[i, 4]);
    end;
end;

procedure search(x, y: longint; t: longint; status: sss);
var
    i, j, k: longint;
begin
    if t = 15 then
        writeln;
    if t = 17 then
    begin
        print;
        exit;
    end;
    i := x; j := y;
    if map[x, y] <> 0 then
    begin
        search(i+(j>>2), (j) mod 4+1, t+1, status-[map[x, y]]);
        exit;
    end;
    k := 0;

    if (cc[i] = 3) and (rc[j] = 3) then
    begin
        if (col[i]<>row[j]) then exit
        else if not ((34 - col[i]) in status) then exit
        else
        begin
            k := 34-col[i];
        end;
    end
    else if cc[i] = 3 then
    begin
        if (34-col[i]>0) and ((34-col[i]) in status) then
            k := 34-col[i]
        else
            exit;
    end
    else if rc[j] = 3 then
    begin
        if (34-row[j]>0) and ((34-row[j]) in status) then
            k := 34 - row[j]
        else
            exit;
    end
    else if sqn[calc(i, j)] = 3 then
    begin
        if (34-sq[calc(i, j)]>0) and ((34-sq[calc(i,j)]) in status) then
        begin
            k := 34 - sq[calc(i, j)]
        end
        else exit;
    end
    else if (i = j) and (xie)
    if k <> 0 then
    begin
        col[i] := col[i] + k;
        row[j] := row[j] + k;
        map[i][j] := k;
        inc(cc[i]);  inc(rc[j]);
        search(i+(j>>2), j mod 4+1, t+1, status-[k]);
        col[i] := col[i] - k;
        row[j] := row[j] - k;
        map[i][j] := 0;
        dec(cc[i]); dec(rc[j]);
        exit;
    end;

    for k := 1 to 16 do
        if k in status then
        begin
            if (col[i]+k>34) or (row[j]+k>34) then continue;
            col[i] := col[i] + k;
            row[j] := row[j] + k;
            map[i][j] := k;
            inc(cc[i]);  inc(rc[j]);
            search(i+(j>>2), (j) mod 4+1, t+1, status-[k]);
            map[i][j] := 0;
            col[i] := col[i] - k;
            row[j] := row[j] - k;
            dec(cc[i]); dec(rc[j]);
        end;

{   if t = 16 then begin print; exit; end;
    for i := 1 to 4 do
        for j := 1 to 4 do
        begin
            k := 0;
            if map[i, j] <> 0 then continue;
            if (cc[i] = 3) and (rc[j] = 3) then
            begin
                if (col[i]<>row[j]) then exit
                else if not ((34 - col[i]) in status) then exit
                else
                begin
                    k := 34-col[i];
                end;
            end
            else if cc[i] = 3 then
            begin
                if (34-col[i]>0) and ((34-col[i]) in status) then
                    k := 34-col[i]
                else
                    exit;
            end
            else if rc[j] = 3 then
            begin
                if (34-row[j]>0) and ((34-row[j]) in status) then
                    k := 34 - row[j]
                else
                    exit;
            end;
            if k <> 0 then
            begin
                col[i] := col[i] + k;
                row[j] := row[j] + k;
                map[i][j] := k;
                inc(cc[i]);  inc(rc[j]);
                search(t+1, status-[k]);
                col[i] := col[i] - k;
                row[j] := row[j] - k;
                map[i][j] := 0;
                dec(cc[i]); dec(rc[j]);
                continue;
            end;

            for k := 1 to 16 do
                if k in status then
                begin
                    if (col[i]+k>34) or (row[j]+k>34) then continue;
                    col[i] := col[i] + k;
                    row[j] := row[j] + k;
                    map[i][j] := k;
                    inc(cc[i]);  inc(rc[j]);
                    search(t+1, status-[k]);
                    map[i][j] := 0;
                    col[i] := col[i] - k;
                    row[j] := row[j] - k;
                    dec(cc[i]); dec(rc[j]);
                end;
        end;}
end;

begin
    assign(input, 'magic.in'); reset(input);
    assign(output, 'magic.out'); rewrite(output);

    read(x, y);
    map[x, y] := 1;
    col[x] := 1;
    cc[x] := 1;
    row[y] := 1;
    rc[y] := 1;
    sqn[calc(x, y)] := 1;
    sq[calc(x, y)] := 1;

    search(1, 1, 1, [2..16]);

    close(input); close(output);
end.

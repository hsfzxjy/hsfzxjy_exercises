type
    PRec1 = ^TRec1;
    TRec1 = record
        height : longint;
        index: longint;
        next, prev: PRec1;
    end;

    TRec2 = record
        height : longint;
        index: longint;
    end;

operator <(x, y: TRec2)res: Boolean;
begin
    res := x.height<y.height;
end;

var
    h: array [1..100000] of TRec2;
    n: longint;

procedure sort(l, r: longint);
var
    i, j: longint;
    m, t: TRec2;
begin
    i := l; j := r; m := h[(i+j) >> 1];
    repeat
        while h[i]<m do inc(i);
        while m<h[j] do dec(j);
        if i<=j then
        begin
            t := h[i]; h[i] := h[j]; h[j] := t;
            inc(i); dec(j);
        end;
    until i>j;
    if i<r then sort(i, r);
    if l<j then sort(l, j);
end;

procedure build;
var
    p, q: PRec1;
    i: longint;
begin
    sort(1, n);
    new(head);
    fillchar(head^, sizeof(head^), 0);
    head^.height := h[1].height;
    head^.index := h[1].index;
    p := head;
    for i := 2 to n do 
    begin
        new(q);
        fillchar(q^, sizeof(q^), 0);
        q^.height := h[i].height;
        q^.index := h[i].index;
        p^.next := q;
        q^.prev := p;
        p := q;
    end;
end;

type
    TRec3 = record
        index: Longint;
        dis: longint;
    end;

var
    A, B: array [1..100000, 0..17] of TRec3;

procedure fuzhi(var r: TRec3; p: PRec1; h: longint);
begin
    if p = nil then exit;
    r.index := p^.index;
    r.dis := abs(h-p^.height);
end;

procedure process;
var
    p, q, r, r1, r2: PRec1;
    tx, ty: longint;
begin
    build;
    p := head;
    while p<>nil do 
    begin
        if p^.index = n then
        begin
            p := p^.next;
            continue;
        end;

        q := p^.prev;
        r := p^.next;
        while (q<>nil) and (q^.index<p^.index) do q := q^.prev;
        while (r<>nil) and (r^.index<p^.index) do r := r^.next;
        if (q = nil) and (r<>nil) then
        begin
            q := r;
            r := q^.next;
            while (r<>nil) and (r^.index<p^.index) do r := r^.next;
        end;
        if (r = nil) and (q<>nil) then
        begin
            r := q;
            q := r^.prev;
            while (q<>nil) and (q^.index<p^.index) do q := q^.prev;
        end;

        if (q<>nil) and (r = nil) then
        begin
            fuzhi(B[p^.index][0], q, p^.height);
            while (q<>nil) and (q^.index<p^.index) do q := q^.prev;
            fuzhi(A[p^.index][0], q, p^.height);
        end
        else if (q = nil) and (r<>nil) then
        begin
            fuzhi(B[p^.index][0], r, p^.height);
            while (r<>nil) and (r^.index<r^.index) do r := r^.next;
            fuzhi(A[p^.index][0], r, p^.height);
        end
        else if (q<>nil) and (r<>nil) then
        begin
            tx := abs(q^.height-p^.height);
            ty := abs(q^.height-p^.height);
            if tx<=ty then
            begin
                fuzhi(B[p^.index][0], q, p^.height);
                r1 := q^.prev;
                //r2 := r^.next;
                while (r1<>nil) and (r1^.index<p^.index) do r1 := r1^.prev;
                //while (r2<>nil) and (r2^.index<p^.index) do r2 := r2^.prev;
                if (r1 <> nil) and (p^.height-r1^.height<=ty) then
                begin
                    fuzhi(A[p^.index][0], r1, p^.height);
                end
                else
                begin
                    fuzhi(A[p^.index][0], r, p^.height);
                end;
            end
            else if tx>ty then
            begin
                fuzhi(B[p^.index][0], r, p^.height);
                r1 := q^.prev;
                r2 := r^.next;
                while (r1<>nil) and (r1^.index<p^.index) do r1 := r1^.prev;
                while (r2<>nil) and (r2^.index<p^.index) do r2 := r2^.prev;
                if ()
            end;

        end;

        p := p^.next;
    end;
end;
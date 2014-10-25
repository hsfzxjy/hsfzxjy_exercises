const
    JINDU = 100000;
type
    Rec = record
        left, right, mul: longint;
    end;
    BigNum = record
        digits: array [1..10000] of longint;
        len: longint;
    end;
var
    a: array [1..1000] of Rec;
    tmp, ans, min: BigNum;

function compare(x, y: rec): longint;
begin
    if x.mul <> y.mul then
        exit(x.mul - y.mul);
    exit(y.right - x.right);
    exit(0);
end;

procedure sort(l, r: longint);
var
    i, j: Integer;
    t, m: rec;
begin
    i := l;
    j := r;
    m := a[(i + j) shr 1];
    repeat
        while compare(a[i], m) < 0 do inc(i);
        while compare(a[j], m) > 0 do dec(j);
        if i <= j then
        begin
            t := a[i];
            a[i] := a[j];
            a[j] := t;
            inc(i);
            dec(j);
        end;
    until i > j;

    if i < r then sort(i, r);
    if l < j then sort(l, j);
end;

procedure multiply(var ans: Bignum; num: longint);
var
    i, x, t: longint;
begin
    i := 1;
    x := 0;
    while i <= ans.len do
    begin
        t := (ans.digits[i] * num + x);
        ans.digits[i] := t mod JINDU;
        x := t div JINDU;
        inc(I);
    end;
    if x > 0 then
    begin
        inc(ans.len);
        ans.digits[ans.len] := x;
    end;
end;

procedure divide(var ans: bignum;num: longint);
var
    i, t, x: longint;
begin
    i := ans.len; x:= 0;
    while i > 0 do
    begin
        t := x * JINDU + ans.digits[i];
        ans.digits[i] := t div num;
        x := t mod num;
        dec(i);
    end;
    while (ans.len > 1) and (ans.digits[ans.len] = 0) do dec(ans.len);
end;

procedure printANumber(x: longint);
var
    t, tt: longint;
begin
    if x = 0 then
    begin
        write('00000');
        exit;
    end;
    t := JINDU; tt := x * 10;
    while t > tt do
    begin
        write(0);
        t := t div 10;
    end;
    write(x);
end;

procedure cmp;
var
    i: Integer;
begin
    if (min.len = 0) or (min.len < ans.len) then
    begin
        min := ans;
        exit;
    end;
    if min.len > ans.len then exit;
    i := min.len;
    while (i > 0) do
    begin
        if min.digits[i] > ans.digits[i] then
            exit;
        if min.digits[i] < ans.digits[i] then
        begin
            min := ans;
            exit;
        end;
    end;
end;

var
    n, i: Integer;
    x, y: longint;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(n);
    readln(x, y);
    for i := 1 to n do
    begin
        readln(a[i].left, a[i].right);
        a[i].mul := a[i].left * a[i].right;
    end;

    sort(1, n);
    ans.digits[1] := x;
    ans.len :=1;
    for i := 1 to n do
    begin
        if i = n then break;
        multiply(ans, a[i].left);
    end;
    divide(ans, a[n].right);
    cmp;
    write(min.digits[min.len]);
    for i := min.len-1 downto 1 do printANumber(min.digits[i]);
    writeln;

    close(input); close(output);
end.

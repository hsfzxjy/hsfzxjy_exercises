const
  JINDU = 100000;
type
  BigNum = record
    a: array [1..10000] of int64;
    len: longint;
    fu: boolean;
  end;

procedure trans(var n: BigNum; s: AnsiString);
var
  i,j,k,x,l,ed,t: longint;
begin
  fillchar(n, sizeof(n),0);
  ed := 1;
  while (('0'>s[ed]) or ('9'<s[ed])) and (s[ed]<>'-') do inc(ed);
  if s[ed]='-' then
  begin
    n.fu := True;
    inc(ed);
  end;
  l := Length(s);
  while ('0'>s[l]) or ('9'<s[l]) do dec(l);
  i := l;
  n.len := 1;
  t := 1;
  while i>=ed do
  begin
    n.a[n.len] := n.a[n.len]+(ord(s[i])-ord('0'))*t;
    t := t*10;
    x := n.a[n.len] div JINDU;
    n.a[n.len] := n.a[n.len] mod JINDU;
    if (x>0) or (t=JINDU) then
    begin
      inc(n.len);
      n.a[n.len]:=x;
      if x<>0 then t := 10 else t := 1;
    end;
    dec(i);
  end;
end;

function max(x,y: longint): longint;
begin
  if x>y then exit(x) else exit(Y);
end;

function AbsGreater(a,b: bignum): longint;
var
  i: longint;
begin
  if a.len<>b.len then exit(a.len-b.len);
  i := a.len;
  while (i>=1) and (a.a[i]=b.a[i]) do dec(i);
  if (i=0) then exit(0);
  exit(a.a[i]-b.a[i]);
end;

procedure _Minus(var a: BigNum; b: BigNum); //a>b
var
  i,l: longint;
  x: int64;
begin
  l := a.len; i := 1; x:=0;
  while i<=l do
  begin
    a.a[i] := a.a[i]-b.a[i]+x;
    if a.a[i]<0 then
    begin
      x := -1;
      a.a[i] := a.a[i]+JINDU;
    end;
    inc(i);
  end;
  while (a.len>1) and (a.a[a.len]=0) do dec(a.len);
end;

procedure _Add(var a: BigNum; b: BigNum);
var
  l,i: longint;
  x: int64;
begin
  l := max(a.len, b.len); x:=0; i:=1;
  while i<=l do
  begin
    a.a[i] := a.a[i]+b.a[i]+x;
    x := a.a[i] div JINDU;
    a.a[i] := a.a[i] mod JINDU;
    inc(i);
  end;
  while x<>0 do
  begin
    inc(a.len);
    a.a[a.len] := x mod JINDU;
    x := x div JINDU;
  end;
end;

procedure swap(var a,b: BigNum);
var
  t: bignum;
begin
  t := a; a:=b; b:=t;
end;

procedure add(var a: BigNum; b: BigNum);
var
  g: longint;
  fu: boolean;
begin
  g := AbsGreater(a,b);
  if a.fu<>b.fu then
  begin
    if g=0 then
    begin
      a.fu := False;
      a.len:=1;
      a.a[1]:=0;
      exit;
    end;
    fu := a.fu;
    if g<0 then
    begin
      swap(a,b);
      _Minus(a,b);
      a.fu := not fu;
    end
    else _Minus(a,b);
  end
  else
  begin
    _Add(a,b);
  end;
end;

procedure Mul(var a: BigNum; b: longint);
var
  i: longint;
  x: int64;
begin
  i := 1; x:=0;
  while i<=a.len do
  begin
    a.a[i] := a.a[i] * b + x;
    x := a.a[i] div JINDU;
    a.a[i] := a.a[i] mod JINDU;
    inc(i);
  end;
  while x<>0 do
  begin
    inc(a.len);
    a.a[a.len] := x mod JINDU;
    x := x div JINDU;
  end;
end;

function Can(a: Bignum; n: longint): boolean;
var
  i: longint;
  x,y: int64;
begin
  i := a.len; x:=0;
  while i>=1 do
  begin
    y := (x*JINDU+a.a[i]);
    x := y mod n;
    dec(i);
  end;
  exit(x=0);
end;

var
  n,m,i,sn: longint;
  xi: array [0..104] of BigNum;
  s: Ansistring;
  ans: array [1..104] of longint;
  cnt: longint;

function print(a: BigNum): boolean;
var
  i,x:longint;
begin
  if a.fu then write('-');
  write(a.a[a.len]);
  for i := a.len-1 downto 1 do
  begin
    x := JINDU;
    while x>a.a[i]*10 do
    begin
      write(0);
      x := x div 10;
    end;
    write(a.a[i]);
  end;
  writeln;
end;

function f(x: longint): boolean;
var
  i: longint;
  fx: BigNum;
begin
  fx := xi[n];
  for i := n-1 downto sn do
  begin
    Mul(fx,x);
    Add(fx,xi[i]);
  end;

  exit((fx.len=1) and (fx.a[1]=0));
end;
var
  ok: array [1..1000000] of boolean;
  b: boolean;
  j: longint;
begin
  assign(input, 'equation.in');reset(input);
  assign(output,'equation.out');rewrite(output);
  readln(n,m);
  for i := 0 to n do
  begin
    readln(s);
    trans(xi[i],s);
  end;
  cnt := 0;
  sn := 0;
  while (sn<n) and (xi[sn].len=1) and (xi[sn].a[1]=0) do inc(sn);
  fillchar(ok, sizeof(ok),True);
  for i := 1 to m do
  begin
    if not ok[i] then continue;
    b := Can(xi[sn],i);
    if not b then
    begin
      j := i;
      while j<=m do
      begin
        ok[j]:=False;
        j:=j+i;
      end;
      continue;
    end;
    if F(i) then
    begin
      inc(cnt);
      ans[cnt] := i;
      if cnt = n then break;
    end;
  end;
  writeln(cnt);
  for i := 1 to cnt do writeln(ans[i]);
  close(input);close(output);
end.

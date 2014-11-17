//Line 12: declaration of `map`--Out Of Memory (Test in luogu, scored 25)


type
  TWire = record
    x, up, down: longint;
  end;

var
  wires: array [1..10000] of TWire;
  delta: array [0..10000,1..2] of longint;
  map: array [0..10000, 0..1000] of longint;
  k,m,n,i: longint;

procedure sort(l,r: longint);
var
  i,j: longint;
  m,t: TWire;
begin
  i := l; j:=r; m:=wires[(i+j) shr 1];
  repeat
    while wires[i].x<m.x do inc(i);
    while wires[j].x>m.x do dec(j);
    if i<=j then
    begin
      t:=wires[i];
      wires[i]:=wires[j];
      wires[j]:=t;
      inc(i); dec(j);
    end;
  until i>j;
  if i<r then sort(i,r);
  if l<j then sort(l,j);
end;

var
  cur: longint;
  click, min,max: longint;
  ok: boolean;
  ans: array [0..10000] of longint;

procedure print;
var
  i: longint;
begin
  write(min,': ');
  for i := 0 to n do write(ans[i],' ');
  writeln;
end;

procedure find(x,y: longint);
var
  t,i,tc: longint;
begin
  ans[x]:=y;
  if map[x][y]>click then map[x][y]:=click;
  if (cur<=k) and (wires[cur].x = x) then
  begin
    if max<cur then max := cur;
    if ((wires[cur].up<=y) or (wires[cur].down>=y)) then
      exit
    else
      inc(cur);
  end;
  if x = n then
  begin
    ok := True;
    if min>click then
    begin
      min:=click;
    end;
    exit;
  end;
  if (y>delta[x][2]) and (map[x][y]<map[x+1][y-delta[x][2]]) then
    find(x+1, y-delta[x][2]);
  t := click;
  tc:=cur;
  repeat
    y := y+delta[x][1];
    if y>m then y := m;
    inc(click);
    if map[x+1][y]<click then continue;
    find(x+1,y);
  until y=m;
  cur:=tc;
  click := t;
end;

begin
  assign(input, 'bird.in'); reset(input);
  assign(output,'bird.out');rewrite(output);

  read(n,m,k);
  for i := 0 to n-1 do read(delta[i][1], delta[i][2]);
  for i := 1 to k do
    with wires[i] do
    begin
      read(x, down, up);
    end;
  if k<>0 then sort(1,k);
  min := maxlongint; click := 0; cur:=1; ok := False;
  filldword(map, sizeof(map) shr 2, maxlongint);
  for i := 1 to m do
  begin
    find(0,i);
    cur:=1;
  end;
  if not ok then
  begin
    writeln(0);
    writeln(max-1);
  end else begin
    writeln(1);
    writeln(min);
  end;


  close(input);close(output);
end.

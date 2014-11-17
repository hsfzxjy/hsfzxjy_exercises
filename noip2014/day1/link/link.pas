// Line 96: It's not necessary for the max value to mod 10007!!! What the fucking shit!!!!

const
  MAXN = 200000+10;
  MODN = 10007;
type
  TEdge = record
    y, next: longint;
  end;
var
  w: array [0..MAXN] of longint;
  head, father, depth: array [0..MAXN] of longint;
  edges: array [0..2*MAXN] of TEdge;
  en: longint;
  n,i,j,x,y: longint;

procedure addedge(x,y: longint);
begin
  inc(en);
  edges[en].next:=head[x];
  edges[en].y:=y;
  head[x]:=en;
  inc(en);
  edges[en].next:=head[y];
  edges[en].y:=x;
  head[y]:=en;
end;
var
  max, tot: longint;

procedure add(x,y: longint);
var
  t: longint;
begin
  t := w[x] * w[y];
  if t>max then max := t;
  tot := (tot+t mod MODN) mod MODN;
end;
procedure dfs(x: longint);
var
  i,j: longint;
  t,m,tm,ww: longint;
begin
  depth[x] := depth[father[x]]+1;
  if depth[x]>2 then
  begin
    add(x, father[father[x]]);
  end;
  i := head[x];
  t:=0; m:=0;
  while i<>0 do
  begin
    if edges[i].y<>father[x] then
    begin
      j := edges[i].y;
      tot := (tot + w[j]*t) mod MODN;
      t := (t+w[j]) mod MODN;
      tm := w[j] * m;
      if max<tm then max:=tm;
      if w[j]>m then m := w[j];
      father[edges[i].y]:=x;
      dfs(edges[i].y);
    end;
    i := edges[i].next;
  end;
  {i := head[x];
  while i<>0 do
  begin
    j := head[x];
    while j<>0 do
    begin
      if (i<>j) and (edges[i].y<>father[x])
        and (edges[j].y<>father[x]) then add(edges[i].y,edges[j].y);
      j := edges[j].next;
    end;
    i := edges[i].next;
  end;      }
end;

begin
  assign(input, 'link.in');reset(input);
  assign(output,'link.out');rewrite(output);

  fillchar(edges, sizeof(edges),0);
  en:=0;
  read(n);
  for i := 1 to n-1 do
  begin
    read(x,y);
    addedge(x,y);
  end;
  for i := 1 to n do
    read(w[i]);
  father[1]:=0;
  dfs(1);
  writeln(max, ' ', tot * 2 mod MODN);
  close(input);close(output);
end.

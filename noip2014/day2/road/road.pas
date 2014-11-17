//思路完全错误

const
  QN = 100000;
type
  TEdge = record
    y,next: longint;
  end;

var
  edges: array [1..200005] of TEdge;
  head: array [1..10005] of longint;
  visited,ok,getto: array [1..10005] of boolean;
  tot, i,j,x,y,n,m,st,ed: longint;

//Wrong
{
procedure addedge(x,y: longint);
begin
  if x=y then exit;
  inc(tot);
  edges[tot].y:=y;
  edges[tot].next := head[x];
  head[x] := tot;
end;
}

procedure addedge(x, y: longint);
begin
  inc(tot);
  edges[tot].y:=x;
  edges[tot].next:=head[y];
  head[y]:=tot;
end;
procedure dfs(x: longint);
var
  i,j: longint;
  b,g: boolean;
begin
  visited[x] := True;
  b := True;
  g := False;
  if head[x] = 0 then
  begin
    ok[x] := x = ed;
    getto[x] := x = ed;
    exit;
  end;
  i := head[x];
  while i<>0 do
  begin
    j := edges[i].y;
    if (x<>j) and not visited[j] then
    begin
      if not visited[j] then dfs(j);
      g := g or getto[j];
      b := b and getto[j];
    end;
    i := edges[i].next;
  end;
  ok[x] := b;
  getto[x] := g;
end;

var
  q: array [1..QN] of longint;
  h,t: longint;
  inq: array [1..10005] of boolean;
  d: array [1..10005] of longint;
function next(x: longint): longint;
begin
  next := x mod QN +1;
end;

function spfa: longint;
var
  i,j,x,k: longint;
begin
  fillchar(inq, sizeof(inq),0);
  filldword(d, sizeof(d) shr 2, maxlongint);
  h := 0; t := 1; q[1] := st; inq[st] := True; d[st] := 0;
  while t<>h do
  begin
    h := next(h);
    x := q[h];
    i := head[x];
    inq[x] := False;
    while i<>0 do
    begin
      j := edges[i].y;
      if (d[j]>d[x]+1) then
      begin
        d[j] := d[x]+1;
        if not inq[j] then
        begin
          t := next(t);
          q[t] := j;
          inq[j] := True;
        end;
      end;
      i := edges[i].next;
    end;
  end;
  if d[ed] = maxlongint then d[ed] := -1;
  spfa := d[ed];
end;
begin
  assign(input,'road.in');reset(input);
  assign(output,'road.out');rewrite(output);
  read(n,m); tot := 0;
  for i := 1 to m do
  begin
    read(x,y);
    addedge(x,y);
  end;
  //read(st,ed);
  read(ed, st);
  fillchar(visited, sizeof(visited),0);
  fillchar(ok, sizeof(ok),0);
  fillchar(getto, sizeof(getto),0);
  //dfs(st);
  //if not getto[st] then
  //  writeln(-1)
  //else
    writeln(spfa);
  close(input);close(output);
end.

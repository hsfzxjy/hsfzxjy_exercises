const
  QN = 100000;
type
  TEdge = record
    y,next: longint;
  end;

var
  edges: array [1..200005] of TEdge;
  head,cnt: array [1..10005] of longint;
  visited: array [1..10005] of boolean;
  tot, i,j,x,y,n,m,st,ed: longint;

procedure addedge(x,y: longint);
begin
  if x=y then exit;
  inc(tot);
  edges[tot].y:=y;
  edges[tot].next := head[x];
  head[x] := tot;
  inc(cnt[y]);
end;

procedure dfs(x: longint);
var
    i,j: longint;
begin
    visited[x] := True;
    i := head[x];
    while i<>0 do
    begin
        j := edges[i].y;
        dec(cnt[j]);
        if (x<>j) and not visited[j] then dfs(j);
        i := edges[i].next;
    end;
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
      if (cnt[j]=0) and (d[j]>d[x]+1) then
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
    addedge(y,x);
  end;
  //read(st,ed);
  read(ed, st);
  fillchar(visited, sizeof(visited),0);
  //fillchar(cnt, sizeof(cnt), 0);
  dfs(st);
  if not visited[ed] then
    writeln(-1)
  else
    writeln(spfa);
  close(input);close(output);
end.

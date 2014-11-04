program ser;
{ This program for every server A computes the number of servers server 
A is interesting to, let us denote this set C(A). . 
The set C(A) is computed using Dijkstra algorithm. Notice that the set 
C(A) is a star set, and is closed under taking elements with smaller distance.
We can stop Dijkstra when we reach an element that not belongs to C(A). 
An element X does not belong to C(A) if ther exist a server with higher rank
that A, that is nearer. In Dijkstra we know distance from A to X, so we  
nead to compute for every server a distance to a nearest server with at 
least rank r for every r. These distances can be computed by runing 
Dijkstra 9 times, in every time starting from servers with ranks greater
then some r, 1<=r<10.}
 
const
  MAXN = 100000;
  MAXD = 1000 * MAXN + 1;
  MAXSUMMUL = 30;
type
  inheapt = record
    nr : longint;
    key : longint;
  end;

  connt = record
    nr : longint;
    t : longint;
  end;
var
  // The heap.
  inheap : array[1..MAXN] of inheapt;
  heap: array[1..MAXN] of longint;
  heapn : longint;

  // Here we remember visited servers
  visited : array[1..MAXN] of longint;

  // connections betwen servers
  connn : array[1..MAXN] of longint;
  conn: array[1..MAXN,1..10] of connt;

  rank : array[1..MAXN] of longint;

  // distance to nearest server with rank at least k, where k is second index
  nearestr : array[1..MAXN,1..10] of longint;
  
  n, m, r: longint;
  // num - here we count servers
  num : longint;

// Init heap
procedure makeemptyheap(n:longint);
var
  i : longint;
begin
  for i := 1 to n do
  begin
    heap[i] := i;
    inheap[i].nr := i;
    inheap[i].key := MAXD;
  end;
  heapn := n;
end;

// repair heap upwords
procedure up(i:longint);
var
  t : longint;
begin
    while (i<>1) and (inheap[heap[i]].key < inheap[heap[i shr 1]].key) do
    begin
      t := heap[i];
      heap[i] := heap[i shr 1];
      heap[i shr 1] := t;
      inheap[heap[i shr 1]].nr := i shr 1;
      inheap[heap[i]].nr := i;
      i := i shr 1;
    end;
end;

// decrease a key in the heap
procedure decreasekey(nr : longint; dk : longint);
begin
  if dk < inheap[nr].key then
  begin
    inheap[nr].key := dk;
    up(inheap[nr].nr);
  end;
end;

// insert an element into heaop
procedure insert(nr : longint; key : longint);
begin
  inc(heapn);
  heap[heapn] := nr;
  inheap[nr].nr := heapn;
  inheap[nr].key := key;
  up(heapn);
end;

// extracts minimal element from the heap
procedure extractmin(var el:longint; var key : longint);
var
  i, t, l, r: longint;
  smallest: longint;
begin
  el := heap[1];
  key := inheap[heap[1]].key;
  heap[1] := heap[heapn];
  inheap[heap[1]].nr := 1;
  dec(heapn);

  smallest := 1;
  repeat
    i := smallest;
    l := 2*i;
    r := 2*i + 1;
    if (l<=heapn) and (inheap[heap[l]].key < inheap[heap[i]].key) then
       smallest := l
    else
       smallest := i;
    if (r<=heapn) and (inheap[heap[r]].key < inheap[heap[smallest]].key) then
       smallest := r;
    if smallest <> i then
    begin
      t := heap[i];
      heap[i] := heap[smallest];
      heap[smallest] := t;
      inheap[heap[i]].nr := i;
      inheap[heap[smallest]].nr := smallest;
    end;
  until smallest = i;
end;


procedure inc_num(a : longint);
begin
  inc(num, a);
  if (num > MAXSUMMUL*n) then begin
    writeln('Total sum too big: ', num);
    halt(1);
  end
end; 

// connect two servers
procedure connect(a,b,t:longint);
begin
  inc(connn[a]);
  conn[a,connn[a]].nr := b;
  conn[a,connn[a]].t := t;
end;

// This procedure computes the nearest servers with rank greater then rr.

procedure computenearest;
var
  rr,i,j,key : longint;
begin
  for rr := 1 to 9 do
  begin
    makeemptyheap(n);
    for i := 1 to n do
      if rank[i] > rr then
      begin
        decreasekey(i,0);
      end;
    while heapn > 0 do
    begin
      extractmin(i,key);
      nearestr[i,rr] := key;
      for j := 1 to connn[i] do
      begin
        decreasekey(conn[i,j].nr, key + conn[i,j].t );
      end;
    end;
  end;
end;

// computes the size of a set C(nr)

procedure reaches(nr: longint);
var
  i, j : longint;
  key : longint;
  ar : longint;
begin
  heapn := 0;
  ar := rank[nr];
  if ar = r then
    inc_num(n)
  else
  begin
    insert(nr,0);
    visited[nr]:=nr;
    while (heapn > 0) do
    begin
      extractmin(i,key);
      if key < nearestr[i,ar] then
      begin
        inc_num(1);
        for j := 1 to connn[i] do
        begin
          if visited[conn[i,j].nr] <> nr then
          begin
            insert(conn[i,j].nr, key + conn[i,j].t );
            visited[conn[i,j].nr] := nr;
          end
          else
            decreasekey(conn[i,j].nr, key + conn[i,j].t );
        end;
      end;
    end;
  end;
end;


var
  i : longint;
  a,b,t : longint;
begin
    assign(input, 'servers.in'); reset(input);
    assign(output, 'servers.out'); rewrite(output);
    
  num := 0;
  readln(n,m);
  r := 0;
  for i := 1 to n do
  begin
    readln(rank[i]);
    if r < rank[i]
      then r := rank[i];
  end;
  for i := 1 to m do
  begin
    readln(a,b,t);
    connect(a,b,t);
    connect(b,a,t);
  end;

  computenearest;

  for i := 1 to n do
  begin
    reaches(i);
  end;
  writeln(num);

    close(input); close(output);
end.

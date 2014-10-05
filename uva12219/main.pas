const
  maxn = 20000;
type
  NodeRec = record
    Value: string;
    l, r, index: longint;
  end;
  Node = record
     left, right: longint;   //Index of left and right child in the `tree` array, -1 for none.
     Rec: NodeRec;
     index: longint;
  end;

  _PNode = ^_Node;
  _Node = record
    n: Node;
    next: _PNode;
  end;

  HashTable = object
    arr: array [0..maxn] of _PNode;
    function hash(n: NodeRec): longint;
    procedure add(n: Node);
    procedure clear;
    function find(n: NodeRec): longint;
  end;

procedure HashTable.clear;
var
  i: longint;
  p, q: _PNode;
begin
  for i := 0 to maxn do
  begin
    p := arr[i];
    while p<>nil do
    begin
      q := p^.next;
      dispose(p);
      p := q;
    end;
  end;
  fillchar(arr, sizeof(arr),0);
end;

function cmp(r1, r2: NodeRec): Boolean;
begin
  cmp := (r1.l = r2.l) and (r1.r = r2.r) and (r1.Value = r2.Value);
end;

function HashTable.hash(n: NodeRec): longint;
var
  i: longint;
begin
  hash := 0;
  for i := 1 to length(n.Value) do
    hash := (hash*5 + ord(n.Value[i]) - ord('a')) mod maxn;
  hash := (hash + n.l * 10 + n.r * 5) mod maxn;
end;

procedure HashTable.add(n: Node);
var
  h: longint;
  p, q: _PNode;
begin
  h := hash(n.rec);
  new(q);
  fillchar(q^, sizeof(_Node), 0);
  q^.next := arr[h];
  q^.n := n;
  arr[h] := q;
end;

function HashTable.find(n: NodeRec): longint;
var
  p: _PNode;
begin
  find := -1;
  p := arr[hash(n)];
  while (p<>nil) and not cmp(n, p^.n.rec) do p := p^.next;
  if p <> nil then
    find := p^.n.index;
end;

var
  inputs: Ansistring;
  _: longint;
  tree: array [1..50001] of Node;
  cur: longint;              //The current pointer of the input string.
  num: longint;              //The current number of the `tree` array.
  ls: longint;
  t: longint;
  tot: longint;
  ht: HashTable;

function build: longint;
label lb;
var
  rec: NodeRec;
  i,j,l,r: longint;
begin
  l := 0;
  r := 0;
  fillchar(rec, sizeof(rec), 0);
  inc(tot);
  rec.index := tot;
  while (cur<=ls) and (inputs[cur] in ['a'..'z']) do
  begin
    rec.Value := rec.Value+inputs[cur];
    inc(cur);
  end;
  if cur>ls then goto lb;
  if inputs[cur] = '(' then
  begin
    inc(cur);
    l := build();
    rec.l := tree[l].rec.index;
    inc(cur);
    r := build();
    rec.r := tree[r].rec.index;
    inc(cur);
  end;
  j := ht.find(rec);
  if j>0 then
  begin
    dec(tot);
    exit(j);
  end
  else
  begin
lb:
    inc(num);
    tree[num].left := l;
    tree[num].right := r;
    tree[num].rec := rec;
    tree[num].index := num;
    ht.add(tree[num]);
    exit(num);
  end;
end;

function max(x, y: longint): longint; inline;
begin
  if x>y then exit(x) else exit(y);
end;

procedure print(n: longint);
begin
  if tree[n].rec.index > t then
  begin
    write(tree[n].rec.Value);
    t := tree[n].rec.index;
  end
  else
  begin
    write(tree[n].rec.index);
    exit;
  end;
  if tree[n].right = 0 then
    exit;
  write('(');
  print(tree[n].left);
  write(',');
  print(tree[n].right);
  write(')');
end;
begin
  assign(input, 'main.in'); reset(input);
  assign(output, 'main.out'); rewrite(output);
  readln(_);
  fillchar(ht.arr, sizeof(ht.arr),0);
  while _>0 do
  begin
    dec(_);
    readln(inputs);
    fillchar(tree, sizeof(tree), 0);
    ht.clear;
    ls := length(inputs);
    cur := 1;  num := 0; tot := 0;
    build;
    t := 0;
    print(num);
    writeln;
  end;
  close(input); close(output);
end.

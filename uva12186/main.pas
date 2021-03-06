//Accepted
var
    tree: array [0..100000] of array of int64;
    T: Integer;
    f: array [0..100000] of int64;
    i,j,k,l,m,n,x:longint;

function min(x,y: int64): int64;
begin
    if x<y then exit(x) else exit(y);
end;

procedure sort(var arr: array of int64;l,r:longint); overload;
var
  i,j:longint;
  m,t: int64;
begin
  i := l;
  j := r;
  m := arr[(l+r) >> 1];
  repeat
    while arr[i]<m do inc(i);
    while arr[j]>m do dec(j);
    if i<=j then
    begin
      t := arr[i];
      arr[i] := arr[j];
      arr[j] := t;
      inc(i);
      dec(j);
    end;
  until i>j;
  if i<r then sort(arr, i, r);
  if l<j then sort(arr, l, j);
end;

procedure sort(var arr: array of int64); overload;
begin
  sort(arr, low(arr), high(arr));
end;
function dp(x: longint): int64;
var
  arr: array of int64;
  l,i, num: longint;
begin
    if f[x] <> 0 then
    begin
        dp := f[x];
        exit;
    end;
    if length(tree[x]) = 0 then
    begin
      dp := 1;
      f[x] := 1;
      exit;
    end;
    l := length(tree[x]);
    SetLength(arr, l);
    for i := Low(tree[x]) to High(Tree[x]) do
      arr[i] := dp(tree[x][i]);
    Sort(arr);
    num := (l*T-1) div 100+1;
    for i := Low(arr) to num-1 do
      f[x] := f[x] + arr[i];
    dp := f[x];
end;

begin
    assign(input, 'main.in');reset(input);
    assign(output,'main.out');rewrite(output);
    readln(n, T);
    while n>0 do
    begin
        fillchar(f, sizeof(f), 0);
        fillchar(tree, sizeof(tree), 0);
        for i := 1 to n do
        begin
            read(x);
            SetLength(tree[x], length(tree[x])+1);
            tree[x][high(tree[x])] := i;
        end;
        readln;
        dp(0);
        writeln(f[0]);
        readln(n, T);
    end;
    close(input); close(output);
end.

//: Compiled by fpc

program work;

const
  infname = 'work.in';
  outfname = 'work.out';
  maxb = 100;
  maxn = 1000;
  maxm = 5000;
  maxt = maxn * maxb;
type
  Tinequ = record                          //inequation type
    i, j, b: longint;
  end;
var
  arrinequ: array [1..maxm] of Tinequ;     //array of inequations
  high, low: array [1..maxn] of longint;
  n, m, k, d: longint;
  flag, noans: boolean;

begin
  assign(input, infname);
  reset(input);
  assign(output, outfname);
  rewrite(output);
  read(n, m);
  for k:=1 to m do
    with arrinequ[k] do
      read(i, j, b);
  for k:=2 to n do                         //suppose t[1] = 0;
  begin
    high[k] := maxt;
    low[k] := -maxt;
  end;

  flag := true;
  noans := false;
  while (flag) do
  begin
    flag := false;
    for k:=1 to m do
      with arrinequ[k] do
      begin
        if (high[i] - high[j] > b) then    //update
        begin
          high[i] := high[j] + b;
          flag := true;
        end;
        if (low[i] - low[j] > b) then
        begin
          low[j] := low[i] - b;
          flag := true;
        end;
        if (low[i] > high[i]) or (low[j] > high[j]) then
        begin
          noans := true;
          flag := false;
          break;
        end;
      end;
  end;

  if noans then
    write('NO SOLUTION')
  else begin
    d := maxt;
    for k:=1 to n do
      if (low[k] < d) then d := low[k];
    for k:=1 to n do
      writeln(low[k] - d);
  end;
  close(input);
  close(output);
end.

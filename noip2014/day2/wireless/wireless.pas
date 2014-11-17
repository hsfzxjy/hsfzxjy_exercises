// 理解错误：以为WIFI的边界不得超出道路的边界

var
  sum,a: array [-20..138,-20..138] of int64;
  x,y,max,kk,tot: int64;
  i,j,n,k,xx,yy: longint;
  d: longint;
begin
  assign(input,'wireless.in');reset(input);
  assign(output,'wireless.out');rewrite(output);
  read(d,n);
  for i := 1 to n do
  begin
    read(x,y,k);
    a[x][y] := k;
  end;
  for i := -20 to 138 do
    for j := -20 to 138 do
      sum[i][j]:=sum[i][j-1]+sum[i-1][j]-sum[i-1][j-1]+a[i][j];

  max := 0; tot:=0;
  d := d shl 1;
  for i := -d div 2 to 128-d div 2 do
    for j := -d div 2 to 128-d div 2 do
    begin
      kk := sum[i+d][j+d]-sum[i-1][j+d]-sum[i+d][j-1]+sum[i-1][j-1];
      //if j=0 then writeln;
      //write(sum[i][j],' ');
      if kk = max then inc(tot);
      if kk>max then
      begin
        //writeln(i,j);
        tot := 1;
        max:=kk;
      end;
    end;
  writeln(tot,' ',max);
  close(input);close(output);
end.

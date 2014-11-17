const
   map: array [0..4,0..4] of longint = (
     (0,-1,1,1,-1),
     (1,0,-1,1,-1),
     (-1,1,0,-1,1),
     (-1,-1,1,0,1),
     (1,1,-1,-1,0)
   );
var
  a,b: array [1..1000] of longint;
  na,nb,n,i,j,ta,tb,_: longint;
begin
  assign(input, 'rps.in'); reset(input);
  assign(output,'rps.out');rewrite(output);
  read(n,na,nb);
  for i := 1 to na do read(a[i]);
  for i := 1 to nb do read(b[i]);
  i:=1;j:=1; ta:=0; tb:=0;
  for  _:=1 to n do
  begin
    if map[a[i],b[j]]>0 then inc(ta);
    if map[a[i],b[j]]<0 then inc(tb);
    i := i mod na + 1;
    j := j mod nb + 1;
  end;
  writeln(ta,' ',tb);
  close(input);close(output);
end.
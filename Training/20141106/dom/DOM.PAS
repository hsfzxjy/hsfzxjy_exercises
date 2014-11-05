uses crt;
var summe, i, j, k, n, x, a, b, cur, lst, curbr, lstbr : integer;
    brojevi : array[1..2, 0..6000] of record tko, koliko : integer; end;
    koji : array[0..6000] of integer;
    f : text;

procedure dodaj (w, koliko : integer);
begin
  for i:=1 to lstbr do
      if koji[brojevi[lst, i].tko+w]=0 then
         begin
           inc (curbr);
           brojevi[cur, curbr].tko:=brojevi[lst, i].tko+w;
           brojevi[cur, curbr].koliko:=brojevi[lst, i].koliko+koliko;
           koji[brojevi[cur, curbr].tko]:=curbr;
         end
         else
         begin
           x:=koji[brojevi[lst, i].tko+w];
           if brojevi[cur, x].koliko>brojevi[lst, i].koliko+koliko then
              brojevi[cur, x].koliko:=brojevi[lst, i].koliko+koliko;
         end;
end;

begin
  assign (f, 'DOM.IN'); reset (f);

  readln (f, n); cur:=1; lst:=2; lstbr:=1;

  for j:=1 to n do
      begin
      for k:=1 to lstbr do koji[brojevi[lst, k].tko]:=0;
      read (f, a, b);
      dodaj (a, 0); dodaj (b, 1); inc (summe, a+b);
      cur:=lst; if cur=1 then lst:=2 else lst:=1;
      lstbr:=curbr; curbr:=0;
      end;

  summe:=summe div 2+(summe mod 2); i:=summe;

  while koji[summe]=0 do dec (summe);

  if brojevi[lst, koji[2*i-summe]].koliko<brojevi[lst, koji[summe]].koliko then
     summe:=2*i-summe;

  assign (f, 'DOM.OUT'); rewrite (f);
  writeln (f, brojevi[lst, koji[summe]].koliko);
  close (f);
end.


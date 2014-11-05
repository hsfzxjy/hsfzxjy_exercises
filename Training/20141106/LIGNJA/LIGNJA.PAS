
 program lignja;
const maxn = 10000;
      maxk = 10000;
var minute : array[1..maxn+1] of integer;
p : array[1..maxk] of  integer;
t:array[1..maxn] of integer;
    n, k, i, j : integer;
    f : text;
begin
     assign(f, 'lignja.in');
     reset(f);
     readln(f, n, k);
     for i:=1 to k do readln(f, p[i],t[i]);
     close(f);
     j:=k;
     minute[n+1]:=0;
      for i:=n downto 1 do
     begin
         minute[i]:=0;
         if p[j]<>i then minute[i]:=1+minute[i+1] else
         while p[j]=i do
         begin
              if minute[i+t[j]]>minute[i] then
                 minute[i]:=minute[i+t[j]];
              j:=j-1;
         end;
     end;
     assign(f, 'lignja.out');
     rewrite(f);
     writeln(f, minute[1]);
     close(f);
end.

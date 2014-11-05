program magic(input, output);

const max = 100;

var k, n, m, i, j, p, q, x, y : integer;
    b0, b1, b : array [0..max, 1..max] of integer;
    found : boolean;

procedure operator1(x : integer);
 var i : integer;
 begin
   for i := 1 to m do
     b1[x][i] := b1[x][i] xor 1
 end;

procedure operator2(x, y : integer);
 var i, t : integer;
 begin
   for i := 1 to n do
     begin
       t := b1[i][x];
       b1[i][x] := b1[i][y];
       b1[i][y] := t
     end
 end;

function same(x, y : integer) : boolean;
 var i : integer;
 begin
   for i := 1 to n do
     if b0[i][x] <> b1[i][y]
       then begin
              same := false;
              exit
            end;
   same := true
 end;

begin
  assign(input, 'magic.in'); reset(input);
  readln(k);
  for i := 1 to k do
    begin
      readln(n, m);
      for x := 1 to n do
        for y := 1 to m do
          read(b0[x][y]);
      for x := 1 to n do
        for y := 1 to m do
          read(b1[x][y]);

      b := b1;
      for j := 1 to m do
        begin
          b1 := b; operator2(1, j);

          for p := 1 to n do
            if b0[p][1] <> b1[p][1] then operator1(p);

          for p := 1 to m do
            begin
              found := false;
              for q := p to m do
                if same(p, q)
                  then begin
                         found := true;
                         operator2(p, q);
                         break
                       end;
              if not found then break
            end;

          if found then break
        end;

      if found then writeln('YES') else writeln('NO')
    end
end.
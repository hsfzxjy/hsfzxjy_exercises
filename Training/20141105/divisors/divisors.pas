{$M 65520,0,655360}
const fin = 'divisors.in';
      fon = 'divisors.out';
      maxprime = 31622;
      amount = 3401;

var primes :array [1..amount] of word;
    l, u, number :longint;
    max :word;

procedure getprimes;
 var get :array [2..maxprime] of boolean;
     i, j :word;
 begin
   fillchar(get, sizeof(get), 1);
   for i := 2 to maxprime do
     if get[i]
       then begin
              j := i + i;
              while j <= maxprime do
                begin
                  get[j] := false;
                  inc(j, i)
                end
            end;
   j := 0;
   for i := 2 to maxprime do
     if get[i]
       then begin
              inc(j);
              primes[j] := i
            end
 end;

procedure find(from, tot :word; num, low, up :longint);
 var x, y, n, m, p :longint;
     i, j, t :word;
 begin
   if num >= l
     then if (tot > max) or ((tot = max) and (num < number))
            then begin
                   max := tot;
                   number := num
                 end;

   if (low = up) and (low > num) then find(from, tot * 2, num * low, 1, 1);
   
   for i := from to amount do
     if primes[i] > up
       then exit
       else begin
              j := primes[i];
              x := low - 1; y := up; n := num; t := tot; m := 1;
              while true do
                begin
                  inc(m); inc(t, tot);
                  x := x div j; y := y div j;
                  if x = y then break;
                  n := n * j;
                  find(i + 1, t, n, x + 1, y)
                end;
              m := 1 shl m; if tot < max div m then exit
            end
 end;

begin
  assign(input, fin); reset(input);
  assign(output, fon); rewrite(output);
  getprimes;
  readln(l, u);
  if (l = 1) and (u = 1)
    then begin
           max := 1;
           number := 1
         end
    else begin
           max := 2; number := l;
           find(1, 1, 1, l, u)
         end;
  writeln('Between ', l, ' and ', u, ', ', number, ' has a maximum of ', max, ' divisors.');
  close(output); close(input)
end.


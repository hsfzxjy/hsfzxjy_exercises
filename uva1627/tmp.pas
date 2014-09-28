var
  a: array [1..10] of boolean;
  i: integer;
  s: set of 1..100;
begin
  fillchar(a, sizeof(a),1);
  s := [1..10];
  for i in s do writeln(i);
  readln;
end.

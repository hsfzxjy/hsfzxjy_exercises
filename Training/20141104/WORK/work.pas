const
    inf = maxlongint div 5;
{var
    a: array [1..1000, 1..1000] of longint;
    deg: array [1..1000] of longint;
    out: array [1..1000] of Boolean;
    t: array [1..1000] of longint;
    n, m, i, j, x, y, z, k: longint;}

type
    Inequ = record
        i, j, b: Integer;

    end;

var
    flag, noans: boolean;
    arrinequ: array [1..5000] of Inequ;
    high, low: array [1..1000] of longint;
    i, j, m, k, n: longint;


label ex;
begin
    assign(input, 'work0.in'); reset(input);
    assign(output, 'work.out'); rewrite(output);


    read(n, m);
    for i := 1 to m do
        with arrinequ[i] do
            read(i, j, b);

{    filldword(a, sizeof(a) >>2, inf);
    read(n, m);
    for i := 1 to m do
    begin
        read(x, y, z);
        if z<=0 then
        begin
            a[y, x] := -z;
            inc(deg[y]);
        end
        else
        begin
            a[x, y] := z;
            inc(deg[x]);
        end;
    end;

    for i := 1 to n do
    begin
        k := maxlongint;
        for j := 1 to n do
        begin
            if not out[j] and (k>deg[j]) then
            begin
                x := j;
                k := deg[j];
            end;
        end;
        if k > 0 then
        begin
            writeln('NO SOLUTION');
            goto ex;
        end;
        k := 0;
        for j := 1 to n do
        begin
            if a[j, x]<>inf then dec(deg[j]);
        end;
        for j := 1 to n do
            if out[j] and (k<T[j]+a[x, j]) and (a[x, j]<>inf) then
                k := T[j] + a[x, j];
        T[x] := k;

        out[x] := True;
    end;

    for i := 1 to n do writeln(T[i]);}

  filldword(high, sizeof(high)>>2, 1000000);
  {$R-}filldword(low, sizeof(low)>>2, -1000000);
    high[1] := 0;
  low[1] := 0;
flag:=true;      {调整状态标记}
noans:=false;    {解的有无标记}
while (flag) do   {进行约束传递，根据不等式调整各个起始时间值}
  begin
    flag:=false;
    for k:=1 to m do
      with arrinequ[k] do
      begin
        if (high[i]-high[j]>b) then begin high[i]:=high[j]+b;  flag:=true;  end;  {调整Ti的上界}
        if (low[i]-low[j]>b) then begin low[j]:=low[i]-b;   flag:=true;  end;  {调整Tj的下界}
        if (low[i]>high[i]) or (low[j]>high[j])
         then begin          {无法满足当前不等式，则调整终止}
               noans:=true;   {问题无解noans=true}
               flag:=false;
               break;
             end;
      end;
  end;

  if noans then
    writeln('NO SOLUTION')
  else
    for i := 1 to n do writeln(high[i]);

ex: close(input); close(output);
end.

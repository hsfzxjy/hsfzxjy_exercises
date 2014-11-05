
{ DMIH 2002 - Drugi dan natjecanja        }
{ Srednjoskolska skupina - II. podskupina }
{ Zadatak BLAST                           }
{ Autor rjesenja Ivan Sikiric             }

program blast;
const maxn = 2000;
var f : text;
    a, b : array[1..maxn] of byte;
    g : array[0..maxn, 0..maxn] of longint;
    la, lb, i, j, k, temp : longint;
    c : char;
begin
    assign(f, 'blast.in');
    reset(f);
    la:=0; lb:=0;
    while not(eoln(f)) do
    begin
        read(f, c);
        la:=la+1;
        a[la]:=ord(c);
    end;
    readln(f);
    while not(eoln(f)) do
    begin
        read(f, c);
        lb:=lb+1;
        b[lb]:=ord(c);
    end;
    readln(f);
    readln(f, k);
    close(f);
    g[0, 0]:=0;
    for i:=1 to la do g[i, 0]:=k+g[i-1, 0];
    for j:=1 to lb do g[0, j]:=k+g[0, j-1];
    for i:=1 to la do
        for j:=1 to lb do
        begin
            g[i, j]:=k+g[i-1, j];
            temp:=k+g[i, j-1];
            if g[i, j]>temp then g[i, j]:=temp;
            temp:=abs(a[i]-b[j])+g[i-1, j-1];
            if g[i, j]>temp then g[i, j]:=temp;
        end;
    assign(f, 'blast.out');
    rewrite(f);
    writeln(f, g[la, lb]);
    close(f);
end.

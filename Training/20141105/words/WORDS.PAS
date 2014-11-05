PROGRAM words;
CONST
    maxrijeci=100;
    maxdulj=100;
VAR
    n:integer;
    nrijec:ARRAY[1..5, 1..5] OF integer;
    dulj:ARRAY[1..5, 1..5, 1..maxrijeci] OF integer;

FUNCTION num(c:char):integer;
BEGIN
    CASE c OF
        'A':num:=1;
        'E':num:=2;
        'I':num:=3;
        'O':num:=4;
        'U':num:=5;
    END;
END;

PROCEDURE citaj_ulaz;
VAR fin:text;
    i, j, k, l, t:integer;
    tmp:STRING[maxdulj];
    prvi, zadnji:integer;

BEGIN
    FOR i:=1 TO 5 DO
        FOR j:=1 TO 5 DO
            nrijec[i, j]:=0;
    assign(fin, 'WORDS.in');
    reset(fin);
    readln(fin, n);
    FOR i:=1 TO n DO
    BEGIN
        readln(fin, tmp);
        prvi:=num(tmp[1]);
        zadnji:=num(tmp[length(tmp)]);
        inc(nrijec[prvi, zadnji]);
        dulj[prvi, zadnji, nrijec[prvi, zadnji]]:=length(tmp);
    END;
    close(fin);
    { Sortiram rijeci po duljini }
    FOR i:=1 TO 5 DO
        FOR j:=1 TO 5 DO
            FOR k:=1 TO nrijec[i, j]-1 DO
                FOR l:=k+1 TO nrijec[i, j] DO
                    IF dulj[i, j, k]>dulj[i, j, l] THEN
                    BEGIN
                        t:=dulj[i, j, k];
                        dulj[i, j, k]:=dulj[i, j, l];
                        dulj[i, j, l]:=t;
                    END;
END;

FUNCTION nadji (zadnji:integer):integer;
VAR i:integer;
    max:integer;
    tmp:integer;
BEGIN
    max:=0;
    FOR i:=1 TO 5 DO
        IF nrijec[zadnji, i]>0 THEN
        BEGIN
            dec(nrijec[zadnji, i]);
            tmp:=dulj[zadnji, i, nrijec[zadnji, i]+1]+nadji(i);
            inc(nrijec[zadnji, i]);
            IF tmp>max THEN max:=tmp;
        END;
    nadji:=max;
END;

PROCEDURE rijesi;
VAR fout:text;
    i:integer;
    max, tmp:integer;
BEGIN
    max:=0;
    FOR i:=1 TO 5 DO
    BEGIN
        tmp:=nadji(i);
        IF (tmp>max) THEN max:=tmp;
    END;
    assign(fout, 'WORDS.out');
    rewrite(fout);
    writeln(fout, max);
    close(fout);
END;

{ Glavni program }
BEGIN
    citaj_ulaz;
    rijesi;
END.

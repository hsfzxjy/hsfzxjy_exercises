    //Accepted
    var
        s: AnsiString;
        n, _, i, j, l: integer;
        huiwen: array [1..1000, 1..1000] of boolean; //s[i,j]是否为回文串
        dp: array [0..1000] of integer;

    function min(x,y: integer): integer;
    begin
        if x<y then exit(x) else exit(y);
    end;

    procedure process(i,j: integer);
    var
        mid: Integer;
        x,y: integer;
    begin
        if j = i then
        begin
            huiwen[i,j] := true;
            exit;
        end;
        mid := i + (j-i+1) shr 1;
        x := i;
        y := j;
        while (x <= mid) and (s[x] = s[y]) do
        begin
            inc(x);
            dec(y);
        end;
        huiwen[i, j] := x > mid;
    end;

    begin
        //assign(input, 'main.in'); reset(input);
        //assign(output, 'main.out'); rewrite(output);
        readln(n);
        for _ := 1 to n do
        begin
            readln(s);
            l := length(s);
            //Pre-process
            fillchar(huiwen, sizeof(huiwen), 0);
            for i := 1 to l do
                for j := i to l do
                    process(i, j);
            //DP
            for i := 1 to l do
            begin
                dp[i] := i;
                for j := 0 to i-1 do
                    if huiwen[j+1, i] then
                        dp[i] := min(dp[i], dp[j]+1);
            end;
            write(dp[l]);
            {if _ <>n then }writeln;
        end;

        close(input);close(output);
    end.

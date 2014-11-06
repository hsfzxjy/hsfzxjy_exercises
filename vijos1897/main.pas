var
    _, i, n, t: longint;
    a: array [1..1000] of longint;
    sBST, jBST, max, min, dui, bst: Boolean;

procedure pd(x: longint);
var
    k: longint;
begin
    if x<<1>n then exit;
    k := x<<1;
    sBST := sBST and (a[k]<=a[x]);
    max := max and (a[k]<=a[x]);
    jBST := jBST and (a[k]>=a[x]);
    min := min and (a[k]>=a[x]);
    pd(k);
    if k=n then exit;
    inc(k);
    sBST := sBST and (a[k]>=a[x]);
    max := max and (a[k]<=a[x]);
    jBST := jBST and (a[k]<=a[x]);
    min := min and (a[k]>=a[x]);
    pd(k);
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);
    
    read(t);
    for _ := 1 to t do 
    begin
        write('Case #',_,': ');
        min := True;
        max := True;
        jBST := True;
        sBST := True;
        read(n);
        for i := 1 to n do read(a[i]);
        pd(1);
        dui := min or max;
        bst := jBST or sBST;
        if dui and bst then
            writeln('Both')
        else if dui then
            writeln('Heap')
        else if bst then
            writeln('BST')
        else
            writeln('Neither')
    end;

    close(input); close(output);
end.
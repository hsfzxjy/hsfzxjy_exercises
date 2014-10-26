type
    TEdge = record
        start, terminal: longint;
        weight: int64;
    end;
    TEdgeArr = array of TEdge;

operator <(e1, e2: TEdge)res: boolean;
begin
    res := e1.weight < e2.weight;
end;

operator >(e1, e2: TEdge)res: Boolean;
begin
    res := e1.weight > e2.weight;
end;

procedure SortEdge(A: TEdgeArr; l, r: longint);
var
    i, j: longint;
    t, m: TEdge;
begin
    i := l; j := r; m := A[(i+j) >> 1];
    repeat
        while A[i]<m do inc(i);
        while A[j]>m do dec(j);
        if i<=j then
        begin
            t := A[i];
            A[i] := A[j];
            A[j] := t;
            inc(i); dec(j);
        end;
    until i>j;
    if i<r then SortEdge(A, i, r);
    if l<j then SortEdge(A, l, j);
end;

const
    INF: int64 = 1<<60 div 3;
var
    map: array [1..100, 1..100] of int64;
    n, i, j: longint;

{
    @param x: 起始搜索节点
    算法思想：用一个数组维护从各个未加入顶点到
    树的最短边长度，操作n次，每次将距离最短的
    边加入到树中，并更新与之相邻的点的距离值。
}

function prim(x: longint): int64;
{
    lowest: 储存各个节点到树的最短距离
    visited: 标记是否已加入树中
}
var
    lowest: array [1..100] of int64;
    visited: array [1..100] of boolean;
    min: int64;
    i, j, minindex: longint;
begin
    fillchar(visited, sizeof(visited), 0);
    visited[x] := true;

    //先将初始节点加入树中，更新lowest
    for i := 1 to n do
        lowest[i] := map[i, x];

    prim := 0;
    for i := 2 to n do
    begin
        min := INF;

        //找出树到外部节点最短的一条边
        //并将该边加入树中
        for j := 1 to n do
            if (not visited[j]) and (min > lowest[j]) then
            begin
                min := lowest[j];
                minindex := j;
            end;
        visited[minindex] := true;
        prim := prim + min;

        //对新加入的那个节点，
        //更新与其相邻的未加入树的节点的lowest值
        for j := 1 to n do
        begin
            if visited[j] then continue;
            if map[j, minindex] < lowest[j] then
                lowest[j] := map[j, minindex];
        end;
    end;
end;

{
    算法思想：
    1. 先将边按照长度排序。
    2. 遍历所有的边，若该边的两个顶点都在树中则跳过；
    否则将其加入树中。
}

function Kruscal: int64;
var
    Edges: TEdgeArr; 
    //并查集，储存自己的父亲，若自己为根结点则为自己
    //这是一种常用的写法：否则如果存成0的话，想把两棵
    //树并在一起需要多一步判断。
    UnionSet: array [0..100] of longint; 
    i: longint;

    procedure InitEdges; //将邻接矩阵转化为边数组。
    var
        i, j: longint;
        E: TEdge;
    begin
        for i := 1 to n do
            for j := 1 to i-1 do
            begin
                E.start := i;
                E.terminal := j;
                E.weight := map[i, j];
                SetLength(Edges, Length(Edges)+1);
                Edges[High(Edges)] := E;
            end;
        SortEdge(Edges, Low(Edges), High(Edges));
    end;

    //寻找自己的根节点，并把自己直接连到根结点上。
    function Find(x: longint): longint;
    var
        root: longint;
    begin
        root := x;
        while root <> UnionSet[root] do 
            root := UnionSet[root];
        UnionSet[x] := root;
        exit(root);
    end;

    //尝试将边的两个顶点并在一个并查集中，如果两个
    //顶点都在同一个集合中则返回False，否则执行合
    //并操作。
    function Union(x, y: longint): boolean;
    var
        px, py: longint;
    begin
        px := Find(x);
        py := Find(y);
        if px = py then
            exit(False);
        UnionSet[px] := py;
        exit(True);
    end;

begin
    Kruscal := 0;
    fillchar(UnionSet, sizeof(UnionSet), 0);
    InitEdges;
    for i := 1 to n do
        UnionSet[i] := i;
    for i := Low(Edges) to High(Edges) do
        if Union(Edges[i].start, Edges[i].terminal) then
        begin
            Kruscal := Kruscal + Edges[i].weight;
        end;
end;

begin
    assign(input, 'main.in'); reset(input);
    assign(output, 'main.out'); rewrite(output);

    readln(n);
    for i := 1 to n do
        for j := 1 to n do
            read(map[i, j]);
    writeln(Kruscal);

    close(input); close(output);
end.
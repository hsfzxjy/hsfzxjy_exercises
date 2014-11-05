#include <fstream.h>
#include <iostream.h>
#include <string.h>

ifstream fin("family.in");
ofstream fout("family.out");
#define cout fout

const int MAX = 300+5;

struct num {
   int len;
   char n[MAX];
};

num p[MAX][MAX];
int st[MAX][MAX] = {0};
int parent[MAX][2] = {0}, n, m;
int g[MAX][MAX];

void out(num& op) {
   if (op.n[0] == 1) {
      cout << "100%" << endl;
      return;
   }
   if (op.n[1] != 0) cout << (int)op.n[1];
   cout << (int)op.n[2];
   if (op.len > 3) cout << '.';
   int i;
   for (i = 3; i < op.len; i++)
      cout << (int)op.n[i];
   cout << '%' << endl;
}

void div2(num& op) {
   int i, g = 0;
   for (i = 0; i <= op.len; i++) {
      g = g * 10 + op.n[i];
      op.n[i] = (g >> 1);
      g &= 1;  
   }
   if (op.n[op.len]) op.len++;
}

void add(num& a, num& b) {
   a.len = (a.len > b.len ? a.len : b.len);
   int i;
   for (i = a.len - 1; i >= 0; i--) {
      a.n[i] += b.n[i];
      if (a.n[i] >= 10) a.n[i] -= 10, a.n[i - 1]++;
   }
   while (a.len > 3 && a.n[a.len - 1] == 0) a.len--;
}


num tmp;

void dfs(int x, int y) {
   if (st[x][y]) return;
   st[x][y] = st[y][x] = 1;
   memset(&p[x][y], 0, sizeof(p[x][y]));
   
   if (x == y)
      p[x][y].len = 1, p[x][y].n[0] = 1;
   else if (!g[x][y] && parent[x][0] > 0) {
      int a = parent[x][0], b = parent[x][1];
      dfs(a, y); dfs(b, y);
      memcpy(&tmp, &p[a][y], sizeof(tmp)); div2(tmp); add(p[x][y], tmp);
      memcpy(&tmp, &p[b][y], sizeof(tmp)); div2(tmp); add(p[x][y], tmp);
   }
   else if (!g[y][x] && parent[y][0] > 0) {
      int a = parent[y][0], b = parent[y][1];
      dfs(x, a); dfs(x, b);
      memcpy(&tmp, &p[x][a], sizeof(tmp)); div2(tmp); add(p[x][y], tmp);
      memcpy(&tmp, &p[x][b], sizeof(tmp)); div2(tmp); add(p[x][y], tmp);
   }

   memcpy(&p[y][x], &p[x][y], sizeof(p[x][y]));
}

main() {
   fin >> n >> m;
   memset(g, 0, sizeof(g));
   int i, j, k;
   for (i = 0; i < m; i++) {
      int a, x, y;
      fin >> a >> x >> y;
      parent[a][0] = x, parent[a][1] = y;
      g[x][a] = g[y][a] = 1;
   }
   
   for (k = 1; k <= n; k++)
      for (i = 1; i <= n; i++)
         for (j = 1; j <= n; j++)
            if (g[i][k] && g[k][j])
               g[i][j] = 1;
   
   int t;
   fin >> t;
   for (i = 0; i < t; i++) {
      int x, y;
      fin >> x >> y;
      dfs(x, y);
      out(p[x][y]);
   }
   
   return 0;  
}
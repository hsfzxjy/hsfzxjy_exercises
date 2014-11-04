#include <fstream>
#include <string.h>

using namespace std;

ifstream fin("machine.in");
ofstream fout("machine.out");

const int MAX = 100+5;

int n, m, g[MAX][MAX];

int link[MAX], used[MAX];

int path(int i) {
   if (used[i]) return 0;
   used[i] = 1;
   int j;
   for (j = 1; j <= m; j++) if (g[i][j])
      if (!link[j] || path(link[j])) {
         link[j] = i;
         return 1;  
      }  
   return  0;   
}

main() {
   int i, j, k;
   fin >> n >> m >> k;

   memset(g, 0, sizeof(g));   
   for (i = 0; i < k; i++) {
      int temp, x, y;
      fin >> temp >> x >> y;
      if (x && y) g[x][y] = 1;  
   }
      
   memset(link, 0, sizeof(link));
   memset(used, 0, sizeof(used));
   
   for (i = 1; i <= n; i++)
      if (path(i))
         memset(used, 0, sizeof(used));
         
   int tot = 0;
   for (i = 1; i <= m; i++)
      if (link[i])
         tot++;
         
   fout << tot << endl;
   
   return 0;   
}

#include <fstream.h>
#include <string.h>

ifstream fin("game.in");
ofstream fout("game.out");

const int MAX = 1 << 16;

int st[MAX], fr[MAX], queue[MAX];
int sour, dest;

void init();
void solve();
void putanswer(int);

main() {
   init();
   solve();
   fout << st[dest] << endl;
   putanswer(dest);
   return 0;  
}

void init() {
   int i;
   char c;
   for (sour = i = 0; i < 16; i++) {
      fin >> c;
      sour |= (int)(c - '0') << i;
   }
   for (dest = i = 0; i < 16; i++) {
      fin >> c;
      dest |= (int)(c - '0') << i;  
   }
}

void solve() {
   memset(st, 0xFF, sizeof(st));
   st[sour] = 0, queue[queue[0] = 1] = sour;
   
   int i, j;
   for (i = 1; i <= queue[0]; i++) {
      int now = queue[i], mode;
      for (j = 0, mode = 3; j < 16; j++, mode <<= 1)
         if (j % 4 != 3 && (((now & mode) >> j) == 1 || ((now & mode) >> j) == 2) ) {
            int v = now ^ mode;
            if (st[v] == -1) st[v] = st[now] + 1, fr[v] = j, queue[++queue[0]] = v;
         }
         
      for (j = 0, mode = 17; j < 12; j++, mode <<= 1)
         if ( ((now & mode) >> j) == 1 || ((now & mode) >> j) == 16 ) {
            int v = now ^ mode;
            if (st[v] == -1) st[v] = st[now] + 1, fr[v] = -j - 1, queue[++queue[0]] = v;
         }
      
      if (st[dest] != -1) break;
   }
}

void putanswer(int now) {
   if (now == sour) return;

   int last = now;
   if (fr[now] >= 0) last ^= 3 << fr[now];
   else last ^= 17 << (-fr[now] - 1);

   putanswer(last);

   if (fr[now] >= 0)
      fout << fr[now] / 4 + 1 << fr[now] % 4 + 1 
           << fr[now] / 4 + 1 << fr[now] % 4 + 2 << endl;
   else 
      fout << (-fr[now]-1) / 4 + 1 << (-fr[now]-1) % 4 + 1
           << (-fr[now]-1) / 4 + 2 << (-fr[now]-1) % 4 + 1 << endl;
}

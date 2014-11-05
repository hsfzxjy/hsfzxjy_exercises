#include <stdio.h>
#include <string.h>
#define MAX (1<<15)

void init();
void solve();
void DFS(int r, int state);

int based2[16];

int n, color[15];
bool g[15][15];
short fm[15][MAX];

int main() {
	int nround, i;
	
	freopen("paint.in", "r", stdin);
	freopen("paint.out", "r", stdout);
	
	based2[0]=1;
	for ( i=1; i<=15; ++i )
		based2[i]=based2[i-1]<<1;
		
  init();
	solve();
	
	fclose(stdin);
	fclose(stdout);
	
	return 0;
}

void init() {
	int map[100][100];
	int i, j, k;
	
	scanf("%d", &n);
	memset(map, -1, sizeof(map));
	
	for ( i=0; i<n; ++i ) {
		int x1, y1, x2, y2;
		
		scanf("%d %d %d %d %d", &x1, &y1, &x2, &y2, &color[i]);
		for ( j=x1; j<x2; ++j )
			for ( k=y1; k<y2; ++k )
				map[j][k]=i;
	}
	
	memset(g, false, sizeof(g));
	for ( i=0; i<99; ++i )
		for ( j=0; j<100; ++j )
			if ( map[i][j]>=0 && map[i+1][j]>=0 && map[i][j]!=map[i+1][j] )
				g[map[i][j]][map[i+1][j]]=true;
}

void solve() {
	memset(fm, -1, sizeof(fm));
	
	int i;
	short best = -1;
	for ( i=0; i<n; ++i ) {
		DFS(i, based2[n]-1);
		if ( best<0 || best>fm[i][based2[n]-1] )
			best=fm[i][based2[n]-1];
	}
	
	printf("%hd\n", best);
}

void DFS(int r, int state) {
	// printf("%d %d\n", r, state);
	
	if ( fm[r][state]>=0 )
		return;
		
	int i;
	for ( i=0; i<n; ++i )
		if ( i!=r && (state&based2[i]) && g[i][r] ) {
			fm[r][state]=99; return;
		}
		
	int nstate = state-based2[r];
	if ( nstate==0 )
		fm[r][state]=1;
	else
		for ( i=0; i<n; ++i )
			if ( nstate&based2[i] ) {
				DFS(i, nstate);
				
				short v = fm[i][nstate]+( color[r]==color[i] ? 0 : 1 );
				if ( fm[r][state]<0 || fm[r][state]>v )
					fm[r][state]=v;
			}
}

/*
DMIH 2002, Drugi dan natjecanja
Srednjoskolska skupina, I. podskupina
Zadatak LIGNJA, Programski jezik C
*/

#include <stdio.h>
#include <stdlib.h>
#define MAXN 10005
#define MAXK 10005

struct lista
{
	int v;
    struct lista *next;
};

FILE *fin, *fout;
int n, k;
struct lista *polje[MAXN];

int rje[MAXN];

int main( void )
{
    int i, x, y;
    int max;
    struct lista *l;

	fin = fopen( "lignja.in", "rt" );
    fscanf( fin, "%d %d", &n, &k );
    for( i = 1; i <= n; i++ ) polje[i] = NULL;
    for( i = 1; i <= k; i++ )
    {
    	fscanf( fin, "%d %d", &x, &y );
        l = (struct lista*)malloc( sizeof( struct lista ) );
        l->v = x + y;
        l->next = polje[x];
        polje[x] = l;
    }

    rje[n + 1] = 0;

   	for( i = n ; i >= 1; i-- )
    {
    	max = -1;
    	if( polje[i] == NULL ) rje[i] = rje[i + 1] + 1;
        else
        {
        	l = polje[i];
        	while( l != NULL )
        	{
        		if( rje[l->v] > max ) max = rje[(*l).v];
                l = l -> next;
        	}
        	rje[i] = max;
        }
    }
    fout = fopen( "lignja.out", "wt" );
    fprintf( fout, "%d\n", rje[1] );
    fclose( fout);
    fclose( fin );
	return 0;
}

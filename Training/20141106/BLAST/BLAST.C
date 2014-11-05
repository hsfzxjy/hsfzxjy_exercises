
/*
DMIH 2002, Drugi dan natjecanja
Srednjoskolska skupina, II. podskupina
Zadatak BLAST, Programski jezik C
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXLEN                  2000
#define INFILE			"blast.in"
#define OUTFILE			"blast.out"

#define GORELIJEVO		3
#define GORE			2
#define LIJEVO			1
#define MAXINT			1000000000

char prvi[MAXLEN], drugi[MAXLEN];
int penalty_space;
int penalty[MAXLEN+1][MAXLEN+1];
//int way_back[MAXLEN+1][MAXLEN+1];

void load_data ( void )
{
	FILE *fin=fopen (INFILE, "rt");

	fscanf (fin, "%s", prvi);
	fscanf (fin, "%s", drugi);
	fscanf (fin, "%d", &penalty_space);

	fclose (fin);
}

int distance ( char a, char b )
{
	if (a==' ' || b==' ') return penalty_space;
	return abs(a-b);
}

int solve ( void )
{
	int i, j, temp, prvi_len, drugi_len;

	penalty[0][0]=0; prvi_len=strlen (prvi); drugi_len=strlen (drugi);

	for (i=0; i<=prvi_len; i++)
		for (j=0; j<=drugi_len; j++)
			if (i+j)
			{
				penalty[i][j]=MAXINT;
				if ((i*j) && (temp=penalty[i-1][j-1]+distance (prvi[i-1], drugi[j-1])) < penalty[i][j])
				{
					penalty[i][j]=temp;
//					way_back[i][j]=GORELIJEVO;
				}

				if (i && (temp=penalty[i-1][j]+distance (prvi[i-1], ' ')) < penalty[i][j])
				{
					penalty[i][j]=temp;
//					way_back[i][j]=LIJEVO;
				}

				if (j && (temp=penalty[i][j-1]+distance (drugi[j-1], ' ')) < penalty[i][j])
				{
					penalty[i][j]=temp;
//					way_back[i][j]=GORE;
				}
			}

	return penalty[prvi_len][drugi_len];
}

void write_solution ( int sol )
{
	FILE *fout=fopen (OUTFILE, "wt");

	fprintf (fout, "%d\n", sol);
	fclose (fout);
}


int main ( void )
{
	load_data();
	write_solution (solve());

        return 0;
}

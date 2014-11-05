
// HIO 2001
// Zadatak RIJECI
// Autor rjesenja Bojan Antolovic
// Nesluzbeno rjesenje

#include <stdio.h>
#include <string.h>
#define IN "WORDS.in"
#define OUT "WORDS.out"
#define MAXLEN 100
#define MAXN 100


int broj_veza[5][5];
int veze[5][5][MAXN]; /* duljina rijeci */
int maxtezina;

void sortiraj(int *a, int n)
{
	int i, j, t;
	for (i=0; i<n-1; i++)
		for (j=i+1; j<n; j++)
			if (a[i]>a[j])
			{	t = a[i]; a[i] = a[j]; a[j] = t; }
}

int slovo2broj(char s)
{
	switch (s)
	{
		case 'A': return 0;
		case 'E': return 1;
		case 'I': return 2;
		case 'O': return 3;
		default: return 4;
	}
}

char broj2slovo(int b)
{
	switch (b)
	{
		case 0: return 'A';
		case 1: return 'E';
		case 2: return 'I';
		case 3: return 'O';
		default: return 'U';
	}
}

void input(void)
{
	FILE *f;
	int n, i, a, b, l;
	char s[MAXLEN+1];
	f = fopen(IN, "rt");
	fscanf(f, "%d", &n);
	for (a=0; a<5; a++)
		for (b=0; b<5; b++)
			broj_veza[a][b] = 0;
	for (i=0; i<n; i++)
	{
		fscanf(f, "%s", s);
		l = strlen(s);
		a = slovo2broj(s[0]);
		b = slovo2broj(s[l-1]);
		veze[a][b][broj_veza[a][b]++] = l;
	}
	for (a=0; a<5; a++)
		for (b=0; b<5; b++)
			sortiraj(veze[a][b], broj_veza[a][b]);
	fclose(f);
}


int nadi_max_tezinu(int poc_slovo)
{
	int zav_slovo, ostatakputa, maxostatakputa;
	maxostatakputa = 0;
	for (zav_slovo=0; zav_slovo<5; zav_slovo++)
		if (broj_veza[poc_slovo][zav_slovo]>0)
		{
			broj_veza[poc_slovo][zav_slovo]--;
			ostatakputa = nadi_max_tezinu(zav_slovo)
				+ veze[poc_slovo][zav_slovo][broj_veza[poc_slovo][zav_slovo]];
			if (ostatakputa>maxostatakputa) maxostatakputa = ostatakputa;
			broj_veza[poc_slovo][zav_slovo]++;
		}
	return maxostatakputa;
}

void rijesi(void)
{
	int poc, tezina;
	maxtezina = 0;
	for (poc=0; poc<5; poc++)
	{
		tezina = nadi_max_tezinu(poc);
		if (tezina>maxtezina) maxtezina = tezina;
	}
}

void output(void)
{
	FILE *f;
	f = fopen(OUT, "wt");
	fprintf(f, "%d\n", maxtezina);
	fclose(f);
}

int main()
{
	input();
	rijesi();
	output();
	return 0;
}

#include <fstream.h>
#include <iostream.h>
#include <string.h>

int dat1[4][4],dat2[4][4];

bool same();

int main()
{
	memset(dat1,0,sizeof(dat1));
	memset(dat2,0,sizeof(dat2));
	ifstream fin1("game.in");ifstream fin2("game.out");
	ifstream fin3("game.std");int i;
	for (i=0;i<4;i++)
	{
		int j;
		for (j=0;j<4;j++)
		{char ch;fin1>>ch;dat1[i][j]=ch-48;}
	}
	for (i=0;i<4;i++)
	{
		int j;
		for (j=0;j<4;j++)
		{char ch;fin1>>ch;dat2[i][j]=ch-48;}
	}
	int x,y;fin2>>x;fin3>>y;
	if (x!=y) {cout<<"wrong!"<<endl;return 0;}
	if (y==0) {cout<<"right!"<<endl;return 0;}
	for (i=0;i<x;i++)
	{
		char a,b,c,d;
		fin2>>a>>b>>c>>d;
		a-=49;b-=49;c-=49;d-=49;
		int t=dat1[a][b];dat1[a][b]=dat1[c][d];dat1[c][d]=t;
	}
	if (same()) cout<<"right!"<<endl;
	else cout<<"wrong!"<<endl;
	return 0;
}

bool same()
{
	bool bo=true;int i;
	for (i=0;i<4;i++)
	{
		int j;
		for (j=0;j<4;j++)
			bo=bo && (dat1[i][j]==dat2[i][j]);
		if (!bo) break;
	}
	return bo;
}
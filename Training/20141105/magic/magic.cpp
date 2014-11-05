#include <fstream.h>
#include <string.h>

int dat[5][5][7];
int hash[17];
int map[5][5];
int line[15][2];
ifstream fin("magic.in");ofstream fou("magic.out");
int a,b,c,d;

void prep();
void search(int x,int y);
bool doit(int a,int b,int c);
void output();
void add(int a,int b,int c);
void sub(int a,int b,int c);

int main()
{
	memset(hash,0,sizeof(hash));memset(map,0,sizeof(map));
	memset(line,0,sizeof(line));memset(dat,0,sizeof(dat));
	fin>>a>>b;d=b+1;c=a;if (d>4) {d=1;c++;}
	prep();search(1,1);return 0;
}

void prep()
{
	dat[1][1][0]=dat[1][2][0]=dat[2][1][0]=dat[2][2][0]=1;
	dat[1][3][1]=dat[1][4][1]=dat[2][3][1]=dat[2][4][1]=1;
	dat[3][1][2]=dat[3][2][2]=dat[4][1][2]=dat[4][2][2]=1;
	dat[3][3][3]=dat[3][4][3]=dat[4][3][3]=dat[4][4][3]=1;
	dat[2][2][4]=dat[2][3][4]=dat[3][2][4]=dat[3][3][4]=1;
	dat[1][1][5]=dat[2][2][5]=dat[3][3][5]=dat[4][4][5]=1;
	dat[1][4][6]=dat[2][3][6]=dat[3][2][6]=dat[4][1][6]=1;
}

void search(int x,int y)
{
	if (x>4){output();return;}
	if (x==a && y==b)
	{
		map[a][b]=1;
		if (doit(a,b,1)) {add(a,b,1);search(c,d);sub(a,b,1);}
		map[a][b]=0;
	}
	else
	{
		int i,x1=x,y1=y+1;
		if (y1>4) {y1=1;x1++;}
		for (i=2;i<=16;i++)
		{
			map[x][y]=i;
			if (!hash[i] && doit(x,y,i))
			{add(x,y,i);search(x1,y1);sub(x,y,i);}
			map[x][y]=0;
		}
	}
}

bool doit(int a,int b,int c)
{
	int i;bool bo=1;
	for (i=0;i<7;i++)
	{
		if (dat[a][b][i])
		{
			int x=line[i][0]+c;
			bo&=x+16*(3-line[i][1])>=34 && x+(3-line[i][1])<=34;
			if (!bo) return 0;
		}
	}
	int t=6+a,x=line[t][0]+c;
	bo&=x+16*(3-line[t][1])>=34 && x+(3-line[t][1])<=34;
	if (!bo) return 0;
	t=10+b;x=line[t][0]+c;
	bo&=x+16*(3-line[t][1])>=34 && x+(3-line[t][1])<=34;
	if (!bo) return 0;
	return 1;
}

void output()
{
	int i;
	for (i=1;i<=4;i++)
	{
		fou<<map[i][1];int j;
		for (j=2;j<=4;j++)
			fou<<' '<<map[i][j];
		fou<<endl;
	}
	fou<<endl;
}

void add(int a,int b,int c)
{
	int i;hash[c]=1;
	for (i=0;i<7;i++)
	{
		if (dat[a][b][i])
		{line[i][0]+=c;line[i][1]++;}
	}
	int t=6+a;line[t][0]+=c;line[t][1]++;
	t=10+b;line[t][0]+=c;line[t][1]++;
}

void sub(int a,int b,int c)
{
	int i;hash[c]=0;
	for (i=0;i<7;i++)
	{
		if (dat[a][b][i])
		{line[i][0]-=c;line[i][1]--;}
	}
	int t=6+a;line[t][0]-=c;line[t][1]--;
	t=10+b;line[t][0]-=c;line[t][1]--;
}

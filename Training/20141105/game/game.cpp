#include <fstream.h>
#include <string.h>

char hash[65536];
typedef unsigned char arr[4][4];
int line[13000][4];
ifstream fin("game.in");ofstream fou("game.out");

int init();
void itos(unsigned char * dat,int x);
int stoi(unsigned char * dat);
void out(int a);
int n1=0,n2=0;
int main()
{
	memset(line,0,sizeof(line));
	memset(hash,0,sizeof(hash));
	int i=0,k=1,x;
	line[0][0]=init();
	n2=n1;n1=0;x=init();
	if (n1!=n2) {fou<<0<<endl;return 0;}
	line[0][1]=0;line[0][2]=0;line[0][3]=-1;
	hash[line[0][0]]=1;
	while (i<k && !hash[x])
	{
		int j;arr dat;
		itos(&dat[0][0],line[i][0]);
		for (j=0;j<4;j++)
		{
			int l;
			for (l=0;l<4;l++)
			{
				if (j!=3 && dat[j][l]!=dat[j+1][l])
				{
					int t=dat[j][l];dat[j][l]=dat[j+1][l];dat[j+1][l]=t;
					int y=stoi(&dat[0][0]);
					if (!hash[y])
					{
						line[k][0]=y;line[k][1]=line[i][1]+1;
						line[k][2]=j*1000+l*100+(j+1)*10+l;
						line[k][3]=i;k++;
						hash[y]=1;if (y==x) break;
					}
					t=dat[j][l];dat[j][l]=dat[j+1][l];dat[j+1][l]=t;
				}
				if (l!=3 && dat[j][l]!=dat[j][l+1])
				{
					int t=dat[j][l];dat[j][l]=dat[j][l+1];dat[j][l+1]=t;
					int y=stoi(&dat[0][0]);
					if (!hash[y])
					{
						line[k][0]=y;line[k][1]=line[i][1]+1;
						line[k][2]=j*1000+l*100+j*10+l+1;
						line[k][3]=i;k++;
						hash[y]=1;if (y==x) break;
					}
					t=dat[j][l];dat[j][l]=dat[j][l+1];dat[j][l+1]=t;
				}
			}
			if (hash[x]) break;
		}
		i++;
	}
	fou<<line[k-1][1]<<endl;
	out(k-1);
	return 0;
}

int init()
{
	char a[5];
	int i,x=0;
	for (i=0;i<4;i++)
	{
		fin>>a;int j;
		for (j=0;j<4;j++)
		{x<<=1;x+=a[j]-48;n1+=a[j]-48;}
	}
	return x;
}

void itos(unsigned char* dat,int x)
{
	int i;
	for (i=15;i>=0;i--)
	{dat[i]=x&1;x>>=1;}
}

int stoi(unsigned char* dat)
{
	int i,x=0;
	for (i=0;i<16;i++)
	{x<<=1;x+=dat[i];}
	return x;
}

void out(int a)
{
	if (line[a][3]) out(line[a][3]);
	fou<<line[a][2]+1111<<endl;
}
#include <stdio.h>
#include <math.h>

#define MAX 50

int l,w,h,m,i,j,k,kk,x3,y3,z3;
unsigned char rr[MAX][MAX][MAX];
unsigned char	c[MAX][MAX][MAX];
typedef struct tagcoord {
	unsigned char x;
	unsigned char y;
	unsigned char z;
} tcoord;
tcoord q[125001];
int dx[6]={0,-1,0,1,0,0};
int dy[6]={1,0,-1,0,0,0};
int dz[6]={0,0,0,0,1,-1};
int ok;
int r;

int count=0;

void fill(int x, int y, int z)
{
	int f,xx,yy,zz,x2,y2,z2,k;
	f=0; r=0; q[f].x=x; q[f].y=y; q[f].z=z;
	do {
		xx=q[f].x; yy=q[f].y; zz=q[f].z;
		for (k=0; k<6; k++) {
			x2=xx+dx[k]; y2=yy+dy[k]; z2=zz+dz[k];
			if (x2>=0 && y2>=0 && z2>=0 && x2<l && y2<w && z2<h &&
			c[x2][y2][z2]==0 &&
			abs((signed int)rr[xx][yy][zz]-(signed int)rr[x2][y2][z2])<=m) {
				ok=1;
				for (kk=0; kk<6; kk++) {
					x3=x2+dx[kk]; y3=y2+dy[kk]; z3=z2+dz[kk];
					if (x3>=0 && y3>=0 && z3>=0 && x3<l && y3<w && z3<h && c[x3][y3][z3]==1)
						if (abs((signed int)rr[x2][y2][z2]-(signed int)rr[x3][y3][z3])>m) {
							ok=0;
							break;
						}
				}
				if (ok) {
					c[x2][y2][z2]=1;
					r++;
					q[r].x=x2; q[r].y=y2; q[r].z=z2;
				}
			}
		}
		f++;
	} while (f<=r);
}

void fill2()
{
	int xx,yy,zz,i;
	for (i=0; i<=r; i++) {
		xx=q[i].x; yy=q[i].y; zz=q[i].z;
		c[xx][yy][zz]=2;
	}
}

int main()
{
	FILE* inf=fopen("scan.in","r");
	FILE* outf=fopen("scan.out","w");

	fscanf(inf,"%d %d %d\n",&l,&w,&h);
	fscanf(inf,"%d\n",&m);

	for (i=0; i<l; i++)
		for (j=0; j<w; j++)
			for (k=0; k<h; k++)
				fscanf(inf,"%d",&rr[i][j][k]);
	fclose(inf);

	for (i=0; i<l; i++)
		for (j=0; j<w; j++)
			for (k=0; k<h; k++)
				if (c[i][j][k]==0) {
					c[i][j][k]=1;
					count++;
					fill(i,j,k);
					c[i][j][k]=2;
					fill2();
				}

	fprintf(outf,"%d",count);
	fclose(outf);
	return 0;
}


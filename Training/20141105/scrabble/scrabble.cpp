#include <fstream.h>
#include <string.h>
ifstream fin("f.in");
#define cin fin
ofstream fout("f.out");
//#define cout fout
struct number{
   int a,b;
};
int n,m;
number p[100],q[100],f[100];
int abs(int a)
{
   if (a<0) return -a;
   else return a;
}
int publicp(int a,int b)
{
	do {
      int c=a%b;
      a=b,b=c;
   }while (b!=0);
   return a;
}
void reduce(number &p)
{
   int a=abs(p.a),b=abs(p.b);
   do {
      int c=a%b;
      a=b,b=c;
   }while (b!=0);
   p.a/=a,p.b/=a;
   if (p.b<0) {
      p.a=-p.a;
      p.b=-p.b;
   }
}
void add(number p1,number p2,number &p)
{
   p.a=(p1.a*p2.b+p1.b*p2.a);
   p.b=p1.b;
   reduce(p);
   p.b*=p2.b;
   reduce(p);
}
void mul(number p1,number p2,number &p)
{
   number pa,pb;
   pa.a=p1.a,pa.b=p2.b;
   pb.a=p2.a,pb.b=p1.b;
   reduce(pa);reduce(pb);
   p.a=pa.a*pb.a;
   p.b=pa.b*pb.b;
   reduce(p);
}
void divi(number p1,number p2,number &p)
{
   number pa,pb;
   pa.a=p1.a,pa.b=p1.b;
   pb.a=p2.b,pb.b=p2.a;
   mul(pa,pb,p);
}
bool found;
int exist[20],xx[20],ca[20];
number equ[20][20],x[20];
int ii[20],jj[20],a[20],link[20],ir[20];
void guess()
{
   int i,j,k;
   memset(exist,0,sizeof(exist));
   int iequ=0;	
   for (i=0;i<n && iequ<m;i++) {
      if (equ[iequ][i].a==0) {
         for (j=iequ+1;j<m;j++)
            if (equ[j][i].a!=0) {
               memcpy(equ[n],equ[iequ],sizeof(equ[n]));
               memcpy(equ[iequ],equ[j],sizeof(equ[n]));
               memcpy(equ[j],equ[n],sizeof(equ[n]));
               break;
            }
      }
	  if (equ[iequ][i].a==0) continue;
	  else exist[i]=1;
	  link[iequ]=i;
      for (j=iequ+1;j<m;j++) if (equ[j][i].a!=0) {
         number t;
         divi(equ[iequ][i],equ[j][i],t);
         t.a=-t.a;
         for (k=i;k<=n;k++) {
            mul(equ[j][k],t,equ[j][k]);
            add(equ[j][k],equ[iequ][k],equ[j][k]);
         }
      }
	  iequ++;
   }
   m=iequ;
}
bool check()
{
	int i,j,tmp;
	for (i=0;i<16;i++) if (xx[i]<=0) return false;
	for (i=0;i<16;i++) if (xx[i]>300) return false;
	j=0;
	for (i=0;i<4;i++) {		
		tmp=xx[i*4+0]+xx[i*4+1]+xx[i*4+2]+xx[i*4+3];
		if (tmp!=a[j]) return false;
		j++;		   
	}
	for (i=0;i<4;i++) {		
		tmp=xx[0*4+i]+xx[1*4+i]+xx[2*4+i]+xx[3*4+i];
		if (tmp!=a[j]) return false;
		j++;		   
	}
	
	tmp=xx[0]+xx[1*4+1]+xx[2*4+2]+xx[3*4+3];
	if (tmp!=a[j]) return false;
	j++;
	   
	   
	tmp=xx[0*4+3]+xx[1*4+2]+xx[2*4+1]+xx[3*4+0];
	if (tmp!=a[j]) return false;
	j++;	   
	for (i=0;i<4;i++) {
	   if (xx[ii[i]*4+jj[i]]!=a[j]) return false;
	   j++;
	}
	return true;
}

bool solve()
{
	int i,j,k;
	for (k=m-1;k>=0;k--) {
		i=link[k];
		number t;
		t=equ[k][n];
		for (j=n-1;j>i;j--) {
			number tmp;
			tmp=equ[k][j];
			tmp.a=-tmp.a;
			mul(tmp,x[j],tmp);
			add(t,tmp,t);
		}
		divi(t,equ[k][i],x[i]);
	}
	int p=x[0].b/publicp(x[0].b,x[1].b)*x[1].b;
	for (i=2;i<16;i++) p=p/publicp(p,x[i].b)*x[i].b;
	for (i=0;i<16;i++) xx[i]=p*x[i].a;
	if (check()) {
		k=0;
		for (i=0;i<4;i++) {
			for (j=0;j<4;j++) cout<<x[k++].a<<" ";
			cout<<endl;
		}
		return true;
	}
	return false;
}
bool cut()
{
	int i,j,k;
	for (k=0;k<m;k++) {
		i=link[k];
		for (j=0;j<n;j++) if (!ca[j] && equ[k][j].a!=0) break;
		if (j!=n) continue;
		number t;
		t=equ[k][n];
		for (j=n-1;j>i;j--) {
			number tmp;
			tmp=equ[k][j];
			tmp.a=-tmp.a;
			mul(tmp,x[j],tmp);
			add(t,tmp,t);
		}
		divi(t,equ[k][i],x[i]);
		if (x[i].a<=0 || x[i].a*x[i].b>300) return true;
	}
	return false;
}
void search(int j)
{	
	int k;
	if (j==n) {
		if (solve()) found=true;
		return;
	}
	if (cut()) return;
	x[j].b=1;
	for (k=j+1;k<16;k++) if (!exist[k] && !ir[k]) break;
	ca[j]=1;	
	for (x[j].a=1;x[j].a<=300;x[j].a++)  {		
		search(k);
		if (found) break;
	}
	ca[j]=0;
}
main()
{
   int i,j,cases(0);
   for (;;) {
	   m=0;n=16;
	   memset(equ,0,sizeof(equ));
	   for (i=0;i<=16;i++)
		   for (j=0;j<=16;j++) equ[i][j].b=1;
	   for (i=0;i<4;i++) {
		   cin>>a[m];
		   if (cin.fail()) return 0;
		   equ[m][i*4+0].a=1,equ[m][i*4+1].a=1,equ[m][i*4+2].a=1,equ[m][i*4+3].a=1,equ[m][16].a=a[m];		   
		   m++;
	   }
	   for (i=0;i<4;i++) {
		   cin>>a[m];
		   if (cin.fail()) return 0;
		   equ[m][0*4+i].a=1,equ[m][1*4+i].a=1,equ[m][2*4+i].a=1,equ[m][3*4+i].a=1,equ[m][16].a=a[m];
		   m++;
	   }
	   cin>>a[m];
	   if (cin.fail()) return 0;
	   equ[m][0].a=1,equ[m][1*4+1].a=1,equ[m][2*4+2].a=1,equ[m][3*4+3].a=1,equ[m][16].a=a[m];
	   m++;
	   cin>>a[m];
	   if (cin.fail()) return 0;
	   equ[m][0*4+3].a=1,equ[m][1*4+2].a=1,equ[m][2*4+1].a=1,equ[m][3*4+0].a=1,equ[m][16].a=a[m];
	   m++;
	   memset(ca,0,sizeof(ca));
	   for (i=0;i<4;i++) {		   
		   cin>>ii[i]>>jj[i]>>a[m];
		   if (cin.fail()) return 0;
		   equ[m][ii[i]*4+jj[i]].a=1;equ[m][16].a=a[m];
		   m++;
	   }	   
       guess();
	   memset(ir,0,sizeof(ir));
	   for (i=0;i<n;i++) if (!exist[i]) {
		   for (j=0;j<m;j++) if (equ[j][i].a!=0) break;
		   if (j==m) x[i].a=1,x[i].b=1,ir[i]=1;
	   }
	   found=false;
	   for (i=0;i<n;i++) if (!exist[i] && !ir[i]) {
//		   cout<<i<<" -- "<<endl;
		   search(i);			   
		   if (found) break;
		   break;
	   }	   
   }
   return 0;
}

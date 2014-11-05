#include<stdio.h>
#include<stdlib.h>
#include<string>
#include<math.h>
#include<assert.h>

FILE *inp,*outp;
int Tot,t1,t2,t3,i,j,k,n,t4;
int a[50],g[50][2000];
long double s,ans,p;
int abs(int t1){
	if (t1>0) return t1;else
		      return -t1;
}
main(){
	inp=fopen("Pasture.in","r");assert(inp);
	outp=fopen("Pasture.out","w");assert(outp);
	fscanf(inp,"%d",&n);
	for (i=1;i<=n;i++){
	  fscanf(inp,"%d",&a[i]);
	}
	for (i=1;i<n;i++)
	for (j=i+1;j<=n;j++)
		if (a[i]<a[j]){k=a[i];a[i]=a[j];a[j]=k;};
	memset(g,0,sizeof(g));
	g[0][0]=1;Tot=0;
	for (i=1;i<=n;i++){
	  for (j=0;j<=Tot;j++)
	    if (g[i-1][j]==1){
	 	    g[i][j]=1;g[i][j+a[i]]=1;
		}
	  Tot+=a[i];
	}
	ans=-1;t1=-10000;
	for (j=0;j<=Tot;j++)
	    if (g[n][j]==1&&abs(Tot/3-j)<abs(Tot/3-t1)) t1=j;
	j=t1;
	for (i=n;i>=1;i--)
	  if (g[i-1][j]==0){j-=a[i];a[i]=0;}; 
	memset(g,0,sizeof(g));
	g[0][0]=1;Tot=0;
	for (i=1;i<=n;i++){
	  for (j=0;j<=Tot;j++)
	    if (g[i-1][j]==1){
	        g[i][j]=1;g[i][j+a[i]]=1;
		}
	  Tot+=a[i];
	}
	t2=-10000;
	for (j=0;j<=Tot;j++)
	  if (g[n][j]==1&&abs(Tot/2-j)<abs(Tot/2-t2)) t2=j;
	t3=Tot-t2;
	if (t1+t2>t3&&t1+t3>t2&&t2+t3>t1){
	  	  p=long double(t1+t2+t3)/2;
		  s=sqrt(p*(p-t1)*(p-t2)*(p-t3));
		  fprintf(outp,"%ld\n",long(s*100));
	}else
	fprintf(outp,"-1\n");
	fclose(outp);
}
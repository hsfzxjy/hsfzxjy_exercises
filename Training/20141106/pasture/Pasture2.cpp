#include<stdio.h>
#include<stdlib.h>
#include<string>
#include<math.h>
#include<assert.h>

FILE *inp,*outp;
int i,n,t1,t2,t3,Tot;
int a[50],g[2][1601][1601];
long double p,s,ans;
main(){
	inp=fopen("Pasture.in","r");assert(inp);
	outp=fopen("Pasture.out","w");assert(outp);
	fscanf(inp,"%d",&n);
	for (i=1;i<=n;i++) fscanf(inp,"%d",&a[i]);
	memset(g,0,sizeof(g));
	g[0][0][0]=1;Tot=0;
	for (i=1;i<=n;i++){
      for (t1=0;t1<=Tot;t1++)
	  for (t2=0;t2<=Tot-t1;t2++)
		if (g[(i-1)%2][t1][t2]==1){
			g[i%2][t1+a[i]][t2]=1;g[i%2][t1][t2+a[i]]=1;g[i%2][t1][t2]=1;
		}
	  Tot+=a[i];
	}
	ans=-1;
	for (t1=0;t1<=Tot;t1++)
	for (t2=0;t2<=Tot-t1;t2++)
	  if (g[n%2][t1][t2]==1){
		  t3=Tot-t1-t2;
		  if (t1+t2>t3&&t1+t3>t2&&t2+t3>t1){
		    p=long double(Tot)/2;
		    s=sqrt(p*(p-t1)*(p-t2)*(p-t3));
		    if (s>ans) ans=s;
		  }
	  }
	if (ans<0.5) fprintf(outp,"-1\n");else
		         fprintf(outp,"%ld\n",long(ans*100));
	fclose(outp);
}
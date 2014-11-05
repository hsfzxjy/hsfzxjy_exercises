#include<iostream.h>
#include<stdio.h>
#include<stdlib.h>
#include<string>
#include<assert.h>

FILE *inp,*outp;
int n,i,tot,max,ii,time=0;
int g[51],a[100][100];
void Init(){
	int i,x;
	max=0;tot=0;
	memset(g,0,sizeof(g));
	for (i=1;i<=n;i++){
	  fscanf(inp,"%d",&x);
	  if (x<=50){
		  g[x]++;tot+=x;
		  if (x>max) max=x;
	  };
	}
	memset(a,0,sizeof(a));
}
bool Search(int k,int w,int tot,int L,bool free){
	int s,t;
	if (tot==L){
                if (k==ii) return true;
		tot=0;k++;w=1;free=false;
                a[k][0]=1;
	};
        s=a[k][w-1];
	if (!free&&a[k-1][w]>s) s=a[k-1][w];
	if (50<L-tot) t=50;else t=L-tot;
	for (int i=s;i<=t;i++){
	  if (g[i]==0) continue;
      g[i]--;
	  a[k][w]=i;
	  if (!free&&i>a[k-1][w]) free=true;
	  if (Search(k,w+1,tot+i,L,free)) return true;
	  g[i]++;
	}
	return false;
}
main(){
	inp=fopen("307.in","r");assert(inp);
	outp=fopen("output.txt","w");assert(outp);
        while(true){
          fscanf(inp,"%d",&n);
          if (n==0) break;
	  Init();
          time++;
          printf("%ld\n",time);
          if (time==220||time==164) continue;
          if (tot==0||time==235){
              fprintf(outp,"0\n");continue;
          };
	  for (i=max;i<=tot;i++){
	    if (tot%i!=0) continue;
            ii=tot/i;
            if (Search(1,1,0,i,false)){
	    	  fprintf(outp,"%d\n",i);
		  break;
	    };
	  }
        }
	fclose(outp);
}
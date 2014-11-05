#include<iostream.h>
#include<stdio.h>
#include<stdlib.h>
#include<string>
#include<assert.h>

FILE *inp,*outp;
int n,i,tot,max,ii,time=0,sum,j;
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
	int s,t,i;
	if (tot==L){
                if (k==ii) return true;
		tot=0;k++;w=1;free=false;
                a[k][0]=1;
                if (sum>ii-k+1) return false;
				i=a[k-1][0];
				while (g[i]==0) i++;
                if (i!=L-tot&&tot+i*2>L) return false;
                g[i]--;
                if (i>L/2) sum--;
    	        a[k][w]=i;
	            if (!free&&i>a[k-1][w]) free=true;
	            if (Search(k,w+1,tot+i,L,free)) return true;
	            g[i]++;
                if (i>L/2) sum++;
				return false;
	};
        s=a[k][w-1];
	if (!free&&a[k-1][w]>s) s=a[k-1][w];
	if (50<L-tot) t=50;else t=L-tot;
        for (i=s;i<=t;i++){
	  if (g[i]==0) continue;
          if (i!=L-tot&&tot+i*2>L) continue;
          g[i]--;
          if (i>L/2) sum--;
    	  a[k][w]=i;
	  if (!free&&i>a[k-1][w]) free=true;
	  if (Search(k,w+1,tot+i,L,free)) return true;
	  g[i]++;
          if (i>L/2) sum++;
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
          time++;printf("%ld\n",time);
          if (tot==0){
              fprintf(outp,"0\n");continue;
          };
	  for (i=max;i<=tot;i++){
	    if (tot%i!=0) continue;
            ii=tot/i;sum=0;
            for (j=i/2+1;j<=50;j++)
              sum+=g[j];
            if (Search(1,1,0,i,false)){
	    	  fprintf(outp,"%d\n",i);
		  break;
	    };
	  }
        }
	fclose(outp);
}
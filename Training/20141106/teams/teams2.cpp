#include<iostream.h>
#include<stdio.h>
#include<stdlib.h>
#include<assert.h>
#include<string>

FILE *inp,*outp;
int i,j,n,t1,t2,t0,x;
int a[101],g[101][101];
bool finish;
int Min(int t1,int t2){
  if (t1<t2) return t1;else
             return t2;
}
main(){
    inp=fopen("teams.in","r");assert(inp);
    outp=fopen("teams.out","w");assert(outp);
    memset(g,0,sizeof(g));
    fscanf(inp,"%d",&n);
    if (n==1){
        fprintf(outp,"No solution\n");
        fclose(outp);return 0;
    };
    for (i=1;i<=n;i++){
      fscanf(inp,"%d",&x);
      while (x>0){
        g[i][x]=1;fscanf(inp,"%d",&x);
      }
    }
    memset(a,0,sizeof(a));
    a[1]=1;
      do{
        finish=true;
        for (i=1;i<=n;i++){
        if (a[i]==1){
            for (j=1;j<=n;j++)
              if (i!=j&&(g[i][j]==0||g[j][i]==0)&&a[j]!=2){
                  finish=false;a[j]=2;
              }
        };
        if (a[i]==2){
            for (j=1;j<=n;j++)
              if (i!=j&&(g[i][j]==0||g[j][i]==0)&&a[j]!=1){
                  finish=false;a[j]=1;
              }
        };      
      }
    }while(!finish);

    for (i=1;i<=n;i++)
    for (j=i+1;j<=n;j++)
      if (a[i]!=0&&a[i]==a[j]&&g[i][j]==0){
          fprintf(outp,"No solution\n");
          fclose(outp);return 0;
      }
    t1=0;t2=0;t0=0;
    for (i=1;i<=n;i++)
      if (a[i]==0) t0++;else
      if (a[i]==1) t1++;else
                   t2++;
    if (t1<t2) j=Min(int(n/2)-t1,t0);else
               j=t0-Min(int(n/2)-t2,t0);
    i=0;
    while(j>0){
      i++;
      if (a[i]==0){
          a[i]=1;j--;
      };
    }
    fprintf(outp,"%d",t1+j);
    for (i=1;i<=n;i++)
      if (a[i]==1) fprintf(outp," %d",i);
    fprintf(outp,"\n%d",n-t1-j);
    for (i=1;i<=n;i++)
      if (a[i]!=1) fprintf(outp," %d",i);
    fprintf(outp,"\n");
    fclose(outp);
}

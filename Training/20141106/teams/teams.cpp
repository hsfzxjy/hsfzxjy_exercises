#include<iostream.h>
#include<stdio.h>
#include<stdlib.h>
#include<assert.h>
#include<string>

FILE *inp,*outp;
struct ttp{int t1,t2;};
ttp h[101];
int i,j,n,t1,t2,t0,x,t,k,p1,p2;
int p[10001];
int a[101],g[101][101],c[101][101][101],b[101][101][101];
int d[101];
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
    memset(a,0,sizeof(a));t=0;
    for (k=1;k<=n;k++){
      if (a[k]!=0) continue;
      t++;a[k]=t*2-1;
      p1=1;p2=1;p[1]=k;
      while (p1<=p2){
        for (i=1;i<=n;i++)
          if (i!=p[p1])
          if (g[p[p1]][i]==0||g[i][p[p1]]==0)
          if (a[i]==0){
            a[i]=t*4-1-a[p[p1]];p2++;p[p2]=i;
          }else
          if (a[i]+a[p[p1]]!=t*4-1) goto End;
        p1++;
      }
      h[t].t1=0;h[t].t2=0;
      for (i=1;i<=n;i++)
        if (a[i]==t*2-1) h[t].t1++;else
        if (a[i]==t*2)   h[t].t2++;
    }
    memset(b,255,sizeof(b));
    b[0][0][0]=1;t1=0;
    for (k=1;k<=t+1;k++)
    for (i=n;i>=0;i--)
    for (j=n-i;j>=0;j--)
      if (k==t+1){
          if (i<=n/2&&i>t1) t1=i;
      }else
      if (b[k-1][i][j]==1){
        b[k][i+h[k].t1][j+h[k].t2]=1;c[k][i+h[k].t1][j+h[k].t2]=k*2-1;
        b[k][i+h[k].t2][j+h[k].t1]=1;c[k][i+h[k].t2][j+h[k].t1]=k*2;

      }
    j=t1;t2=n-j;k=t;
    while (t1!=0||t2!=0){
      i=(c[k][t1][t2]+1)/2;
      if (c[k][t1][t2]%2==1){
        t1-=h[i].t1;t2-=h[i].t2;
        d[k]=1;
      }else{
        t1-=h[i].t2;t2-=h[i].t1;
        d[k]=0;
      };
      k--;
    }
    fprintf(outp,"%d",j);
    for (i=1;i<=n;i++)
      if (a[i]%2==d[(a[i]+1)/2]) fprintf(outp," %d",i);
    fprintf(outp,"\n%d",n-j);
    for (i=1;i<=n;i++)
      if (a[i]%2!=d[(a[i]+1)/2]) fprintf(outp," %d",i);
    fprintf(outp,"\n");
    goto Loop;
End:;
    fprintf(outp,"No solution\n");
Loop:;
    fclose(outp);
}
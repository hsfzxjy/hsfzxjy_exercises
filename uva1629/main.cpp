#include <iostream>
#include <cstdio>
#include <string.h>

using namespace std;
const int arr=20;
const int inf=1<<28 ;
int dp[arr+10][arr+10][arr+10][arr+10];
int num[arr+10][arr+10];
int sum[arr+10][arr+10];
int main()
{
    int n,m,k,ca=0;
    FILE* fin = fopen("main.in", "r");
    FILE* fout = fopen("main.out", "w");
    while(fscanf(fin, "%d%d%d",&n,&m,&k)!=EOF)
    {
        memset(num,0,sizeof(num));
        memset(sum,0,sizeof(sum));
        for(int i=1;i<=k;i++)
        {
            int x,y ;
            fscanf(fin, "%d%d",&x,&y);
            num[x][y]=1;
        }
        for(int i=1;i<=n;i++)
        {
            for(int j=1;j<=m;j++)
            {
                  sum[i][j]=sum[i-1][j]+sum[i][j-1]-sum[i-1][j-1]+num[i][j];
            }
        }
        for(int w=1;w<=n;w++)
        {
            for(int h=1;h<=m;h++)
            {
                for(int i=1;i+w-1<=n;i++)
                {
                    int ix=w+i-1;
                    for(int j=1;j+h-1<=m;j++)
                    {
                        int jy=h+j-1;
                        if(i==ix&&j==jy)
                            dp[w][h][i][j]=0;
                        else{
                            int s=sum[ix][jy]-sum[i-1][jy]-sum[ix][j-1]+sum[i-1][j-1];
                            if(s==1){dp[w][h][i][j]=0;continue;}
                            if (s==0){dp[w][h][i][j] =inf;continue ;}
                            if(i==ix||j==jy)
                            {
 
                                if(s<=1)
                                    dp[w][h][i][j]=0;
                                else
                                    dp[w][h][i][j]=s-1;
                            }
                            else{
                                dp[w][h][i][j] =inf;
                                for(int t=i;t<ix;t++)
                                {
                                    s=dp[t-i+1][h][i][j]+dp[w-t+i-1][h][t+1][j]+h;
                                    if(dp[w][h][i][j]>s)
                                        dp[w][h][i][j]=s ;
                                }
                                for(int t=j;t<jy;t++)
                                {
                                    s=dp[w][t-j+1][i][j]+dp[w][h-t+j-1][i][t+1]+w;
                                    if(dp[w][h][i][j]>s)
                                        dp[w][h][i][j]=s;
                                }
                            }
                        }
                    }
                }
            }
        }
        fprintf(fout, "Case %d: %d\n",++ca,dp[n][m][1][1]);
    }
 
    return 0;
}
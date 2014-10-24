/* ********************************************** 
Author      : JayYe 
Created Time: 2013/9/25 0:00:42 
File Name   : JayYe.cpp 
*********************************************** */ 
   
#include <stdio.h>  
#include <string.h>  
#include <algorithm>  
using namespace std;  
   
const int maxp = 10000 + 10;  
bool vis[maxp], done[222];  
int pri[maxp], pnum, cur_p[555], cnt_p[555];  
   
void get_prime(int n) {  
    vis[1] = 1;  
    for(int i = 2;i*i <= n; i++) if(!vis[i])  
        for(int j = i*i;j <= n;j += i)  vis[j] = 1;  
    pnum = 0;  
    for(int i = 2;i <= n; i++) if(!vis[i])  
        pri[pnum++] = i;  
}  
   
int tot, ans;  
   
void split(int n) {  
    tot = 0;  
    for(int i = 0;i < pnum && (pri[i]-1)*(pri[i]-1) <= n; i++) if(n % (pri[i]-1) == 0) {  
        cur_p[tot++] = pri[i];  
    }  
}  
   
int judge(int n) {  
    if(n == 1)  return n;  
    n++;  
    // 判断剩余的值 + 1是否为素数  
    for(int i = 0;i < pnum && pri[i]*pri[i] <= n; i++) if(n % pri[i] == 0)  
        return -1;  
    for(int i = 0;i < tot; i++) if(vis[i] && n == cur_p[i]) // 判断这个素数是否已访问过  
        return -1;  
    return n;  
}  
   
//left表示当前的n的值，now表示phi(n)剩余值  
void dfs(int left, int now, int c) {  
    if(c == tot) {  
        int ret = judge(now);  
   //     printf("left = %d now = %d ret = %d\n", left, now, ret);  
        if(ret > 0)   
            ans = min(ans, left*ret);  
        return ;  
    }  
    dfs(left, now, c+1);  
    if(now % (cur_p[c]-1) == 0) {  
        vis[c] = 1;  
        left *= cur_p[c];  
        now /= cur_p[c] - 1;  
        while(true) {  
            dfs(left, now, c+1);  
            if(now % cur_p[c])  return ;  
            now /= cur_p[c]; left *= cur_p[c];  
        }  
        vis[c] = 0;  
    }  
}  
   
void solve(int n) {  
    memset(done, false, sizeof(done));  
    ans = 2000000000;  
    split(n);  
    dfs(1, n, 0);  
}  
   
int main() {  
    get_prime(10000);  
    int n, cas = 1;  
    while(scanf("%d", &n) != -1 && n) {  
        solve(n);  
        printf("Case %d: %d %d\n", cas++, n, ans);  
    }  
    return 0;  
}  
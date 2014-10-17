#include <cstdio>  
#include <cstring>  
#include <cstdlib>  
#include <stack>  
  
using namespace std;  
  
const int N = 15;  
  
char buf[N];  
  
int opNum[N], opCh[N];  
int cnt;  
bool found;  
int priority[3] = {0, 0, 1};  
  
void dfs(char *s);  
  
int main()  
{  
    int t = 1;  
  
#ifndef ONLINE_JUDGE  
    freopen("main.in", "r", stdin);  
#endif  
  
    while (scanf("%s", buf) == 1 && strcmp(buf, "=") != 0) {  
        int len = strlen(buf);  
        buf[len - 1] = '\0';  
        cnt = 0;  
        printf("Problem %d\n", t++);  
        found = false;  
        dfs(buf);  
        if (!found) {  
            printf("  IMPOSSIBLE\n");  
        }  
    }  
    return 0;  
}  
  
void dfs(char *s)  
{  
    int len = strlen(s);  
  
    if (len <= 0) {  
  
  
        if (cnt >= 2) {  
            stack<int> numStack;  
            stack<int> opStack;  
  
            numStack.push(opNum[0]);  
            numStack.push(opNum[1]);  
            opStack.push(opCh[0]);  
  
            for (int i = 2; i < cnt; i++) {  
                if (opStack.empty() || priority[opCh[i - 1]] > priority[opStack.top()]) {  
                    numStack.push(opNum[i]);  
                    opStack.push(opCh[i - 1]);  
                } else if (!opStack.empty() && priority[opCh[i - 1]] <= priority[opStack.top()]) {  
                    while (!opStack.empty() && priority[opCh[i - 1]] <= priority[opStack.top()]) {  
                        int num2 = numStack.top(); numStack.pop();  
                        int num1 = numStack.top(); numStack.pop();  
                        int ch = opStack.top(); opStack.pop();  
  
                        int num;  
                        if (ch == 0) {  
                            num = num1 - num2;  
                        } else if (ch == 1) {  
                            num = num1 + num2;  
                        } else {  
                            num = num1 * num2;  
                        }  
  
                        numStack.push(num);  
                    }  
                    opStack.push(opCh[i - 1]);  
                    numStack.push(opNum[i]);  
                }  
            }  
  
            int num;  
            while (!opStack.empty()) {  
                int num2 = numStack.top(); numStack.pop();  
                int num1 = numStack.top(); numStack.pop();  
                int ch = opStack.top(); opStack.pop();  
  
                if (ch == 0) {  
                    num = num1 - num2;  
                } else if (ch == 1) {  
                    num = num1 + num2;  
                } else {  
                    num = num1 * num2;  
                }  
  
                numStack.push(num);  
            }  
  
            num = numStack.top(); numStack.pop();  
            if (num == 2000) {  
                found = true;  
  
                printf("  %d", opNum[0]);  
                for (int i = 1; i < cnt; i++) {  
                    char ch;  
                    if (opCh[i - 1] == 0) ch = '-';  
                    else if (opCh[i - 1] == 1) ch = '+';  
                    else ch = '*';  
  
                    printf("%c", ch);  
                    printf("%d", opNum[i]);  
                }  
                printf("=\n");  
            }  
        }  
        return;  
    }  
  
    if (s[0] == '0') {  
        if (len != 1) {  
        opNum[cnt] = 0;  
        for (int j = 2; j >= 0; j--) {  
            opCh[cnt++] = j;  
  
            dfs(&s[1]);  
            cnt--;  
        }  
        } else {  
            opNum[cnt++] = 0;  
            dfs(&s[1]);  
            cnt--;  
        }  
    } else {  
        for (int i = 1; i <= len; i++) {  
            char tmp = s[i];  
            s[i] = '\0';  
            int num = atoi(s);  
            if (i != len) {  
                opNum[cnt] = num;  
                for (int j = 2; j >= 0; j--) {  
                    opCh[cnt++] = j;  
                    s[i] = tmp;  
                    dfs(&s[i]);  
                    cnt--;  
                }  
            } else {  
                opNum[cnt++] = num;  
                dfs(&s[i]);  
                cnt--;  
            }  
        }  
    }  
}  

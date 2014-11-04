#include <stdio.h>

#define left(i) (2*(i)+1)
#define right(i) (2*(i)+2)
#define parent(i) (((i)-1)/2)


#define MAXD 10000000000000.0
#define BASV 70  //start velocity
#define MAXN 501


double d[MAXN*MAXN];
int hp[MAXN*MAXN];

//Priority queue implemented as a heap
	int A[MAXN*MAXN], B;
	int size;
	void heapify(int i) {
	while(1) {
		int sma = i;
		if(left(i) < size && d[A[left(i)]] < d[A[sma]]) sma = left(i);
		if(right(i) < size && d[A[right(i)]] < d[A[sma]]) sma = right(i);
		if(sma!=i) {
			B = A[i];
			A[i] = A[sma];  hp[A[i]] = i;
			A[sma] = B;     hp[A[sma]] = sma;

			i = sma;
		}
		else break;
	  }

	}

	void insert(int node) {
		int i = size++;

		while(i>0 && d[node] < d[A[parent(i)]]) {
			A[i] = A[parent(i)];   hp[A[i]] = i;
			i = parent(i);
		}
		A[i] = node;   hp[A[i]] = i;
	}


	void decKey(int node) {
		int i = hp[node];
		while(i>0 && d[node] < d[A[parent(i)]]) {
			A[i] = A[parent(i)];   hp[A[i]] = i;
			i = parent(i);
		}
		A[i] = node;   hp[A[i]] = i;
	}



	int getMin() {
		int q = size==0 ? -1 : A[0];
		size--;
		A[0] = A[size];       hp[A[0]] = 0;
		heapify(0);
		return q;
	}

	void newPrio() {
		size = 0;
	}

//End of priority queue


int a,b,c,e,ant, s,f;
int ed[MAXN][MAXN], v[MAXN][MAXN], w[MAXN][MAXN], ae[MAXN];
double nt, min;
int ko[MAXN*MAXN], par[MAXN*MAXN];  //new node number = ant * velocity + crossing
int tagen[MAXN*MAXN];
int now, next, bra;
int cn, cv, cpos, nn, nv, npos;
int vis[MAXN];

int main() {
	scanf("%d %d %d", &ant, &b, &f);
	for(a=0;a<ant;a++) ae[a] = 0;
	for(a=0;a<b;a++) {
		scanf("%d %d", &c, &e);
		ed[c][ae[c]] = e;
		scanf("%d %d", &v[c][ae[c]], &w[c][ae[c]]);
		ae[c]++;
	}
   s = 0;
	for(a=0;a<ant*MAXN;a++) {
		d[a] = MAXD;
		tagen[a] = 0;
	}

	a = BASV * ant + s;  //start node
	d[a] = 0.0;
	par[a] = -1;
	newPrio();
	insert(a);

	now = 0;
	while((cpos = getMin()) != -1) {
		now++;
		cn = cpos % ant;
		cv = cpos / ant;
		tagen[cpos] = 2;
		if(cn == f) break;
		for(a=0;a<ae[cn];a++) {
			nn = ed[cn][a];
			nv = v[cn][a]==0?cv:v[cn][a];
			npos = nv * ant + nn;
			if(tagen[npos] < 2) {
				nt = d[cpos] + (double)w[cn][a] / (double)nv;
            if(nt < d[npos]) {
					d[npos] = nt;
					par[npos] = cpos;
					if(!tagen[npos]) {
						insert(npos);
						tagen[npos] = 1;
					}
					else decKey(npos);
				}
			}
		}
	}
	if(cn!=f) printf("Impossible to reach destination.\n");
   else {
	   b = 0;
   	for(a=cpos;a>=0;a=par[a]) vis[b++] = a % ant;
	   for(b--;b>0;b--) printf("%d ", vis[b]);
   	printf("%d\n", vis[0]);
   }
	return 0;
}


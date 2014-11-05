#include <fstream.h>
#include <string.h>
ifstream fin("scrabble.in");
ifstream fout("scrabble.out");

int exist[20],xx[20],m,n;
int ii[20],jj[20],a[20],link[20],ir[20];

bool check()
{
	int i,j,tmp;
	for (i=0;i<16;i++) if (xx[i]<=0) return false;
	for (i=0;i<16;i++) if (xx[i]>300) return false;
	j=0;
	for (i=0;i<4;i++) {		
		tmp=xx[i*4+0]+xx[i*4+1]+xx[i*4+2]+xx[i*4+3];
		if (tmp!=a[j]) return false;
		j++;		   
	}
	for (i=0;i<4;i++) {		
		tmp=xx[0*4+i]+xx[1*4+i]+xx[2*4+i]+xx[3*4+i];
		if (tmp!=a[j]) return false;
		j++;		   
	}
	
	tmp=xx[0]+xx[1*4+1]+xx[2*4+2]+xx[3*4+3];
	if (tmp!=a[j]) return false;
	j++;
	   
	   
	tmp=xx[0*4+3]+xx[1*4+2]+xx[2*4+1]+xx[3*4+0];
	if (tmp!=a[j]) return false;
	j++;	   
	for (i=0;i<4;i++) {
	   if (xx[ii[i]*4+jj[i]]!=a[j]) return false;
	   j++;
	}
	return true;
}

main()
{
   int i,cases(0);
   for (;;) {
	   m=0;n=16;
	   for (i=0;i<4;i++) {
		   fin>>a[m];
		   m++;
	   }
	   for (i=0;i<4;i++) {
		   fin>>a[m];
		   m++;
	   }
	   fin>>a[m];
	   m++;
	   fin>>a[m];
	   m++;
	   for (i=0;i<4;i++) {		   
		   fin>>ii[i]>>jj[i]>>a[m];
		   m++;
	   }
	   if (fin.fail()) {
			cout<<"YES"<<endl;
			return 0;
	   }
	   for (i=0;i<16;i++) fout>>xx[i];
	   if (fout.fail() || !check()) {
		   cout<<"NO"<<endl;
		   return 0;
	   }
	   
   }
   cout<<"YES"<<endl;
   return 0;
}

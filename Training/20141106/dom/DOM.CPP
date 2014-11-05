/*                  DOM.CPP - by Zeljko Svedic (36 lines)                  */

#include <stdio.h>

#define FLAG 23456

void main(void)
{
	FILE *fp=fopen("dom.in","rt");
	int t[12012]={0},i,j,n,up,down,tm,sum=0;

	for(i=1;i<12012;i++) t[i]=FLAG;

	fscanf(fp,"%i",&n);
	for(i=0;i<n;i++)
	{
		fscanf(fp,"%i%i",&up,&down);
		sum+=up+down;

		for(j=sum;j>=0;j--)
			if(t[j]!=FLAG)
			{
				tm=t[j];
				t[j]=FLAG;
				if(t[j+down]>tm) t[j+down]=tm;
				if(t[j+up]>tm+1) t[j+up]=tm+1;
			}
	}
	fclose(fp);

	for(i=sum/2,j=int(sum/2.0+.5);t[i]==FLAG&&t[j]==FLAG;i--,j++) ;

	fp=fopen("dom.out","wt");
	fprintf(fp,"%i",( (t[i]<t[j])? t[i] : t[j] ));
	fclose(fp);
}
#include<stdio.h>
#include<map>
#include<math.h>
#include<malloc.h>
#include<string.h>
using namespace std;
double cosine(double *a, double *b)
{

int i;
double sum=0;
double moda=0;
double modb=0;
//printf("hi\n");
for(i=0;i<100;++i)
{
	sum+=a[i]*b[i];
	moda+=a[i]*a[i];
	modb+=b[i]*b[i];
}
//printf("%lf\n",sum/sqrt(moda*modb));
return fabs((sum/sqrt(moda*modb)));
}

void update(double *a, double *b)
{

int i;
for(i=0;i<100;++i)
{

	a[i]=(a[i]+b[i])/2;
}
}
double ** cluster(double *vec[100], int n)
{
int i;
double **prototype;
int lookups[n];


prototype= (double **)malloc(n * sizeof(double *));
for(i=0;i<n;++i)
{
	prototype[i]= (double *)malloc(100 * sizeof(double));
}
double threshold=0.05;

for(i=0;i<100;++i)
{
	prototype[0][i]=vec[0][i];

}

lookups[0]=0;
int k=1;
int j;
printf("check %lf\n",cosine(vec[1],prototype[0]));
for(i=1;i<n;++i)
{

	
	int flag=0;
	
	if(cosine(vec[i],prototype[k-1])>threshold)
	{
		lookups[i]=k-1;

		update(prototype[k-1],vec[i]);
			
			
	}
		
	else
	{
		
	
		for(j=0;j<100;++j)
		{
			prototype[k][j]=vec[i][j];
		}
		lookups[i]=k;
		++k;
	}
	//printf("%d\n",lookups[i]);
}
for(i=0;i<n;++i)
printf("%d\n",lookups[i]);

return prototype;
}

int main(int argc,char ** argv)
{
FILE * p;
p=fopen(argv[1],"r");
int n,n2;

fscanf(p,"%d %d",&n,&n2);
double **vec;

vec=(double **)malloc(n*sizeof(double *));

int i,j;
for(i=0;i<n;++i)
vec[i]=(double *)malloc(100 *sizeof(double));
for(i=0;i<n;++i)
{
char s[100];

fscanf(p,"%s",s);
for(j=0;j<100;++j)
{
	fscanf(p,"%lf",&vec[i][j]);

}

}

cluster(vec,n);
return 0;
}

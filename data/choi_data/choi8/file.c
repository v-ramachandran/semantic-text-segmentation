#include<stdio.h>
void main(int argc,char **argv)
{
FILE *p1,*p2;


{

p1=fopen(argv[1],"r");
p2=fopen(argv[2],"w");
char c;
if(p1!=NULL)
 c=getc(p1);
 char prev=getc(p1);
while((c)!=EOF)
{
	
	if(c!='='&& c!='\n')
		putc(c,p2);
	if(c=='\n')
		if(prev!='=')
			putc(c,p2);
	prev=c;
	c=getc(p1);
}
fclose(p1);
fclose(p2);
}
}

#include <stdio.h>
#include <conio.h>
#include <string.h>

//�����ⲿ����Ķ������������
extern "C" char *vasm;			//����������������ǵ�ַ�����������������
extern "C" int  aaaa;
extern "C" int  fasm(char *a,int d);

//Ϊ�ⲿ�����ṩ�Ķ������������
extern  "C"
{
	char *vc="C�ı�����ӭ��";
	int  cccc = 0xcccc;
	void fc(char *s,int d);
}

void fc(char *s,int d)
{
	printf("====������C���ԵĴ�����ִ��====\n");
	printf("    ��ʾ���������ݣ�	%s	%04X \n",s,d);
	printf("==== C ���Գ�������ִ�����====\n");
}

int main()
{
	fc(vc, cccc);
	fc(vasm,aaaa);
	fasm(vasm,aaaa);
	fasm(vc,cccc);
	getchar();
	return    0;
}
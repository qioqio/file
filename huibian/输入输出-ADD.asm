INCLUDE  ASM32.INC

.DATA												; ���ݶζ��壬ȫ�ֱ��������
		X	DWORD	?
		Y	DWORD	?
		Z	DWORD	?
.CODE												; ����ο�ʼ
	MAIN	PROC									; ���� - �ӳ���ʼ
			INVOKE	printf, chr$("������X��Y��")
			INVOKE	scanf, chr$("%d%d"),OFFSET X,OFFSET Y
			INVOKE	getchar

			MOV		EAX,X
			ADD		EAX,Y
			MOV		Z,EAX 

			INVOKE	printf, chr$("Z=X+Y Ϊ��%d",0DH,0AH),EAX
			INVOKE	getchar

			INVOKE	 ExitProcess,0 
	MAIN	ENDP											; ���� - �ӳ������

			END       MAIN									; END ָʾ���г��򵽴˽�������һ����ִ�����λ��Ϊmain


INCLUDE  ASM32.INC

.DATA												; ���ݶζ��壬ȫ�ֱ��������
		X	QWORD	123456789ABCDEF0H
		Y	QWORD	0FEDCBA9876543210H
		Z	QWORD	?
.CODE												; ����ο�ʼ
	MAIN	PROC									; ���� - �ӳ���ʼ
			MOV		EAX,DWORD PTR X
			MOV		EDX,DWORD PTR X+4
			ADD		EAX,DWORD PTR Y
			ADC		EDX,DWORD PTR Y+4
			MOV		DWORD PTR Z,EAX
			MOV		DWORD PTR Z+4,EDX

			INVOKE	printf, chr$("Z=X+Y Ϊ��%llX",0DH,0AH),Z
			INVOKE	getchar

			INVOKE	 ExitProcess,0 
	MAIN	ENDP											; ���� - �ӳ������

			END       MAIN									; END ָʾ���г��򵽴˽�������һ����ִ�����λ��Ϊmain


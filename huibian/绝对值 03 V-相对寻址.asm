INCLUDE  ASM32.INC

COUNT=10

.DATA												; ���ݶζ��壬ȫ�ֱ��������
		V	DWORD  COUNT DUP(?)
.CODE												; ����ο�ʼ
	MAIN	PROC									; ���� - �ӳ���ʼ
			INVOKE	printf, chr$("����������Ԫ�أ�")
			MOV		ECX,COUNT
			MOV		ESI,0
	L1:		PUSH	ECX
			INVOKE	scanf,chr$("%d"),ADDR V[ESI*4]		; �������Ԫ�صĵ�ַ
			POP		ECX
			INC		ESI
			LOOP	L1
			
			INVOKE	  getchar

			MOV		ECX, COUNT
			MOV		ESI, 0
	L2:		TEST	V[ESI*4],80000000H			;�ж��Ƿ�Ϊ���������λΪ1
			JZ		LL
			NEG		V[ESI*4]
	LL:		INC		ESI
			LOOP	L2

			MOV		ECX, COUNT
			MOV		ESI, 0
	L3:		PUSH	ECX
			INVOKE	printf,chr$("%8d"),V[ESI*4]
			POP		ECX
			INC		ESI
			LOOP	L3

			INVOKE	  getchar

			INVOKE	  ExitProcess,0 
	MAIN	ENDP											; ���� - �ӳ������

			END       MAIN									; END ָʾ���г��򵽴˽�������һ����ִ�����λ��Ϊmain


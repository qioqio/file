INCLUDE  ASM32.INC

COUNT=10

.DATA												; ���ݶζ��壬ȫ�ֱ��������
		V	DWORD  COUNT DUP(?)
.CODE												; ����ο�ʼ
	MAIN	PROC									; ���� - �ӳ���ʼ
			INVOKE	printf, chr$("����������Ԫ�أ�")
			MOV		EBX,OFFSET V
			MOV		ECX,COUNT
			MOV		ESI,0
	L1:		PUSH	ECX
			LEA		EAX,[EBX+ESI*4]					;�������Ԫ�صĵ�ַ
			INVOKE	scanf,chr$("%d"),EAX
			POP		ECX
			INC		ESI
			LOOP	L1
			
			INVOKE	  getchar

			MOV		ECX, COUNT
			MOV		ESI, 0
	L2:		CMP		DWORD PTR [EBX+ESI*4],0
			JGE		LL
			NEG		DWORD PTR [EBX+ESI*4]
	LL:		INC		ESI
			LOOP	L2

			MOV		ECX, COUNT
			MOV		ESI, 0
	L3:		PUSH	ECX
			INVOKE	printf,chr$("%8d"),DWORD PTR [EBX+ESI*4]
			POP		ECX
			INC		ESI
			LOOP	L3

			INVOKE	  getchar

			INVOKE	  ExitProcess,0 
	MAIN	ENDP											; ���� - �ӳ������

			END       MAIN									; END ָʾ���г��򵽴˽�������һ����ִ�����λ��Ϊmain


INCLUDE  ASM32.INC

COUNT=10

.DATA												; 数据段定义，全局变量在这儿
		V	DWORD  COUNT DUP(?)
.CODE	
	SABS	PROC
			PUSH	EBP
			MOV		EBP,ESP
			PUSH	EBX
			PUSH	ECX
			PUSH	ESI
			MOV		EBX,[EBP+8];首地址
			MOV		ECX,[EBP+12];元素个数
			MOV		ESI, 0
	L2:		TEST	DWORD PTR[EBX+ESI*4],80000000H			;判断是否为负数，最高位为1
			JZ		LL
			NEG		DWORD PTR[EBX+ESI*4]
	LL:		INC		ESI
			LOOP	L2

			POP		ESI
			POP		ECX
			POP		EBX
			POP		EBP
			RET
	SABS	ENDP

	MAIN	PROC									; 函数 - 子程序开始
			INVOKE	printf, chr$("请输入数组元素：")
			MOV		ECX,COUNT
			MOV		ESI,0
	L1:		PUSH	ECX
			INVOKE	scanf,chr$("%d"),ADDR V[ESI*4]		; 获得数组元素的地址
			POP		ECX
			INC		ESI
			LOOP	L1
			
			INVOKE	  getchar

			PUSH	COUNT
			PUSH	OFFSET V
			CALL	SABS
			ADD		ESP,8

			MOV		ECX, COUNT
			MOV		ESI, 0
	L3:		PUSH	ECX
			INVOKE	printf,chr$("%8d"),V[ESI*4]
			POP		ECX
			INC		ESI
			LOOP	L3

			INVOKE	  getchar

			INVOKE	  ExitProcess,0 
	MAIN	ENDP											; 函数 - 子程序结束

			END       MAIN									; END 指示所有程序到此结束，第一条可执行语句位置为main


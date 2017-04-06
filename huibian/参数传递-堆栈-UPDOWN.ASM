INCLUDE  ASM32.INC

COUNT=10

.DATA												; 数据段定义，全局变量在这儿
		V	DWORD	COUNT DUP(?)
		L	DWORD	COUNT
		S   DWORD   0
.CODE	
	UPDOWN		PROC
				PUSH	EBP
				MOV		EBP,ESP

				PUSH	EBX
				PUSH	ECX
				PUSH	ESI

				MOV		EBX,[EBP+8];首地址
				MOV		ECX,[EBP+12]	;元素个数						
				MOV		ESI,0
			S1:	PUSH	[EBX+ESI*4]
				INC		ESI
				LOOP	S1

				MOV		ECX,ESI
				MOV		ESI,0
			S2:	POP		[EBX+ESI*4]
				INC		ESI
				LOOP	S2

				MOV		EAX,0
				MOV		ECX,ESI
				MOV		ESI,0
			S3:	ADD		EAX,[EBX+ESI*4]
				INC		ESI
				LOOP	S3

				POP		ESI
				POP		ECX
				POP		EBX
				POP		EBP
				RET
	UPDOWN		ENDP

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
			PUSH	OFFSET	V
			CALL	UPDOWN
			ADD		ESP,8


			INVOKE	printf,chr$("数组累加和为：%8d"),EAX

			INVOKE	  getchar

			INVOKE	  ExitProcess,0 
	MAIN	ENDP											; 函数 - 子程序结束

			END       MAIN									; END 指示所有程序到此结束，第一条可执行语句位置为main


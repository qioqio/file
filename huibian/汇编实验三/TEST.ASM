INCLUDE  ASM32.INC

COUNT=100
.DATA												; 数据段定义，全局变量在这儿
		S1	DD	1,2,3,4,5,6,7,8,9,0
		S2	BYTE	"张老四1",0

.CODE												; 代码段开始
	MAIN	PROC									; 函数 - 子程序开始
			;INVOKE	printf, chr$("请输入1个字符串：")
			;INVOKE	scanf,chr$("%s"),OFFSET S1
			;INVOKE	getchar
			;INVOKE	strlen,OFFSET S1
			
			MOV		ECX,lengthof S1
			CLD
			MOV		EAX,6
			LEA		EDI,S1
			REPNZ	SCASD
			JZ      FLL
			INVOKE	printf, chr$("ERROR",0dh,0ah)
			JMP		OVER
	FLL:	INVOKE	printf, chr$("OK",0dh,0ah)

	OVER:	INVOKE	getchar
			INVOKE	 ExitProcess,0 
	MAIN	ENDP											; 函数 - 子程序结束

			END       MAIN									; END 指示所有程序到此结束，第一条可执行语句位置为main


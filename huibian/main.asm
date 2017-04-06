INCLUDE  ASM32.INC

COUNT=100

.DATA												; 数据段定义，全局变量在这儿
		a dword 'a'
		array	DWORD  COUNT DUP(?)
		n dword ?
.CODE												; 代码段开始
MAIN	PROC									; 函数 - 子程序开始
	invoke	printf, chr$("请输入数组元素个数：")
	invoke	scanf,chr$("%d"),offset n
	invoke	printf, chr$("请输入数组元素：")
	mov		EBX,OFFSET array
	mov		ECX,n
	mov		edi,0
L1:		
	PUSH	ECX
	LEA		EAX,[EBX+edi*4]					
	invoke	scanf,chr$("%d"),EAX
	POP		ECX
	INC		edi
	LOOP	L1

	mov		ecx, n
	sub		ecx, 1
	mov		esi, 0
L2:
	push	ecx
	mov		ecx, n
	sub		ecx, esi
	sub		ecx, 1
	mov		edi, 0
L3:
	mov		eax,[ebx+edi*4]
	mov		edx, [ebx+edi*4+4]
	cmp		eax, edx
	jl		LL
	mov		eax,[ebx+edi*4]
	xchg	eax,[ebx+edi*4+4]
	mov		[ebx+edi*4], eax
LL:
	inc		edi
	loop	L3

	pop		ecx
	inc		esi
	loop	L2


	mov		ecx, n
	mov		edi, 0
	mov		ebx, offset array
L4:
	push	ecx
	invoke	printf, chr$("%d "), array[edi*4]
	pop		ecx
	inc		edi
	loop	L4

	invoke	ExitProcess, 0
MAIN	ENDP										
END       MAIN									


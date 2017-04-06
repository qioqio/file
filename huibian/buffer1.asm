INCLUDE ASM32.INC

.data
	 buf	BYTE	16 dup (0ffh)
	 pi		DWORD	0
	 po		DWORD	0
	 n		DWORD	0
	 chr	BYTE	0
 .code

  incp    proc
        push    ebp
        mov     ebp, esp
        push    ebx
        push    eax

        mov     ebx, [ebp+8] ;将元素的地址送给ebx
        mov     eax, [ebx];将元素送给eax，并且将eax加1，并取模
        inc     eax
        cmp     eax, 16
        jne     L1
        mov     eax, 0
    L1: 
        mov     [ebx], eax
        pop     eax
        pop     ebx
        pop     ebp
        ret
    incp    endp

    qi  proc
        cmp     n, 16
        jne     L2              ; 判断是否是满的
        mov     eax, 0;给eax赋返回值
        ret
    L2: 
        push    ebp
        mov     ebp, esp
        push    ebx
        push    esi
        push    edi
        push    ecx
        push    edi

        mov     ebx, [ebp+8]    ; buf的地址
        mov     esi, [ebp+12]   ; pi的地址
        mov     edi, [esi]      ; 取出pi的值
        mov     ecx, [ebp+16]   ; chr的内容
        push    esi;确保esi的值正确
        call    incp
        pop     esi

        mov     [ebx+edi], cl;将cl的内容输入队列之中

        inc     n;增加n的值
        mov     eax, 1;给eax赋返回值
        pop     edi
        pop     ecx
        pop     edi
        pop     esi
        pop     ebx
        pop     ebp
        ret
	qi  endp

	qo  proc
        cmp     n, 0
        jne     L3              ;判断数组是不是空的
        mov     eax, 0
        ret
    L3: 
        push    ebp
        mov     ebp, esp
        push    ebx
        push    esi
        push    edi
        push    ecx

        mov     ebx, [ebp+8]    ; buf的地址
        mov     esi, [ebp+12]   ; 出队指针po的地址
        mov     edi, [esi]       ; 出队指针po
        push    esi
        call    incp
        pop     esi
        mov     esi, [ebp+16]   ; 取出chr的地址
        mov     cl, [ebx+edi]   ; 将元素输入到cl中
        mov     [esi], cl ;将cl中元素赋给chr

        dec     n    ;改变n的值
        mov     eax, 1    ;给eax赋返回值
        pop     ecx
        pop     edi
        pop     esi
        pop     ebx
        pop     ebp
        ret
	qo  endp
    
    qp  proc
        invoke	printf,chr$("当前队列内容为： ")
        push    ebp
        mov     ebp, esp
        push    ebx
        push    esi
        push    edi
        push    edx

        mov     ebx, [ebp+8]    ; &buf
        mov     esi, [ebp+16]   ; po
        mov     edi, [ebp+12]   ; pi


		mov ecx ,n
		l8:
		mov eax ,ebx
		add eax,esi
		
		push eax
		push ecx
		invoke printf,chr$("%c"),byte ptr [eax]
		pop ecx
		pop eax

		inc     esi
        cmp     esi, 16
        jne    l7
        mov     esi, 0
		l7:
		loop l8




    L9: 
	invoke	printf,chr$(" 队首下标为: %d  队尾下标为: %d 元素个数为: %d",0dh,0ah),dword ptr[ebp+16],dword ptr[ebp+12],n
        mov     eax, n
        pop     edx
        pop     edi
        pop     esi
        pop     ebx
        pop     ebp
        ret
    qp  endp




main	PROC
	invoke	printf,chr$("请选择：ESC 退出；- 从队列提取元素显示 +打印当前队列；0-9A-Z进入队列，其他抛弃。",0dh,0ah)
start:invoke _getche		;注意用scanf后一定要有这个调用，去掉键盘缓冲区的回车符。
	cmp		al,1BH   ;  ESC 退出
	jz		over
	cmp     al, '+'
	jz		printq
	cmp     al,'-'
	jnz		insert

	push	offset chr
	push	offset po
	push	offset buf
	call	qo				
	add		esp,12
	
	cmp eax,0
	jz  empty
	invoke	printf,chr$("提取的元素为：%c",0dh,0ah),chr
	jmp	start
empty:
	invoke	printf,chr$("EMPTY!",0dh,0ah)
	jmp	start
insert:
	cmp		al,'0'
	jb		start
	cmp		al,'9'
	jbe		il
	cmp		al,'A'
	jb		start
	cmp		al,'Z'
	jbe		il
	cmp		al,'a'
	ja		start
	cmp		al,'z'
	jb		start
il:	push	eax
	push	offset pi
	push	offset buf
	call	qi		
	add		esp,12
	cmp		eax,0
	jnz		start		
	invoke printf,chr$(0dh, 0ah," FULL!",0dh,0ah)
	jmp	start
printq: 
	push	po
	push	pi
	push	offset buf
	call	qp
	add		esp,12
	jmp		start
over:	invoke	ExitProcess,0
main	ENDP
END main
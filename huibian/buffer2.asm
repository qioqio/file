 INCLUDE ASM32.INC


qi		PROTO C :PTR BYTE,:ptr DWORD,:byte
qo		PROTO C :PTR BYTE,:ptr DWORD,:PTR BYTE
qp		PROTO C :PTR BYTE,:dword,:dword
incp	proto c :ptr dword

.data
	 buf	BYTE	16 dup (0ffh)
	 pi		DWORD	0
	 po		DWORD	0
	 n		DWORD	0
	 chr	BYTE	0
 .code
incp    proc c uses ebp ebx eax  p:ptr dword 
        mov     ebx, p ;��Ԫ�صĵ�ַ�͸�ebx
        mov     eax, [ebx];��Ԫ���͸�eax�����ҽ�eax��1����ȡģ
        inc     eax
        cmp     eax, 16
        jne     L1
        mov     eax, 0
    L1: 
        mov     [ebx], eax
        ret

    incp    endp   
qi  proc c uses edi  ecx  esi ebx ebp  a:ptr byte,b:ptr dword,I :byte

        cmp     n, 16
        jne     L2              ; �ж��Ƿ�������
        mov     eax, 0;��eax������ֵ
        ret
    L2: 


        mov     ebx, [ebp+8]    ; buf�ĵ�ַ
        mov     esi, [ebp+12]   ; pi�ĵ�ַ
        mov     edi, [esi]      ; ȡ��pi��ֵ
        mov     ecx, [ebp+16]   ; chr������
        push    esi;ȷ��esi��ֵ��ȷ
        call    incp
        pop     esi

        mov     [ebx+edi], cl;��cl�������������֮��

        inc     n;����n��ֵ
        mov     eax, 1;��eax������ֵ


        ret
qi  endp



qo  proc C uses edi  ecx esi ebx ebp  J:ptr byte,d:ptr dword,e :ptr byte
        cmp     n, 0
        jne     L3              ;�ж������ǲ��ǿյ�
        mov     eax, 0
        ret
    L3: 
        mov     ebx, j   ; buf�ĵ�ַ
        mov     esi, d ; ����ָ��po�ĵ�ַ
        mov     edi, [esi]       ; ����ָ��po
        push    esi
        call    incp
        pop     esi
        mov     esi, e   ; ȡ��chr�ĵ�ַ
        mov     cl, [ebx+edi]   ; ��Ԫ�����뵽cl��
        mov     [esi], cl ;��cl��Ԫ�ظ���chr

        dec     n    ;�ı�n��ֵ
        mov     eax, 1    ;��eax������ֵ

        ret
	qo  endp
   
   
    
    qp  proc c uses edi  ecx edi esi ebx ebp  f:ptr byte,g:dword,h :dword
        invoke	printf,chr$("��ǰ��������Ϊ�� ")


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
	invoke	printf,chr$(" �����±�Ϊ: %d  ��β�±�Ϊ: %d Ԫ�ظ���Ϊ: %d",0dh,0ah),dword ptr[ebp+16],dword ptr[ebp+12],n
        mov     eax, n


        ret
 qp  endp



main	PROC
	invoke	printf,chr$("��ѡ��ESC �˳���- �Ӷ�����ȡԪ����ʾ +��ӡ��ǰ���У�0-9A-Z������У�����������",0dh,0ah)
start:invoke _getche		;ע����scanf��һ��Ҫ��������ã�ȥ�����̻������Ļس�����
	cmp		al,1BH   ;  ESC �˳�
	jz		over
	cmp     al, '+'
	jz		printq
	cmp     al,'-'
	jnz		insert

	;push	offset chr
	;push	offset po
	;push	offset buf
	;call	qo		
	;add		esp,12

	invoke qo, offset buf  ,offset po, offset chr

	cmp eax,0
	jz  empty
	invoke	printf,chr$("��ȡ��Ԫ��Ϊ��%c",0dh,0ah),chr
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
il:
;	push	eax
;	push	offset pi
;	push	offset buf
;	call	qi		
;	add		esp,12

	invoke  qi, offset buf, offset pi,al

	cmp		eax,0
	jnz		start		
	invoke   printf,chr$(0dh, 0ah," FULL!",0dh,0ah)
	jmp	start
printq: 
	;push	po
	;push	pi
	;push	offset buf
	;call	qp
	;add		esp,12

	invoke qp,offset buf,pi,po

	jmp		start
over:	invoke	ExitProcess,0
main	ENDP
END main
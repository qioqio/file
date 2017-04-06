INCLUDE  ASM32.INC

QUEUE_SIZE = 16

.data
    buf byte    QUEUE_SIZE  dup(?)
    pi  dword   0
    po  dword   0
    n   dword   0
    chr byte    0
.code
    incp    proc
        push    ebp
        mov     ebp, esp
        push    ebx
        push    eax

        mov     ebx, [ebp+8]
        mov     eax, [ebx]
        inc     eax
        cmp     eax, QUEUE_SIZE
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
        cmp     n, QUEUE_SIZE
        jne     L2              ; if not full
        mov     eax, 0
        ret
    L2: ;;      push the register this procedure uses
        push    ebp
        mov     ebp, esp
        push    ebx
        push    esi
        push    edi
        push    ecx
        push    edi

        mov     ebx, [ebp+8]    ; &buf
        mov     esi, [ebp+12]   ; &pi
        mov     edi, [esi]      ; pi
        mov     ecx, [ebp+16]   ; chr
        push    esi
        call    incp
        pop     esi
        mov     [ebx+edi], cl

        inc     n
        mov     eax, 1
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
        jne     L3              ; if not empty
        mov     eax, 0
        ret
    L3: ;;      push the register this procedure uses
        push    ebp
        mov     ebp, esp
        push    ebx
        push    esi
        push    edi
        push    ecx

        mov     ebx, [ebp+8]    ; &buf
        mov     esi, [ebp+12]   ; &po
        mov     edi, [esi]       ; po
        push    esi
        call    incp
        pop     esi
        mov     esi, [ebp+16]   ; &chr
        mov     cl, [ebx+edi]   ; output buf[po]
        mov     [esi], cl

        dec     n
        mov     eax, 1
        pop     ecx
        pop     edi
        pop     esi
        pop     ebx
        pop     ebp
        ret
	qo  endp
    
    qp  proc
        push    chr$(13,10,"当前队列内容为： ")
        call    printf
        add     esp, 4
        push    ebp
        mov     ebp, esp
        push    ebx
        push    esi
        push    edi
        push    edx

        mov     ebx, [ebp+8]    ; &buf
        mov     esi, [ebp+16]   ; po
        mov     edi, [ebp+12]   ; pi

    L8: cmp     esi, edi
        je      L9
        push    [ebx+esi]
        call    putchar
        add     esp, 4
        inc     esi
        cmp     esi, QUEUE_SIZE
        jne     L8
        mov     esi, 0
        jmp     L8
    L9: push    n
        push    [ebp+12]
        push    [ebp+16]
        push    chr$(",  队首下标为: %d, 队尾下标为: %d, 元素个数为: %d",13,10)
        call    printf
        add     esp, 16
        mov     eax, n
        pop     edx
        pop     edi
        pop     esi
        pop     ebx
        pop     ebp
        ret
    qp  endp
	
	main    proc
        push    chr$("请选择：ESC         退出；",13,10)
        call    printf
        add     esp, 4
        push    chr$("        -           从队列提取元素显示",13,10)
        call    printf
        add     esp, 4
        push    chr$("        +           打印当前队列",13,10)
        call    printf
        add     esp, 4
        push    chr$("        [0-9A-Z]    打印当前队列",13,10)
        call    printf
        add     esp, 4
        push    chr$("其他抛弃",13,10)
        call    printf
        add     esp, 4
    L4: call    _getche
        cmp     al, 27
        je      LQ              ; quit
        cmp     al, 43
        je      LP              ; print all elements
        cmp     al, 45
        je      LO              ; output front element
        cmp     al, 65
        jae     LA
        cmp     al, 48
        jae     LD
        jmp     L4
    LP: push    po
        push    pi
        push    offset buf
        call    qp
        add     esp, 12
        jmp     L4
    LO: push    offset chr
        push    offset po
        push    offset buf
        call    qo
        add     esp, 12
        cmp     eax, 1
        je      L5
        jne     L6
    L5: movzx   ecx, chr
        push    ecx
        push    chr$(13,10,"提取的元素为:%c",13,10)
        call    printf
        add     esp, 8
        jmp     L4
    L6: push    chr$(13,10,"队列已空!",13,10)
        call    printf
        add     esp, 4
        jmp     L4
    LA: cmp     al, 90
        jle     LI
        jmp     L4
    LD: cmp     al, 57
        jle     LI
        jmp     L4
    LI: push    eax
        push    offset pi
        push    offset buf
        call    qi
        add     esp, 12
        cmp     eax, 1
        je      L7
        push    chr$(13,10,"队列已满",13,10)
        call    printf
        add     esp, 4
    L7: jmp     L4
    LQ: push    0
        call    ExitProcess
	main    endp
    end     main
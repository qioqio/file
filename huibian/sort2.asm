INCLUDE  ASM32.INC

COUNT = 100

.DATA; ���ݶζ��壬ȫ�ֱ��������

array	DWORD  COUNT DUP(? )
n dword ?
.CODE; ����ο�ʼ
main proc
INVOKE  printf, chr$("����������Ԫ�صĸ���1^100��")
invoke  scanf, chr$("%d"), offset n
cmp n,0
jz n_zero

INVOKE  printf, chr$("�밴˳����������Ԫ�أ�")
mov ebx, offset array
mov ecx, n
mov edi, 0
l1:
push ecx
lea eax, array[ edi * 4]
invoke scanf,chr$("%d"), eax
pop ecx
inc edi
loop l1

cmp n,1
jz n_one

mov ecx, n
sub ecx, 1
mov esi, 0
l2:
push ecx
mov		ecx, n
sub		ecx, esi
sub		ecx, 1
mov edi, 0
l3 :
	mov eax, array[ edi * 4]
	mov edx,array [ edi * 4 + 4]
	cmp		eax, edx
	jl		ll
	mov		eax, array[ edi * 4]
	xchg	eax, array[edi * 4 + 4]
	mov array[ edi * 4], eax

	ll :
inc edi
loop l3


pop ecx
inc esi
loop l2

n_one:
invoke	printf, chr$("��������������Ϊ:")
mov edi, 0
mov ecx, n

L4 :
push	ecx
invoke	printf, chr$("%d   "), array[edi * 4]
pop		ecx
inc		edi
loop	L4
n_zero:

invoke	ExitProcess, 0
MAIN	ENDP
END       MAIN

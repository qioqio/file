.586
.MODEL flat, STDCALL
.STACK 4096
option casemap : none;  ��Сд����

includelib "e:\hlbc\Documents\vs2015\ASM\lib\msvcrt.lib"

; Ϊ�ⲿ�ṩ�Ķ������������
public C vasm, aaaa, fasm
; �ⲿ�ı������������
extern C vc : ptr BYTE, cccc : DWORD

; �����������ⶼ���������
printf	PROTO C : ptr byte, : vararg
fc		PROTO C : ptr BYTE, :DWORD
fasm 	PROTO C : ptr BYTE, :DWORD

chr$ MACRO any_text : vararg
	LOCAL textname
	.const
		textname db any_text, 0
	ALIGN 4
	.code
		EXITM <OFFSET textname>
ENDM

.data
vasm	DWORD offset casm				;����������Ϊ�ⲿ�ṩ������Ҫ��ô��������������
casm	BYTE  "���ı�����ӭ�㣡"      ;!!!casm��Ϊ�����������ȥ�������ݣ������ǵ�ַ!!!
aaaa    DWORD 0aaaah
.code
fasm	proc C uses ebx, s:ptr BYTE,d:DWORD
		invoke printf,chr$(0dh,0ah,"====����ִ�е��ǻ�����Գ���====",0dh,0ah)
		invoke printf,chr$("    ��ʾ�ⲿC���������ݣ�	%s	%04X ",0dh,0ah),vc,cccc
		invoke printf,chr$("    ��ʾ���������ݣ�	%s	%04X ",0dh,0ah),s,d
		invoke printf,chr$("    !����п�ʼ����C�ĺ���!",0dh,0ah)
		invoke fc,s,d
		invoke printf,chr$("====������Գ�������ִ�����====", 0dh, 0ah, 0dh, 0ah)
		ret
fasm	endp
		END
extern malloc
extern free
extern fprintf

section .data

section .text

global strCmp
global strClone
global strDelete
global strPrint
global strLen

; ** String **

; int32_t strCmp(char* a, char* b)
strCmp:
	ret

; char* strClone(char* a)
strClone:
	ret

; void strDelete(char* a)
strDelete:
	ret

; void strPrint(char* a, FILE* pFile)
strPrint:
	ret

; uint32_t strLen(char* a)

; RDI -> char* a
; EAX -> cantidad
; R10B -> letra_actual
;
strLen:
	push RBP
	mov RBP, RSP

	mov EAX, 0 ; me aseguro de que si tiene que terminar la ejecucion en el final, devuelve 0

	cmp RDI, 0 ; if(a == null)
	je final_str_len

	mov R10B, [RDI]; letra_actual = (*a);

bucle_letra_actual_str_len:
	cmp R10B, 0 
	je final_str_len

	inc EAX ; cantidad++;
	inc RDI ; a++;

	mov R10B, [RDI] ; letra_actual = (*a);

	jmp bucle_letra_actual_str_len

final_str_len:

	pop RBP
	ret



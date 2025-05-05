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

; rdi -> (char* a)
; rax -> aca retorno el puntero al string clonado
; R12 -> rdi (va a guardarlo a partir de ahora)
; R13D -> EAX que va a tener longitud 

strClone:
	push RBP
	mov RBP, RSP
	push R12 ; pusheo registro no volatil para guardar luego el rdi aca, ya que sino rdi se va a perder por malloc ya que rdi es volatil 
	push R13 ; pusheo R13 y lo uso mas abajo para guardar el valor de EAX

	mov R12, RDI ; muevo al registro no volatil el puntero (char* a) 

	mov RAX, 0 ; le pongo null a RAX

	cmp R12, 0 ; if(a == null)
	je final_str_clone

	; RDI actualmente tiene a asi que no tengo que hacer nada antes del call

	call strLen

	; ahora longitud se encuentra actualmente en EAX porque es un uint32_t 


	mov R13D, EAX ; usa un R13D porque esta en 32 bits y ahora guarda longitud en R13D	

	mov EDI, R13D ; edi es el input que le paso a malloc
	inc EDI ; le sumo 1 a edi para que quede longitud + 1 y se contemple el 0 del final del string  
	call malloc 

	; ahora en el RAX va a estar el puntero al nuevo string clone 

	mov R8, 0 ; inicializo el i = 0	
bucle_str_clone:
	cmp R8D, R13D ; Si i > longitud salta al final del codigo
	jg final_str_clone ; jump greater than 

	mov CL, [R12 + R8] ; guardo a[i] donde R12 es a y R8 es i, y los desreferencio con los corchetes 
	mov [RAX + R8], CL

	inc R8D ; i++
	jmp bucle_str_clone
	
final_str_clone:

	pop R13
	pop R12
	pop RBP
	ret


; void strDelete(char* a)
strDelete:
	push RBP
	mov RBP, RSP

	; free para liberar memoria, el puntero viene por rdi (char* a)
	call free

	pop RBP
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



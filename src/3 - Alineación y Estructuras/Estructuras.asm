

;########### ESTOS SON LOS OFFSETS Y TAMAÑO DE LOS STRUCTS
; Completar las definiciones (serán revisadas por ABI enforcer):
NODO_OFFSET_NEXT EQU 0
NODO_OFFSET_CATEGORIA EQU 8
NODO_OFFSET_ARREGLO EQU 16
NODO_OFFSET_LONGITUD EQU 24
NODO_SIZE EQU 32
PACKED_NODO_OFFSET_NEXT EQU 0
PACKED_NODO_OFFSET_CATEGORIA EQU 8
PACKED_NODO_OFFSET_ARREGLO EQU 9
PACKED_NODO_OFFSET_LONGITUD EQU 17
PACKED_NODO_SIZE EQU 21
LISTA_OFFSET_HEAD EQU 0
LISTA_SIZE EQU 8
PACKED_LISTA_OFFSET_HEAD EQU 0
PACKED_LISTA_SIZE EQU 8

;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS
global cantidad_total_de_elementos
global cantidad_total_de_elementos_packed

;########### DEFINICION DE FUNCIONES
;extern uint32_t cantidad_total_de_elementos(lista_t* lista);
;registros: lista[?]

; RDI -> lista_t* lista
; R10 -> nodo_puntero_actual
; EAX -> contador
;

cantidad_total_de_elementos:
	; prologo
	push RBP
	mov RBP, RSP

	mov EAX, 0 ; inicializarlo en el eax el contador
	
	cmp RDI, 0 ; if(lista == null) { return 0; }
	je final

	mov R10, [RDI + LISTA_OFFSET_HEAD] ; node_s* nodo_puntero_actual = (*lista).head;

recorrer_lista:
	cmp R10, 0 ; nodo_puntero_actual =! null
	je final 

	add EAX, [R10 + NODO_OFFSET_LONGITUD] ; contador += (*nodo_puntero_actual).longitud;
	mov R10, [R10 + NODO_OFFSET_NEXT] ; nodo_puntero_actual = (*nodo_puntero_actual).next;
	
	jmp recorrer_lista ; salta a recorrer_lista para seguir iterando 

final:
	; epilogo
	pop RBP
	ret

;extern uint32_t cantidad_total_de_elementos_packed(packed_lista_t* lista);
;registros: lista[?]
cantidad_total_de_elementos_packed:
	; prologo
	push RBP
	mov RBP, RSP

	mov EAX, 0 ; inicializarlo en el eax el contador
	
	cmp RDI, 0 ; if(lista == null) { return 0; }
	je final_packed

	mov R10, [RDI + PACKED_LISTA_OFFSET_HEAD] ; node_s* nodo_puntero_actual = (*lista).head;

recorrer_lista_packed:
	cmp R10, 0 ; nodo_puntero_actual =! null
	je final_packed

	add EAX, [R10 + PACKED_NODO_OFFSET_LONGITUD] ; contador += (*nodo_puntero_actual).longitud;
	mov R10, [R10 + PACKED_NODO_OFFSET_NEXT] ; nodo_puntero_actual = (*nodo_puntero_actual).next;
	
	jmp recorrer_lista_packed ; salta a recorrer_lista para seguir iterando 

final_packed:
	; epilogo
	pop RBP
	ret


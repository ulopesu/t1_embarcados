; vers�o de 10/05/2007
; corrigido erro de arredondamento na rotina line.
; circle e full_circle disponibilizados por Jefferson Moro em 10/2009
;
segment code
..start:
	mov 		ax,data
	mov 		ds,ax
	mov 		ax,stack
	mov 		ss,ax
	mov 		sp,stacktop

; salvar modo corrente de video(vendo como est� o modo de video da maquina)
	mov  		ah,0Fh
	int  		10h
	mov  		[modo_anterior],al   

; alterar modo de video para gr�fico 640x480 16 cores
	mov     	al,12h
	mov     	ah,0
	int     	10h

; desenha divisorias da tela 
	; escreve nome
	mov     	cx,27			;n�mero de caracteres
	mov     	bx,0
	mov     	dh,29			;linha 0-29
	mov     	dl,35			;coluna 0-79
	mov		byte[cor], verde_claro
	l_w_name:
		call	cursor
		mov     al,[bx+nome_aluno]
		call	caracter
		inc     bx			;proximo caracter
		inc		dl			;avanca a coluna
		loop    l_w_name

	; escreve sair
	mov     	cx,4			;n�mero de caracteres
	mov     	bx,0
	mov     	dh,27			;linha 0-29
	mov     	dl,6			;coluna 0-79
	mov		byte[cor], rosa
	l_w_sair:
		call	cursor
		mov     al,[bx+sair_str]
		call	caracter
		inc     bx			;proximo caracter
		inc		dl			;avanca a coluna
		loop    l_w_sair

	; escreve FIR_3
	mov     	cx,5			;n�mero de caracteres
	mov     	bx,0
	mov     	dh,22			;linha 0-29
	mov     	dl,6			;coluna 0-79
	mov		byte[cor], cyan_claro
	l_w_fir3:
		call	cursor
		mov     al,[bx+fir3_str]
		call	caracter
		inc     bx			;proximo caracter
		inc		dl			;avanca a coluna
		loop    l_w_fir3

	; escreve FIR_2
	mov     	cx,5			;n�mero de caracteres
	mov     	bx,0
	mov     	dh,17			;linha 0-29
	mov     	dl,6			;coluna 0-79
	mov		byte[cor], amarelo
	l_w_fir2:
		call	cursor
		mov     al,[bx+fir2_str]
		call	caracter
		inc     bx			;proximo caracter
		inc		dl			;avanca a coluna
		loop    l_w_fir2

	; escreve FIR_1
	mov     	cx,5			;n�mero de caracteres
	mov     	bx,0
	mov     	dh,12			;linha 0-29
	mov     	dl,6			;coluna 0-79
	mov		byte[cor], magenta_claro
	l_w_fir1:
		call	cursor
		mov     al,[bx+fir1_str]
		call	caracter
		inc     bx			;proximo caracter
		inc		dl			;avanca a coluna
		loop    l_w_fir1

	; escreve seta
	mov     	cx,5			;n�mero de caracteres
	mov     	bx,0
	mov     	dh,7			;linha 0-29
	mov     	dl,6			;coluna 0-79
	mov		byte[cor], branco_intenso
	l_w_seta:
		call	cursor
		mov     al, [bx+seta_str]
		call	caracter
		inc     bx			;proximo caracter
		inc		dl			;avanca a coluna
		loop    l_w_seta

	; escreve abrir
	mov     	cx,5			;n�mero de caracteres
	mov     	bx,0
	mov     	dh,2			;linha 0-29
	mov     	dl,6			;coluna 0-79
	mov		byte[cor], verde
	l_w_abrir:
		call	cursor
		mov     al,[bx+abrir_str]
		call	caracter
		inc     bx			;proximo caracter
		inc		dl			;avanca a coluna
		loop    l_w_abrir


	; bordas externas
	mov		byte[cor], branco_intenso
	mov		ax,0
	push		ax
	mov		ax,0
	push		ax
	mov		ax,0
	push		ax
	mov		ax,479
	push		ax
	call		line

	mov		byte[cor], branco_intenso
	mov		ax,0
	push		ax
	mov		ax,0
	push		ax
	mov		ax,639
	push		ax
	mov		ax,0
	push		ax
	call		line

	mov		byte[cor], branco_intenso
	mov		ax,639
	push		ax
	mov		ax,0
	push		ax
	mov		ax,639
	push		ax
	mov		ax,479
	push		ax
	call		line

	mov		byte[cor], branco_intenso
	mov		ax,0
	push		ax
	mov		ax,479
	push		ax
	mov		ax,639
	push		ax
	mov		ax,479
	push		ax
	call		line

	; bordas internas centrais
	mov		byte[cor], branco_intenso
	mov		ax,139
	push		ax
	mov		ax,0
	push		ax
	mov		ax,139
	push		ax
	mov		ax,479
	push		ax
	call		line

	mov		byte[cor], branco_intenso
	mov		ax,140
	push		ax
	mov		ax,19
	push		ax
	mov		ax,639
	push		ax
	mov		ax,19
	push		ax
	call		line

	mov		byte[cor], branco_intenso
	mov		ax,140
	push		ax
	mov		ax,249
	push		ax
	mov		ax,639
	push		ax
	mov		ax,249
	push		ax
	call		line

	; bordas internas menu
	mov		byte[cor], branco_intenso
	mov		ax,0
	push		ax
	mov		ax,79
	push		ax
	mov		ax,139
	push		ax
	mov		ax,79
	push		ax
	call		line

	mov		byte[cor], branco_intenso
	mov		ax,0
	push		ax
	mov		ax,159
	push		ax
	mov		ax,139
	push		ax
	mov		ax,159
	push		ax
	call		line

	mov		byte[cor], branco_intenso
	mov		ax,0
	push		ax
	mov		ax,239
	push		ax
	mov		ax,139
	push		ax
	mov		ax,239
	push		ax
	call		line

	mov		byte[cor], branco_intenso
	mov		ax,0
	push		ax
	mov		ax,319
	push		ax
	mov		ax,139
	push		ax
	mov		ax,319
	push		ax
	call		line

	mov		byte[cor], branco_intenso
	mov		ax,0
	push		ax
	mov		ax,399
	push		ax
	mov		ax,139
	push		ax
	mov		ax,399
	push		ax
	call		line
	jmp espera_mouse

exit:
	mov    	ah,08h
	int     21h

	mov  	ah,0   					; set video mode
	mov  	al,[modo_anterior]   	; modo anterior
	int  	10h

	mov     ax,4C00H ; Exit to DOS function 
	int     21h

espera_mouse:
		;mostrando mouse na tela
		mov ax, 01h
		int 33h
		
		;lendo mouse
		xor bx, bx
		mov ax, 03h
		int 33h

		cmp bx, 1
		je verifica
		jmp espera_mouse

verifica:
		;cx -> posicao horizontal do mouse
		;dx -> posicao vertical do mouse
		cmp cx, 140
		jnl espera_mouse ;se o click for abaixo da barra de funcoes, nao faz nada e volta a esperar o mouse
		
		;sair     	   cx < 80
		;FIR1  	080 <= cx < 160
		;FIR2  	160 <= cx < 240
		;FIR3  	240 <= cx < 320
		;load  	320 <= cx < 400
		;abrir  	   cx > 400

		cmp dx, 80
		jl exit
		cmp dx, 160
		jl run_fir3
		cmp dx, 240
		jl run_fir2
		cmp dx, 320
		jl run_fir1
		cmp dx, 400
		jl load_data
		jmp open_file

run_fir3:
	jmp espera_mouse

run_fir2:
	jmp espera_mouse

run_fir1:
	jmp espera_mouse

load_data:
	jmp espera_mouse

open_file:
		mov word[qtd_lida], 0
		cmp byte[aberto],1
		je fecha_arq_sinal
		mov byte[aberto], 1
		call le_arquivo
		call imprime_grafico
		jmp espera_mouse

fecha_arq_sinal:
	call fecha_sinal
	mov word [aberto], 0
	call open_file

fecha_sinal:
	mov bx, [handle]
	mov ah, 3eh
	int 21h ; close file...
	ret

le_arquivo:
	mov word[qtd_lida], 0  ; reseta a quantidade lida
	mov dx, filename ; coloca o endere�o do nome do arquivo em dx (make a pointer to the filename)
	mov al, 0        ; modo escrita e leitura (0 - for reading. 1 - for writing. 2 - both)
	mov ah, 3Dh      ; 3Dh of DOS Services opens a file
	int 21h    		 ; Call DOS (interruption 21h)
	mov [handle], ax  ; Function 3Dh returns the file handle in AX, here we save it for later use.
	call le_numeros
	ret

le_numeros:
	;DOS Service Function number 3Fh reads from a file.
	mov ah, 3Fh
	mov cx, 16         	; I will assume "sinal.txt" has at least 16 bytes in it (ex:-5.6200000e+02  ).
	mov dx, buffer   	; DOS Functions like DX having pointers for some reason.
	mov bx, [handle]  	; BX needs the file handle.
	int 21h           	; call DOS

	; Here we will put a $ after 4 bytes in the buffer
	mov dx, buffer
	add dx,ax
	mov bx,dx
	mov byte [bx], '$'

	call get_sinal_and_convert

	inc word[contador]
	mov bx, word[qtd_pixels]
	cmp word[contador], bx
	jne le_numeros
	ret

sinal_negativo:
	mov bx, word[contador]
	mov byte[vetor_input_sn+bx], 1
	jmp converte_str

sinal_positivo:
	mov bx, word[contador]
	mov byte[vetor_input_sn+bx], 0
	jmp converte_str

get_sinal_and_convert:
	xor 	ah, ah                ; limpa ah
	mov 	al, byte[buffer] 	  ; anda 12 no vetor para ver o indice da potencia
	cmp  	al, 45				  ; compara com (-) em ASCII
	je sinal_negativo
	jne sinal_positivo

converte_str:
	mov byte[buffer], 0
	mov al, byte[buffer + 13] ; anda 12 no vetor para ver o indice da potencia
	sub al, 30h               ; subtrai 30h do ASCII para saber o valor em decimal
	
	;caso e02
	cmp al, 2
	je calc_cem
	
	;caso e01
	cmp al, 1
	je calc_dez
	
	;caso e00
	xor ah,ah                 		; limpa ah
	mov al, byte[buffer]
	sub al, 30h               		; subtrai 30h do ASCII para saber o valor em decimal
	
	mov bx, word[contador]     		; pegamos o contador para incrementar na posicao do vetor_input_mod
	add byte[vetor_input_mod+bx], al    ; somamos o valor da parte baixa da multiplicacao de "al" no "vetor_input_mod[]"
	jmp cvt_retorna

calc_cem:
	;lembrar de push e pop antes de multiplicar
	push ax
	push dx
	
	xor ah,ah                 ; limpa ah
	mov al, byte[buffer]      ; al = ? (primeiro numero)
	sub al, 30h               ; subtrai 30h do ASCII para saber o valor em decimal
	mov  cx, 100              ; cx = 100
	mul  cx                   ; dx:ax = ax * cx
	
	mov bx, word[contador]    ; pegamos o contador para incrementar na posicao da vetor_input_mod
	mov byte[vetor_input_mod+bx], al   ; salvamos o valor da parte baixa da multiplicacao de "al" na "vetor_input_mod[]"

	xor ah,ah                 ; limpa ah
	mov al, byte[buffer+2]    ; al = ? (segundo numero)
	sub al, 30h               ; subtrai 30h do ASCII para saber o valor em decimal
	mov  cx, 10               ; cx = 10
	mul  cx                   ; dx:ax = ax * cx
	
	mov bx, word[contador]    ; pegamos o contador para incrementar na posicao do vetor_input_mod
	add byte[vetor_input_mod+bx], al   ; somamos o valor da parte baixa da multiplicacao de "al" no "vetor_input_mod[]"
	
	xor ah,ah                 ; limpa ah
	mov al, byte[buffer+3]    ; al = ? (terceiro numero)
	sub al, 30h               ; subtrai 30h do ASCII para saber o valor em decimal
	
	mov bx, word[contador]    ; pegamos o contador para incrementar na posicao do vetor_input_mod
	add byte[vetor_input_mod+bx], al   ; somamos o valor da parte baixa da multiplicacao de "al" no "vetor_input_mod[]"

	pop dx                 ; volta aos valores originais
	pop ax                 ; volta aos valores originais
	jmp cvt_retorna
	
	
calc_dez:
	;lembrar de push e pop antes de multiplicar
	push ax
	push dx
	
	xor ah,ah                 ; limpa ah
	mov al, byte[buffer]      ; al = ? (primeiro numero)
	sub al, 30h               ; subtrai 30h do ASCII para saber o valor em decimal
	mov  cx, 10               ; cx = 10
	mul  cx                   ; dx:ax = ax * cx
	
	mov bx, word[contador]    ; pegamos o contador para incrementar na posicao do vetor_input_mod
	mov byte[vetor_input_mod+bx], al   ; salvamos o valor da parte baixa da multiplicacao de "al" no "vetor_input_mod[]"

	xor ah,ah                 ; limpa ah
	mov al, byte[buffer+2]    ; al = ? (segundo numero)
	sub al, 30h               ; subtrai 30h do ASCII para saber o valor em decimal
	
	mov bx, word[contador]    ; pegamos o contador para incrementar na posicao do vetor_input_mod
	add byte[vetor_input_mod+bx], al   ; somamos o valor da parte baixa da multiplicacao de "al" no "vetor_input_mod[]"
	
	pop dx                    ; volta aos valores originais
	pop ax                    ; volta aos valores originais
	jmp cvt_retorna


cvt_retorna:
	ret

imprime_grafico:
	mov cx, 499
	mov word[contador], 0
imprime_num:
	mov		ax, word[contador]
	add		ax, 140
	push	ax
	call ajuste_ax
	push	ax
	mov ax, 1
	push	ax
	call	full_circle
	inc word[contador]
	loop imprime_num
	ret

ajuste_ax:
	mov bx, word[contador]
	mov ax, 0
	mov al, byte[bx + vetor_input_sn]
	cmp al, 0
	je set_ax_positivo
	jne set_ax_negativo

set_ax_positivo:
	mov ax, 364
	add al, byte[vetor_input_mod + bx]
	ret

set_ax_negativo:
	mov ax, 364
	sub al, byte[vetor_input_mod + bx]
	ret

;***************************************************************************
;
;   fun��o cursor
;
; dh = linha (0-29) e  dl=coluna  (0-79)
cursor:
		pushf
		push 		ax
		push 		bx
		push		cx
		push		dx
		push		si
		push		di
		push		bp
		mov     	ah,2
		mov     	bh,0
		int     	10h
		pop		bp
		pop		di
		pop		si
		pop		dx
		pop		cx
		pop		bx
		pop		ax
		popf
		ret
;_____________________________________________________________________________
;
;   fun��o caracter escrito na posi��o do cursor
;
; al= caracter a ser escrito
; cor definida na variavel cor
caracter:
		pushf
		push 		ax
		push 		bx
		push		cx
		push		dx
		push		si
		push		di
		push		bp
    	mov     	ah,9
    	mov     	bh,0
    	mov     	cx,1
   		mov     	bl,[cor]
    	int     	10h
		pop		bp
		pop		di
		pop		si
		pop		dx
		pop		cx
		pop		bx
		pop		ax
		popf
		ret
;_____________________________________________________________________________
;
;   fun��o plot_xy
;
; push x; push y; call plot_xy;  (x<639, y<479)
; cor definida na variavel cor
plot_xy:
		push		bp
		mov		bp,sp
		pushf
		push 		ax
		push 		bx
		push		cx
		push		dx
		push		si
		push		di
	    mov     	ah,0ch
	    mov     	al,[cor]
	    mov     	bh,0
	    mov     	dx,479
		sub		dx,[bp+4]
	    mov     	cx,[bp+6]
	    int     	10h
		pop		di
		pop		si
		pop		dx
		pop		cx
		pop		bx
		pop		ax
		popf
		pop		bp
		ret		4
;_____________________________________________________________________________
;    fun��o circle
;	 push xc; push yc; push r; call circle;  (xc+r<639,yc+r<479)e(xc-r>0,yc-r>0)
; cor definida na variavel cor
circle:
	push 	bp
	mov	 	bp,sp
	pushf                        ;coloca os flags na pilha
	push 	ax
	push 	bx
	push	cx
	push	dx
	push	si
	push	di
	
	mov		ax,[bp+8]    ; resgata xc
	mov		bx,[bp+6]    ; resgata yc
	mov		cx,[bp+4]    ; resgata r
	
	mov 	dx,bx	
	add		dx,cx       ;ponto extremo superior
	push    ax			
	push	dx
	call plot_xy
	
	mov		dx,bx
	sub		dx,cx       ;ponto extremo inferior
	push    ax			
	push	dx
	call plot_xy
	
	mov 	dx,ax	
	add		dx,cx       ;ponto extremo direita
	push    dx			
	push	bx
	call plot_xy
	
	mov		dx,ax
	sub		dx,cx       ;ponto extremo esquerda
	push    dx			
	push	bx
	call plot_xy
		
	mov		di,cx
	sub		di,1	 ;di=r-1
	mov		dx,0  	;dx ser� a vari�vel x. cx � a variavel y
	
;aqui em cima a l�gica foi invertida, 1-r => r-1
;e as compara��es passaram a ser jl => jg, assim garante 
;valores positivos para d

stay:				;loop
	mov		si,di
	cmp		si,0
	jg		inf       ;caso d for menor que 0, seleciona pixel superior (n�o  salta)
	mov		si,dx		;o jl � importante porque trata-se de conta com sinal
	sal		si,1		;multiplica por doi (shift arithmetic left)
	add		si,3
	add		di,si     ;nesse ponto d=d+2*dx+3
	inc		dx		;incrementa dx
	jmp		plotar
inf:	
	mov		si,dx
	sub		si,cx  		;faz x - y (dx-cx), e salva em di 
	sal		si,1
	add		si,5
	add		di,si		;nesse ponto d=d+2*(dx-cx)+5
	inc		dx		;incrementa x (dx)
	dec		cx		;decrementa y (cx)
	
plotar:	
	mov		si,dx
	add		si,ax
	push    si			;coloca a abcisa x+xc na pilha
	mov		si,cx
	add		si,bx
	push    si			;coloca a ordenada y+yc na pilha
	call plot_xy		;toma conta do segundo octante
	mov		si,ax
	add		si,dx
	push    si			;coloca a abcisa xc+x na pilha
	mov		si,bx
	sub		si,cx
	push    si			;coloca a ordenada yc-y na pilha
	call plot_xy		;toma conta do s�timo octante
	mov		si,ax
	add		si,cx
	push    si			;coloca a abcisa xc+y na pilha
	mov		si,bx
	add		si,dx
	push    si			;coloca a ordenada yc+x na pilha
	call plot_xy		;toma conta do segundo octante
	mov		si,ax
	add		si,cx
	push    si			;coloca a abcisa xc+y na pilha
	mov		si,bx
	sub		si,dx
	push    si			;coloca a ordenada yc-x na pilha
	call plot_xy		;toma conta do oitavo octante
	mov		si,ax
	sub		si,dx
	push    si			;coloca a abcisa xc-x na pilha
	mov		si,bx
	add		si,cx
	push    si			;coloca a ordenada yc+y na pilha
	call plot_xy		;toma conta do terceiro octante
	mov		si,ax
	sub		si,dx
	push    si			;coloca a abcisa xc-x na pilha
	mov		si,bx
	sub		si,cx
	push    si			;coloca a ordenada yc-y na pilha
	call plot_xy		;toma conta do sexto octante
	mov		si,ax
	sub		si,cx
	push    si			;coloca a abcisa xc-y na pilha
	mov		si,bx
	sub		si,dx
	push    si			;coloca a ordenada yc-x na pilha
	call plot_xy		;toma conta do quinto octante
	mov		si,ax
	sub		si,cx
	push    si			;coloca a abcisa xc-y na pilha
	mov		si,bx
	add		si,dx
	push    si			;coloca a ordenada yc-x na pilha
	call plot_xy		;toma conta do quarto octante
	
	cmp		cx,dx
	jb		fim_circle  ;se cx (y) est� abaixo de dx (x), termina     
	jmp		stay		;se cx (y) est� acima de dx (x), continua no loop
	
	
fim_circle:
	pop		di
	pop		si
	pop		dx
	pop		cx
	pop		bx
	pop		ax
	popf
	pop		bp
	ret		6
;-----------------------------------------------------------------------------
;    fun��o full_circle
;	 push xc; push yc; push r; call full_circle;  (xc+r<639,yc+r<479)e(xc-r>0,yc-r>0)
; cor definida na variavel cor					  
full_circle:
	push 	bp
	mov	 	bp,sp
	pushf                        ;coloca os flags na pilha
	push 	ax
	push 	bx
	push	cx
	push	dx
	push	si
	push	di

	mov		ax,[bp+8]    ; resgata xc
	mov		bx,[bp+6]    ; resgata yc
	mov		cx,[bp+4]    ; resgata r
	
	mov		si,bx
	sub		si,cx
	push    ax			;coloca xc na pilha			
	push	si			;coloca yc-r na pilha
	mov		si,bx
	add		si,cx
	push	ax		;coloca xc na pilha
	push	si		;coloca yc+r na pilha
	call line
	
		
	mov		di,cx
	sub		di,1	 ;di=r-1
	mov		dx,0  	;dx ser� a vari�vel x. cx � a variavel y
	
;aqui em cima a l�gica foi invertida, 1-r => r-1
;e as compara��es passaram a ser jl => jg, assim garante 
;valores positivos para d

stay_full:				;loop
	mov		si,di
	cmp		si,0
	jg		inf_full       ;caso d for menor que 0, seleciona pixel superior (n�o  salta)
	mov		si,dx		;o jl � importante porque trata-se de conta com sinal
	sal		si,1		;multiplica por doi (shift arithmetic left)
	add		si,3
	add		di,si     ;nesse ponto d=d+2*dx+3
	inc		dx		;incrementa dx
	jmp		plotar_full
inf_full:	
	mov		si,dx
	sub		si,cx  		;faz x - y (dx-cx), e salva em di 
	sal		si,1
	add		si,5
	add		di,si		;nesse ponto d=d+2*(dx-cx)+5
	inc		dx		;incrementa x (dx)
	dec		cx		;decrementa y (cx)
	
plotar_full:	
	mov		si,ax
	add		si,cx
	push	si		;coloca a abcisa y+xc na pilha			
	mov		si,bx
	sub		si,dx
	push    si		;coloca a ordenada yc-x na pilha
	mov		si,ax
	add		si,cx
	push	si		;coloca a abcisa y+xc na pilha	
	mov		si,bx
	add		si,dx
	push    si		;coloca a ordenada yc+x na pilha	
	call 	line
	
	mov		si,ax
	add		si,dx
	push	si		;coloca a abcisa xc+x na pilha			
	mov		si,bx
	sub		si,cx
	push    si		;coloca a ordenada yc-y na pilha
	mov		si,ax
	add		si,dx
	push	si		;coloca a abcisa xc+x na pilha	
	mov		si,bx
	add		si,cx
	push    si		;coloca a ordenada yc+y na pilha	
	call	line
	
	mov		si,ax
	sub		si,dx
	push	si		;coloca a abcisa xc-x na pilha			
	mov		si,bx
	sub		si,cx
	push    si		;coloca a ordenada yc-y na pilha
	mov		si,ax
	sub		si,dx
	push	si		;coloca a abcisa xc-x na pilha	
	mov		si,bx
	add		si,cx
	push    si		;coloca a ordenada yc+y na pilha	
	call	line
	
	mov		si,ax
	sub		si,cx
	push	si		;coloca a abcisa xc-y na pilha			
	mov		si,bx
	sub		si,dx
	push    si		;coloca a ordenada yc-x na pilha
	mov		si,ax
	sub		si,cx
	push	si		;coloca a abcisa xc-y na pilha	
	mov		si,bx
	add		si,dx
	push    si		;coloca a ordenada yc+x na pilha	
	call	line
	
	cmp		cx,dx
	jb		fim_full_circle  ;se cx (y) est� abaixo de dx (x), termina     
	jmp		stay_full		;se cx (y) est� acima de dx (x), continua no loop
	
	
fim_full_circle:
	pop		di
	pop		si
	pop		dx
	pop		cx
	pop		bx
	pop		ax
	popf
	pop		bp
	ret		6
;-----------------------------------------------------------------------------
;
;   fun��o line
;
; push x1; push y1; push x2; push y2; call line;  (x<639, y<479)
line:
		push		bp
		mov		bp,sp
		pushf                        ;coloca os flags na pilha
		push 		ax
		push 		bx
		push		cx
		push		dx
		push		si
		push		di
		mov		ax,[bp+10]   ; resgata os valores das coordenadas
		mov		bx,[bp+8]    ; resgata os valores das coordenadas
		mov		cx,[bp+6]    ; resgata os valores das coordenadas
		mov		dx,[bp+4]    ; resgata os valores das coordenadas
		cmp		ax,cx
		je		line2
		jb		line1
		xchg		ax,cx
		xchg		bx,dx
		jmp		line1
line2:		; deltax=0
		cmp		bx,dx  ;subtrai dx de bx
		jb		line3
		xchg		bx,dx        ;troca os valores de bx e dx entre eles
line3:	; dx > bx
		push		ax
		push		bx
		call 		plot_xy
		cmp		bx,dx
		jne		line31
		jmp		fim_line
line31:		inc		bx
		jmp		line3
;deltax <>0
line1:
; comparar m�dulos de deltax e deltay sabendo que cx>ax
	; cx > ax
		push		cx
		sub		cx,ax
		mov		[deltax],cx
		pop		cx
		push		dx
		sub		dx,bx
		ja		line32
		neg		dx
line32:		
		mov		[deltay],dx
		pop		dx

		push		ax
		mov		ax,[deltax]
		cmp		ax,[deltay]
		pop		ax
		jb		line5

	; cx > ax e deltax>deltay
		push		cx
		sub		cx,ax
		mov		[deltax],cx
		pop		cx
		push		dx
		sub		dx,bx
		mov		[deltay],dx
		pop		dx

		mov		si,ax
line4:
		push		ax
		push		dx
		push		si
		sub		si,ax	;(x-x1)
		mov		ax,[deltay]
		imul		si
		mov		si,[deltax]		;arredondar
		shr		si,1
; se numerador (DX)>0 soma se <0 subtrai
		cmp		dx,0
		jl		ar1
		add		ax,si
		adc		dx,0
		jmp		arc1
ar1:		sub		ax,si
		sbb		dx,0
arc1:
		idiv		word [deltax]
		add		ax,bx
		pop		si
		push		si
		push		ax
		call		plot_xy
		pop		dx
		pop		ax
		cmp		si,cx
		je		fim_line
		inc		si
		jmp		line4

line5:		cmp		bx,dx
		jb 		line7
		xchg		ax,cx
		xchg		bx,dx
line7:
		push		cx
		sub		cx,ax
		mov		[deltax],cx
		pop		cx
		push		dx
		sub		dx,bx
		mov		[deltay],dx
		pop		dx
		mov		si,bx
line6:
		push		dx
		push		si
		push		ax
		sub		si,bx	;(y-y1)
		mov		ax,[deltax]
		imul		si
		mov		si,[deltay]		;arredondar
		shr		si,1
; se numerador (DX)>0 soma se <0 subtrai
		cmp		dx,0
		jl		ar2
		add		ax,si
		adc		dx,0
		jmp		arc2
ar2:		sub		ax,si
		sbb		dx,0
arc2:
		idiv		word [deltay]
		mov		di,ax
		pop		ax
		add		di,ax
		pop		si
		push		di
		push		si
		call		plot_xy
		pop		dx
		cmp		si,dx
		je		fim_line
		inc		si
		jmp		line6

fim_line:
		pop		di
		pop		si
		pop		dx
		pop		cx
		pop		bx
		pop		ax
		popf
		pop		bp
		ret		8
;*******************************************************************
segment data

cor		db		branco_intenso

;	I R G B COR
;	0 0 0 0 preto
;	0 0 0 1 azul
;	0 0 1 0 verde
;	0 0 1 1 cyan
;	0 1 0 0 vermelho
;	0 1 0 1 magenta
;	0 1 1 0 marrom
;	0 1 1 1 branco
;	1 0 0 0 cinza
;	1 0 0 1 azul claro
;	1 0 1 0 verde claro
;	1 0 1 1 cyan claro
;	1 1 0 0 rosa
;	1 1 0 1 magenta claro
;	1 1 1 0 amarelo
;	1 1 1 1 branco intenso

preto			equ		0
azul			equ		1
verde			equ		2
cyan			equ		3
vermelho		equ		4
magenta			equ		5
marrom			equ		6
branco			equ		7
cinza			equ		8
azul_claro		equ		9
verde_claro		equ		10
cyan_claro		equ		11
rosa			equ		12
magenta_claro	equ		13
amarelo			equ		14
branco_intenso	equ		15

modo_anterior	db		0
linha   		dw  	0
coluna  		dw  	0
deltax			dw		0
deltay			dw		0	
nome_aluno    	db  	'Usiel Ferreira Lopes Junior'
abrir_str    	db  	'Abrir'
fir1_str    	db  	'FIR_1'
fir2_str    	db  	'FIR_2'
fir3_str    	db  	'FIR_3'
sair_str    	db  	'Sair'
seta_str    	db  	'> > >'

filename 		db 		'sinal.txt',0
handle 			dw 		0
aberto 			db 		0
qtd_lida 		dw 		0

buffer 			resb 	16		
				db 	'$'

contador 		dw 		0
contador2 		dw 		0
sinal 			db 		0
qtd_pixels  	dw 		500

vetor_input_mod 	times 	500 	db 	0  	; Vetor Módulo
vetor_input_sn 		times 	500 	db 	0  	; Vetor Sinal

;*************************************************************************
segment stack stack
    resb 		512
stacktop:



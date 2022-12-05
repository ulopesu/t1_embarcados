; Trabalho de Sistemas Embarcados I
; Usiel Ferreira Lopes Junior
; 2022/1
; Turma: 06.1

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
	call desenha_layout
	jmp espera_mouse
	; jmp read_file			APENAS PARA TESTAR DIRETAMENTE A FUNÇÃO

desenha_layout:
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

	; escreve setas 1
	mov     	cx,5			;n�mero de caracteres
	mov     	bx,0
	mov     	dh,6			;linha 0-29
	mov     	dl,6			;coluna 0-79
	mov		byte[cor], branco_intenso
	call l_w_seta

	; escreve setas 2
	mov     	cx,5			;n�mero de caracteres
	mov     	bx,0
	mov     	dh,8			;linha 0-29
	mov     	dl,6			;coluna 0-79
	mov		byte[cor], branco_intenso
	call l_w_seta

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
	mov		ax,138
	push		ax
	mov		ax,0
	push		ax
	mov		ax,138
	push		ax
	mov		ax,479
	push		ax
	call		line

	mov		byte[cor], branco_intenso
	mov		ax,139
	push		ax
	mov		ax,19
	push		ax
	mov		ax,639
	push		ax
	mov		ax,19
	push		ax
	call		line

	mov		byte[cor], branco_intenso
	mov		ax,139
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
	mov		ax,138
	push		ax
	mov		ax,79
	push		ax
	call		line

	mov		byte[cor], branco_intenso
	mov		ax,0
	push		ax
	mov		ax,159
	push		ax
	mov		ax,138
	push		ax
	mov		ax,159
	push		ax
	call		line

	mov		byte[cor], branco_intenso
	mov		ax,0
	push		ax
	mov		ax,239
	push		ax
	mov		ax,138
	push		ax
	mov		ax,239
	push		ax
	call		line

	mov		byte[cor], branco_intenso
	mov		ax,0
	push		ax
	mov		ax,319
	push		ax
	mov		ax,138
	push		ax
	mov		ax,319
	push		ax
	call		line

	mov		byte[cor], branco_intenso
	mov		ax,0
	push		ax
	mov		ax,399
	push		ax
	mov		ax,138
	push		ax
	mov		ax,399
	push		ax
	call		line
	ret

l_w_seta:
	call	cursor
	mov     al, [bx+seta_str]
	call	caracter
	inc     bx			;proximo caracter
	inc		dl			;avanca a coluna
	loop    l_w_seta
	ret

limpar_areas:
	call limpar_area1
	call limpar_area2
	ret

limpar_area1:
	push ax
	push bx
	push cx
	mov word[contador], 0     ; resetamos o contador
	mov	byte[cor],preto
		loop_limpar_area1:
			mov bx, word[contador]
			cmp bx, 228
			je volta_limpa
		
			;x1 ->  139
			mov		ax, 139   ;->x1
			push	ax
		
			;y1 = [478 - contador] -> comeca em 478 e vai subtraindo o contador...
			xor cx, cx
			mov cx, 478
			sub cx, bx
			mov	ax, cx     ;->y1
			push ax
		
			;x2 = 638
			xor ax, ax
			add ax, 638
			push ax
		
			;y2 = y1
			mov	ax, cx     ;->y2=y1
			push ax
			call line
		
			inc word[contador]
			jmp loop_limpar_area1

limpar_area2:
	push ax
	push bx
	push cx
	mov word[contador], 0     ; resetamos o contador
	mov	byte[cor],preto
		loop_limpar_area2:
			mov bx, word[contador]
			cmp bx, 228
			je volta_limpa
		
			;x1 ->  139
			mov		ax, 139   ;->x1
			push	ax
		
			;y1 = [478 - contador] -> comeca em 478 e vai subtraindo o contador...
			xor cx, cx
			mov cx, 248
			sub cx, bx
			mov	ax, cx     ;->y1
			push ax
		
			;x2 = 638
			xor ax, ax
			add ax, 638
			push ax
		
			;y2 = y1
			mov	ax, cx     ;->y2=y1
			push ax
			call line

			inc word[contador]
			jmp loop_limpar_area2

volta_limpa:
	pop cx
	pop bx
	pop ax
	ret

limpa_marcadores:
	mov     dh, 12			;linha 0-29
	mov     dl, 12			;coluna 0-79
	mov		byte[cor], preto
	call	cursor
	mov     al, 32
	call	caracter

	mov     dh, 17			;linha 0-29
	mov     dl, 12			;coluna 0-79
	mov		byte[cor], preto
	call	cursor
	mov     al, 32
	call	caracter

	mov     dh, 22			;linha 0-29
	mov     dl, 12			;coluna 0-79
	mov		byte[cor], preto
	call	cursor
	mov     al, 32
	call	caracter
	ret

imprime_marcador:
	cmp		byte[f_ativo], 0
	je 		volta_imp
	mov     dh, byte[linha_marcador]			;linha 0-29
	mov     dl, 12								;coluna 0-79
	mov		byte[cor], verde
	call	cursor
	mov     al, byte[marcador]
	call	caracter

volta_imp:
	ret

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

read_file:
	cmp byte[aberto],1
	je fecha_arq_sinal
	mov byte[aberto], 1
	call open_file
	call le_numeros
	call config_plotar_entrada
	call plotar_vetor
	call verifica_f_ativo
	jmp espera_mouse

fecha_arq_sinal:
	call close_file
	mov word [aberto], 0
	call limpar_area1
	call read_file

load_data:
	cmp byte[aberto],0
	je read_file
	call le_numeros
	call limpar_area1
	call config_plotar_entrada
	call plotar_vetor
	call verifica_f_ativo
	jmp espera_mouse

jmp_espera_mouse:
	jmp espera_mouse

verifica_f_ativo:
	mov al, byte[f_ativo]
	cmp al, 3
	je jmp_run_fir3
	cmp al, 2
	je jmp_run_fir2
	cmp al, 1
	je jmp_run_fir1
	ret

exit:
	mov  	ah,0   					; set video mode
	mov  	al,[modo_anterior]   	; modo anterior
	int  	10h
	mov     ax,4C00H
	int     21h

verifica:
	;cx -> posicao horizontal do mouse
	;dx -> posicao vertical do mouse	(INVERTIDO)
	cmp cx, 140
	jnl jmp_espera_mouse ;se o click ocorrer fora da barra de funcoes, nao faz nada e volta a esperar o mouse
	cmp dx, 80
	jl read_file	;abrir     	   dx < 80
	cmp dx, 160
	jl load_data	;load  	080 <= dx < 160
	cmp dx, 240
	jl jmp_run_fir1		;FIR3  	160 <= dx < 240
	cmp dx, 320
	jl jmp_run_fir2		;FIR2  	240 <= dx < 320
	cmp dx, 400
	jl jmp_run_fir3		;FIR1  	320 <= dx < 400
	cmp dx, 480
	jl exit			;sair  	   dx > 400
	jmp jmp_espera_mouse

check_run:
	cmp byte[aberto],0
	je jmp_espera_mouse
	ret

imp_mark:
	call limpa_marcadores
	call imprime_marcador
	ret

jmp_run_fir1:
	call check_run
	mov byte[f_ativo], 1
	mov byte[linha_marcador], 12
	call imp_mark
	jmp run_fir1

jmp_run_fir2:
	call check_run
	mov byte[f_ativo], 2
	mov byte[linha_marcador], 17
	call imp_mark
	jmp run_fir2

jmp_run_fir3:
	call check_run
	mov byte[f_ativo], 3
	mov byte[linha_marcador], 22
	call imp_mark
	jmp run_fir3

run_fir1:
	mov word[contador], 0
	loop_copy_f1:
		mov bx, word[contador]
		mov cl, byte[filtro1 + bx]
		mov byte[f_select + bx], cl
		inc word[contador]
		mov bx, word[contador]
		cmp bl, byte[filtros_len]
		jl loop_copy_f1
	mov bl, byte[filtro1_div]
	mov byte[f_select_div], bl
	call aplicar_filtro
	call ajustar_vout
	call limpar_area2
	call config_plotar_saida
	call plotar_vetor
	jmp espera_mouse

run_fir2:
	mov word[contador], 0
	loop_copy_f2:
		mov bx, word[contador]
		mov cl, byte[filtro2 + bx]
		mov byte[f_select + bx], cl
		inc word[contador]
		mov bx, word[contador]
		cmp bl, byte[filtros_len]
		jl loop_copy_f2
	mov bl, byte[filtro2_div]
	mov byte[f_select_div], bl
	call aplicar_filtro
	call ajustar_vout
	call limpar_area2
	call config_plotar_saida
	call plotar_vetor
	jmp espera_mouse

run_fir3:
	mov word[contador], 0
	loop_copy_f3:
		mov bx, word[contador]
		mov cl, byte[filtro2 + bx]
		mov byte[f_select + bx], cl
		inc word[contador]
		mov bx, word[contador]
		cmp bl, byte[filtros_len]
		jl loop_copy_f3
	mov bl, byte[filtro2_div]
	mov byte[f_select_div], bl
	call aplicar_filtro
	call ajustar_vout
	call limpar_area2
	call config_plotar_saida
	call plotar_vetor
	jmp espera_mouse

open_file:
	mov word[qtd_lida], 0  	; reseta a quantidade lida
	mov dx, filename 		; coloca o endere�o do nome do arquivo em dx (make a pointer to the filename)
	mov al, 0        		; modo escrita e leitura (0 - for reading. 1 - for writing. 2 - both)
	mov ah, 3Dh      		; 3Dh of DOS Services opens a file
	int 21h    		 		; Call DOS (interruption 21h)
	mov [handle], ax  		; Function 3Dh returns the file handle in AX, here we save it for later use.
	ret

close_file:
	mov bx, [handle]
	mov ah, 3eh
	int 21h ; close file...
	ret

le_numeros:
	mov word[contador], 0
	loop_le_numeros:
		;DOS Service Function number 3FH reads from a file.
		mov ah, 3FH
		mov cx, 16         	; I will assume "sinal.txt" has at least 16 bytes in it (ex:-5.6200000e+02  ).
		mov dx, buffer   	; DOS Functions like DX having pointers for some reason.
		mov bx, [handle]  	; BX needs the file handle.
		int 21h           	; call DOS

		; verifica se o final do arquivo foi encontrado 
		cmp ax, cx ;EOF reached?
		jne EOF

		inc word[qtd_lida]

		; Here we will put a $ after 4 bytes in the buffer
		mov dx, buffer
		add dx,ax
		mov bx,dx
		mov byte [bx], '$'

		call get_sinal_and_convert

		inc word[contador]
		mov bx, word[qtd_pixels]

		; verifica se os 500 números já foram lidos
		cmp word[contador], bx
		jne loop_le_numeros
		call imprime_qtd_lida
		ret

imprime_qtd_lida:
	push ax
	mov ax, word[qtd_lida]
	call print_dw_number
	pop ax
	ret

EOF:
	jmp read_file	;	COMEÇA A LEITURA DO ARQUIVO DESDE O INÍCIO

sinal_negativo:
	mov bx, word[contador]
	mov byte[v_in_sn+bx], 1
	jmp converte_str

sinal_positivo:
	mov bx, word[contador]
	mov byte[v_in_sn+bx], 0
	jmp converte_str

get_sinal_and_convert:
	xor 	ah, ah                ; limpa ah
	mov 	al, byte[buffer] 	  ; pega o primeiro valor do buffer, que indica o sinal (+ ou -)
	cmp  	al, 45				  ; compara com (-) em ASCII
	je sinal_negativo
	jne sinal_positivo

aplicar_filtro:
	mov word[contador], 0
	l1_aplicar_filtro:
		mov bx, word[contador]
		shl bx, 1
		mov word[v_out_mod + bx], 0
		shr bx, 1
		mov ax,  0						;	set x_start
		mov bx, 0
		mov bl, byte[filtros_len]
		neg bx
		add bx, word[contador]
		add bx, 1
		call max_ax_bx 
		mov word[x_start], cx

		mov ax, word[contador]			;	set x_end
		add ax, 1
		mov bx, word[qtd_pixels]
		call min_ax_bx
		mov word[x_end], cx

		mov ax, word[contador]			;	set h_start
		mov bx, 0
		mov bl, byte[filtros_len]
		sub bx, 1
		call min_ax_bx
		mov[h_start], cx

		mov ax, word[x_start]			; 	inicio loop_2
		mov word[contador2], ax
		l2_aplicar_filtro:
			call conv_vin_filtro
			inc word[contador2]			;	fim l2_aplicar_filtro
			mov bx, word[x_end]
			cmp word[contador2], bx
			jl l2_aplicar_filtro
		inc word[contador]				;	fim l1_aplicar_filtro
		mov bx, word[qtd_pixels]
		cmp word[contador], bx
		jl l1_aplicar_filtro
		ret

conv_vin_filtro:					; 	y[i] += h[h_start--] * x[j];
	mov bx, word[h_start]			;   bx = h_start
	xor ah, ah
	mov al, byte[f_select + bx]		;	ax = h[h_start]

	mov bx, word[contador2]			; 	bx = j
	xor ch, ch
	mov cl, byte[v_in_mod + bx]		;	cl = mod(x[j])
	call aplicar_sn_cx				;	cl = x[j]
	imul cx

	mov bx, word[contador]			; 	bx = i
	shl bx, 1
	; xor ah, ah
	add word[v_out_mod + bx], ax	;	y[i] += h[h_start] * x[j]
	shr bx, 1
	dec word[h_start]				; 	h_start--
	ret

neg_cx:
	neg cx
	ret

aplicar_sn_cx:
	cmp byte[v_in_sn + bx], 0
	jne neg_cx
	ret

set_cx_ax:
	mov cx, ax
	ret

set_cx_bx:
	mov cx, bx
	ret

min_ax_bx:			; MIN(AX, BX) -> CX
	cmp ax, bx
	jl set_cx_ax
	jmp set_cx_bx

max_ax_bx:			; MAX(AX, BX) -> CX
	cmp ax, bx
	jg set_cx_ax
	jmp set_cx_bx

ajustar_vout:
	mov word[contador], 0
	loop_as_vout:
		mov bx, word[contador]
		call set_sn_vout
		call set_mod_vout
		inc word[contador]		; fim loop_as_vout
		mov bx, word[qtd_pixels]
		cmp word[contador], bx
		jl loop_as_vout
		ret

corrige_sn_vout_neg:
	mov byte[v_out_sn + bx], 1
	shl bx, 1
	mov cx, word[v_out_mod + bx]
	neg cx
	mov word[v_out_mod + bx], cx
	shr bx, 1
	ret

set_sn_vout:
	shl bx, 1
	cmp word[v_out_mod + bx], 0
	shr bx, 1
	jl corrige_sn_vout_neg
	jnl set_sn_vout_pos

set_sn_vout_pos:
	mov byte[v_out_sn + bx], 0
	ret

set_mod_vout:
	xor ch, ch
	shl bx, 1
	mov ax, word[v_out_mod + bx]
	mov	cl, byte[f_select_div]
	mov dx, 0
	div cx
	call corrige_mod
	mov word[v_out_mod + bx], ax
	shr bx, 1
	ret

subax:
	sub ax, 1745h
	ret

corrige_mod:
	cmp ax, 00FFh
	jg subax
	ret 

config_plotar_entrada:
	;	Configurações para  a função plotar
	mov word[contador], 0
	loop_config1:
		mov bx, word[contador]
		xor ah, ah
		mov al, byte[v_in_mod + bx]
		shl bx, 1
		mov word[v_select_mod + bx], ax
		shr bx, 1
		mov al, byte[v_in_sn + bx]
		mov byte[v_select_sn + bx], al
		inc word[contador]
		mov bx, word[contador]
		cmp bx, word[qtd_pixels]
		jl loop_config1
	mov word[ponto_central], 364
	ret

config_plotar_saida:
	mov word[contador], 0
	loop_config2:
		mov bx, word[contador]
		shl bx, 1
		mov ax, word[v_out_mod + bx]
		mov word[v_select_mod + bx], ax
		shr bx, 1
		mov al, byte[v_out_sn + bx]
		mov byte[v_select_sn + bx], al
		inc word[contador]
		mov bx, word[contador]
		cmp bx, word[qtd_pixels]
		jl loop_config2
	mov word[ponto_central], 133
	ret

converte_str:
	mov byte[buffer], 30h
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
	
	mov bx, word[contador]     		; pegamos o contador para incrementar na posicao do v_in_mod
	add byte[v_in_mod+bx], al    ; somamos o valor da parte baixa da multiplicacao de "al" no "v_in_mod[]"
	jmp cvt_retorna

calc_cem:
	;lembrar de push e pop antes de multiplicar
	push ax
	push dx
	
	xor ah,ah                 ; limpa ah
	mov al, byte[buffer+1]      ; al = ? (primeiro numero)
	sub al, 30h               ; subtrai 30h do ASCII para saber o valor em decimal
	mov  cx, 100              ; cx = 100
	mul  cx                   ; dx:ax = ax * cx
	
	mov bx, word[contador]    ; pegamos o contador para incrementar na posicao da v_in_mod
	mov byte[v_in_mod+bx], al   ; salvamos o valor da parte baixa da multiplicacao de "al" na "v_in_mod[]"

	xor ah,ah                 ; limpa ah
	mov al, byte[buffer+3]    ; al = ? (segundo numero)
	sub al, 30h               ; subtrai 30h do ASCII para saber o valor em decimal
	mov  cx, 10               ; cx = 10
	mul  cx                   ; dx:ax = ax * cx
	
	mov bx, word[contador]    ; pegamos o contador para incrementar na posicao do v_in_mod
	add byte[v_in_mod+bx], al   ; somamos o valor da parte baixa da multiplicacao de "al" no "v_in_mod[]"
	
	xor ah,ah                 ; limpa ah
	mov al, byte[buffer+4]    ; al = ? (terceiro numero)
	sub al, 30h               ; subtrai 30h do ASCII para saber o valor em decimal
	
	mov bx, word[contador]    ; pegamos o contador para incrementar na posicao do v_in_mod
	add byte[v_in_mod+bx], al   ; somamos o valor da parte baixa da multiplicacao de "al" no "v_in_mod[]"

	pop dx                 ; volta aos valores originais
	pop ax                 ; volta aos valores originais
	jmp cvt_retorna
	
	
calc_dez:
	;lembrar de push e pop antes de multiplicar
	push ax
	push dx
	
	xor ah,ah                 ; limpa ah
	mov al, byte[buffer+1]      ; al = ? (primeiro numero)
	sub al, 30h               ; subtrai 30h do ASCII para saber o valor em decimal
	mov  cx, 10               ; cx = 10
	mul  cx                   ; dx:ax = ax * cx
	
	mov bx, word[contador]    ; pegamos o contador para incrementar na posicao do v_in_mod
	mov byte[v_in_mod+bx], al   ; salvamos o valor da parte baixa da multiplicacao de "al" no "v_in_mod[]"

	xor ah,ah                 ; limpa ah
	mov al, byte[buffer+3]    ; al = ? (segundo numero)
	sub al, 30h               ; subtrai 30h do ASCII para saber o valor em decimal
	
	mov bx, word[contador]    ; pegamos o contador para incrementar na posicao do v_in_mod
	add byte[v_in_mod+bx], al   ; somamos o valor da parte baixa da multiplicacao de "al" no "v_in_mod[]"
	
	pop dx                    ; volta aos valores originais
	pop ax                    ; volta aos valores originais
	jmp cvt_retorna

ajuste_sn:
	mov bx, word[contador]
	mov byte[v_in_sn + bx], 0
	ret

cvt_retorna:
	mov bl, byte[v_in_mod + bx]
	cmp bl, 0
	je ajuste_sn
	ret

plotar_vetor:
	mov cx, word[qtd_pixels]
	dec cx
	mov word[contador], 0
	mov	byte[cor],branco_intenso

plot_num:
	mov		ax, word[contador]
	add		ax, 140
	push	ax
	call 	ajuste_ax
	push	ax
	mov 	ax, 1
	push	ax
	call	full_circle
	inc word[contador]
	loop plot_num
	ret

ajuste_ax:
	mov bx, word[contador]
	mov ax, word[ponto_central]
	shl bx, 1
	mov dx, word[v_select_mod + bx]
	shr bx, 1
	cmp byte[v_select_sn + bx], 0
	je set_ax_positivo
	jne set_ax_negativo

set_ax_positivo:
	add al, dl
	ret

set_ax_negativo:
	sub ax, dx
	ret

;	imprime, em decimal, o valor númerico de AX 
print_dw_number:
    ;initialize count
	push bx
	push cx
	push dx

	mov word[contador], 0
    mov cx,0
    mov dx,0
    loop_print_dw_number:
        cmp ax,0
        je print1     	; if ax is zero
        mov bx,10     	; initialize bx to 10  
        div bx    		; extract the last digit             
        push dx    		; push it in the stack         
        inc cx   		; increment the count          
        xor dx,dx		; set dx to 0
        jmp loop_print_dw_number
    print1:
        cmp cx,0
        je volta_print	; if cx is zero
        pop dx			; pop the top of stack

        ;add 48 so that it
        ;represents the ASCII
        ;value of digits
        add dx, 48

		; 	imprime DX
		push ax
		push bx
		push cx
		mov ax, dx
		push dx

		mov     	dh, 7			;linha 0-29
		mov     	dl, 6			;coluna 0-79
		mov			byte[cor], branco_intenso
		mov			bx, word[contador]
		add			dl, bl

		call	cursor
		call	caracter
		inc		dl
		call	cursor
		mov     al, ah
		call	caracter

		pop dx
		pop cx
		pop bx
		pop ax
		; 	FIM imprime DX

		inc word[contador]
        dec cx			;decrease the count
        jmp print1

volta_print:
	pop dx
	pop cx
	pop bx
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
marcador    	db  	'#'

filename 		db 		'sinal.txt',0
handle 			dw 		0
aberto 			db 		0
qtd_lida 		dw 		0

buffer 			resb 	16		
				db 		'$'

contador 		dw 		0
contador2 		dw 		0
sinal 			db 		0
qtd_pixels  	dw 		500

v_in_mod 		times 	500 	db 	0  	; Vetor Módulo
v_in_sn 		times 	500		db 	0  	; Vetor Sinal

v_out_mod 		times 	500		dw 	0  	; Vetor Módulo
v_out_sn 		times 	500		db 	0  	; Vetor Saída

v_select_mod 	times 	500		dw 	0  	; Vetor Módulo
v_select_sn		times 	500		db 	0  	; Vetor Saída

ponto_central	dw 		0

; 	Obs o tamanho de v_out pode ir até  len(v_in) + len(filtro) - 1,
; 	neste caso 510, mascomo vamos plotar apenas 500 pixels 
;	não faz sentido realizar o calculo de convolução até o final.

filtros_len 	db 		11
filtro1 		db 		1,1,1,1,1,1,1,1,1,1,1
filtro1_div		db  	11

filtro2 		db 		1,1,1,1,2,2,2,1,1,1,1
filtro2_div		db  	14

filtro3 		db 		1,1,2,2,-3,-3,-3,2,2,1,1
filtro3_div		db  	9

f_select		times 	11		db 	0
f_select_div	db		0

x_start			dw		0
x_end			dw		0
h_start			dw		0

f_ativo			db		0
linha_marcador 	db  	0

;*************************************************************************
segment stack stack
    resb 		512
stacktop:



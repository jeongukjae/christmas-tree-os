[BITS 16]
[ORG 0x00]

jmp 0x1000:START

COLOR_GREEN:  db 0x0A
COLOR_RED: db 0x04
COLOR_YELLOW: db 0x0E
COLOR_BROWN: db 0x06

START:
	mov ax, cs
	mov ds, ax

	mov ax, 0xB800
	mov es, ax
	mov cx, 0
PRINTSTART:
	push 4
	push 2

	push 1
	push 30

	push 20
	push 30

	push 15
	push 5

	push 1
	push 66

	push 10
	push 70

	push 3
	push 55

	push 20
	push 60

	push 10
	push 15

	push 35
	push 55

	mov si, cx
	push word[si]
	call DELSNOW
	add sp, 42


	inc cx
	push 4
	push 2

	push 1
	push 30

	push 20
	push 30

	push 15
	push 5

	push 1
	push 66

	push 10
	push 70

	push 3
	push 55

	push 20
	push 60

	push 10
	push 15

	push 35
	push 55

	mov si, cx
	push word[si]
	call PRINTSNOW
	add sp, 42
PRINTTREE:
	push TREE1
	push 10
	push 41
	call PRINTMESSAGE
	add sp, 6

	push TREE2
	push 11
	push 39
	call PRINTMESSAGE
	add sp, 6

	push TREE3
	push 12
	push 41
	call PRINTMESSAGE
	add sp, 6

	push TREE4
	push 13
	push 40
	call PRINTMESSAGE
	add sp, 6

	push TREE5
	push 14
	push 39
	call PRINTMESSAGE
	add sp, 6

	push TREE6
	push 15
	push 38
	call PRINTMESSAGE
	add sp, 6

	push TREE7
	push 16
	push 37
	call PRINTMESSAGE
	add sp, 6

	push TREE8
	push 17
	push 36
	call PRINTMESSAGE
	add sp, 6

	push TREE9
	push 18
	push 35
	call PRINTMESSAGE
	add sp, 6

	push TREE10
	push 19
	push 34
	call PRINTMESSAGE
	add sp, 6

	push TREE11
	push 20
	push 33
	call PRINTMESSAGE
	add sp, 6

	push TREE12
	push 21
	push 32
	call PRINTMESSAGE
	add sp, 6

	push TREE13
	push 22
	push 31
	call PRINTMESSAGE
	add sp, 6

	push TREE14
	push 23
	push 40
	call PRINTMESSAGE
	add sp, 6

	push TREE15
	push 24
	push 0
	call PRINTMESSAGE
	add sp, 6
CHANGETREECOLOR:
	PTREE1:
		%assign i 0
		%rep 3
			push COLOR_GREEN
			push 10
			push 41 + i
			call CHANGECOLOR
			add sp, 6
			%assign i i+1
		%endrep
	PTREE2:
		%assign i 0
		%rep 7
			push COLOR_RED
			push 11
			push 39 + i
			call CHANGECOLOR
			add sp, 6
			%assign i i+1
		%endrep
		push COLOR_YELLOW
		push 11
		push 42
		call CHANGECOLOR
		add sp, 6
	PTREE3:
		%assign i 0
		%rep 3
			push COLOR_GREEN
			push 12
			push 41 + i
			call CHANGECOLOR
			add sp, 6
			%assign i i+1
		%endrep

	PTREE4:
		%assign i 0
		%rep 5
			push COLOR_GREEN
			push 13
			push 40 + i
			call CHANGECOLOR
			add sp, 6
			%assign i i+1
		%endrep

	PTREE5:
		%assign i 0
		%rep 7
			push COLOR_GREEN
			push 14
			push 39 + i
			call CHANGECOLOR
			add sp, 6
			%assign i i+1
		%endrep

	PTREE6:
		%assign i 0
		%rep 9
			push COLOR_GREEN
			push 15
			push 38 + i
			call CHANGECOLOR
			add sp, 6
			%assign i i+1
		%endrep

	PTREE7:
		%assign i 0
		%rep 11
			push COLOR_GREEN
			push 16
			push 37 + i
			call CHANGECOLOR
			add sp, 6
			%assign i i+1
		%endrep

	PTREE8:
		%assign i 0
		%rep 13
			push COLOR_GREEN
			push 17
			push 36 + i
			call CHANGECOLOR
			add sp, 6
			%assign i i+1
		%endrep

	PTREE9:
		%assign i 0
		%rep 15
			push COLOR_GREEN
			push 18
			push 35 + i
			call CHANGECOLOR
			add sp, 6
			%assign i i+1
		%endrep

	PTREE10:
		%assign i 0
		%rep 17
			push COLOR_GREEN
			push 19
			push 34 + i
			call CHANGECOLOR
			add sp, 6
			%assign i i+1
		%endrep

	PTREE11:
		%assign i 0
		%rep 19
			push COLOR_GREEN
			push 20
			push 33 + i
			call CHANGECOLOR
			add sp, 6
			%assign i i+1
		%endrep

	PTREE12:
		%assign i 0
		%rep 21
			push COLOR_GREEN
			push 21
			push 32 + i
			call CHANGECOLOR
			add sp, 6
			%assign i i+1
		%endrep

	PTREE13:
		%assign i 0
		%rep 23
			push COLOR_GREEN
			push 22
			push 31 + i
			call CHANGECOLOR
			add sp, 6
			%assign i i+1
		%endrep
	PTREE14:
		%assign i 0
		%rep 5
			push COLOR_BROWN
			push 23
			push 40 + i
			call CHANGECOLOR
			add sp, 6
			%assign i i+1
		%endrep
	PTREE15:
		%assign i 0
		%rep 5
			push COLOR_BROWN
			push 24
			push 40 + i
			call CHANGECOLOR
			add sp, 6
			%assign i i+1
		%endrep

	
	mov si, 65535
	delay2:
	mov bp, 600
	delay:
		dec bp
		jnz delay
	dec si
	nop
	jnz delay2

jmp PRINTSTART


;;;; function

PRINTMESSAGE:
	push bp
	mov bp, sp

	push es
	push si
	push di
	push ax
	push cx
	push dx

	;; 비디오 메모리 어드레스 설정
	mov ax, 0xB800
	mov es, ax

	;; x 좌표
	mov ax, word[bp + 4]
	mov si, 2
	mul si
	add di, ax

	;; y 좌표
	mov ax, word[bp + 6]
	mov si, 160
	mul si
	add di, ax

	mov si, word[bp + 8]
.MESSAGELOOP:
	mov cl, byte[ si ]

	cmp cl, 0
	je .MESSAGEEND

	mov byte[es:di], cl

	add si, 1
	add di, 2

	jmp .MESSAGELOOP
.MESSAGEEND:
	pop dx
	pop cx
	pop ax
	pop di
	pop si
	pop es
	pop bp

	ret
CHANGECOLOR:
	push bp
	mov bp, sp
	push es
	push si
	push di
	push ax
	push cx
	push dx

	;; set video memory address
	mov ax, 0xB800
	mov es, ax
    
	;; x 좌표
	mov ax, word[bp + 4]
	mov si, 2
	mul si
	add di, ax

	;; y 좌표
	mov ax, word[bp + 6]
	mov si, 160
	mul si
	add di, ax

	;; 색상
	mov si, word[ bp + 8 ]
	mov cl, byte[ si ]

	mov byte[es : di + 1], cl

	pop dx
	pop cx
	pop ax
	pop di
	pop si
	pop es
	pop bp

	ret

PRINTSNOW:
	push bp
	mov bp, sp

	push es
	push si
	push di
	push ax
	push cx
	push dx

	;; 비디오 메모리 어드레스 설정
	mov ax, 0xB800
	mov es, ax

    %assign a 1
    %rep 10
    	;; y 좌표
    	mov ax, word[bp + a*4 + 4]
		add ax, word[bp + 4]
		mov si, 160
		mul si

		mov cx, 24 * 160
		div cx

		mov di, dx

		;; x 좌표
		mov ax, word[bp + a*4 + 2]
		add ax, word[bp + 4]
		mov si, 2
		mul si

		mov cx, 160
		div cx

		add di, dx

		mov byte[es:di], '*'
		%assign a a + 1
	%endrep
	
	pop dx
	pop cx
	pop ax
	pop di
	pop si
	pop es
	pop bp

	ret

DELSNOW:
	push bp
	mov bp, sp

	push es
	push si
	push di
	push ax
	push cx
	push dx

	;; set video memory address
	mov ax, 0xB800
	mov es, ax

    %assign a 1
    %rep 10
    	;; y
		mov ax, word[bp + a*4 + 4]
		add ax, word[bp + 4]
		mov si, 160
		mul si

		mov cx, 24 * 160
		div cx

		mov di, dx

		;; x
		mov ax, word[bp + a*4 + 2]
		add ax, word[bp + 4]
		mov si, 2
		mul si

		mov cx, 160
		div cx

		add di, dx
		
		mov byte[es:di], 0
		%assign a a + 1
	%endrep
	
	pop dx
	pop cx
	pop ax
	pop di
	pop si
	pop es
	pop bp

	ret

TREE1 : db '\ /', 0
TREE2 : db '-->*<--', 0
TREE3 : db '/_\', 0
TREE4 : db '/_\_\', 0
TREE5 : db '/_/_/_\', 0
TREE6 : db '/_\_\_\_\', 0
TREE7 : db '/_/_/_/_/_\', 0
TREE8 : db '/_\_\_\_\_\_\', 0
TREE9 : db '/_/_/_/_/_/_/_\', 0
TREE10 :db '/_\_\_\_\_\_\_\_\', 0
TREE11 :db '/_/_/_/_/_/_/_/_/_\', 0
TREE12 :db '/_\_\_\_\_\_\_\_\_\_\', 0
TREE13 :db '/_/_/_/_/_/_/_/_/_/_/_\', 0
TREE14 :db '[___]', 0
TREE15: db '****************************************[___]***********************************', 0

times ( 512 - ( $ - $$ ) % 512 ) db 0x00
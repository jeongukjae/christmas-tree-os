[BITS 16]
[ORG 0x00]

section .text

jmp 0x07C0:START

TOTALSECTORCOUNT: dw 1024

START:
	mov ax, 0x07C0
	mov ds, ax
	mov ax, 0xB800
	mov es, ax

	mov ax, 0x0000
	mov ss, ax
	mov sp, 0xFFFE
	mov bp, 0xFFFE
	
	mov si, 0

SCREENCLEARLOOP:
	mov byte [es : si], 0
	mov byte [es : si + 1 ], 0x0F

	add si, 2
	cmp si, 80 * 25 * 2
	jl SCREENCLEARLOOP


RESETDISK:
	;; BIOS 리샛 함수 호출
	mov ax, 0
	mov dl, 0
	int 0x13
	jc HANDLEDISKERROR
	;; 에러 발생하면 에러 처리


	;;; 섹터 읽기
	mov si, 0x1000

	mov es, si
	mov bx, 0x0000

	mov di, word [ TOTALSECTORCOUNT ]

READDATA:
	cmp di, 0
	je READEND

	sub di, 0x1


	;; BIOS 읽기 함수
	mov ah, 0x02
	mov al, 0x1 				;읽을 섹터수 1
	mov ch, byte[ TRACKNUMBER ]	;읽을 트랙 번호 설정
	mov cl, byte[ SECTORNUMBER ];읽을 섹터 번호 설정
	mov dh, byte[ HEADNUMBER ] 	;읽을 헤드 번호 설정
	mov dl, 0x00 				;읽을 드라이브 번호 설정
	
	int 0x13
	jc HANDLEDISKERROR

	;;; 복사할 어드레스, 트랙, 헤드, 섹터 어드레스 계산
	add si, 0x0020
	mov es, si

	mov al, byte[ SECTORNUMBER ]
	add al, 0x01
	mov byte[ SECTORNUMBER ], al
	cmp al, 19
	jl READDATA

	xor byte[ HEADNUMBER ], 0x01
	mov byte[ SECTORNUMBER ], 0x01

	cmp byte[ HEADNUMBER ], 0x00
	jne READDATA

	add byte[ TRACKNUMBER ], 0x01
	jmp READDATA

READEND:
	jmp 0x1000:0x0000

HANDLEDISKERROR:
	push DISKERROR
	push 1
	push 20
	call PRINTMESSAGE

	jmp $



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

	;; y 좌표
	mov ax, word[bp + 6]
	mov si, 160
	mul si
	add di, ax

	;; x 좌표
	mov ax, word[bp + 4]
	mov si, 2
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

SECTORNUMBER: db 0x02
HEADNUMBER: db 0x00
TRACKNUMBER: db 0x00
DISKERROR: db '[Error] Disk Handle Error!', 0

times 510 - ( $ - $$ ) db 0x00

db 0x55
db 0xAA
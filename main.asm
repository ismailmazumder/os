[org 0x7c00]
mov si,description
mov cx,0x100
mov ah,0x0e
start:
    call main
    call game_start

main:
    call loop_string
loop_string:
    mov al,[si+bx]
    int 0x10
    inc dl
    inc bx
    cmp al,0
    je break
    jne loop_string  ; not qeual

break:
    hlt

mov cl,0x5

game_start:
    mov ah,0x2
    mov dl,cl
    mov dh,10
    int 0x10
    mov ah,0x0e
    mov al,'X'
    int 0x10
    dec cl
    mov ah,0x2
    mov dl,cl
    mov dh,10
    int 0x10
    mov ah,0x0e
    mov al,' '
    int 0x10
    add cl,0x2
    call delay
    cmp cl,0x12
    
    jmp game_start


    
delay:
    push cx
    mov cx, 0xFFFF    ; বড় লুপ মান (কমাতে পারো যদি দ্রুত চাই)
.loop:
    loop .loop
    pop cx
    ret


description: db 'HELLO HELLO snake GAME',0

times 510-($-$$) db 0
dw 0xaa55             

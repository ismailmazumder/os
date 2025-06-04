[org 0x7c00]

mov ah, 0x09          
mov al, 'h'           
mov bh, 0x00         
mov bl, 0x02          
mov cx, 2             
int 0x10              

times 510-($-$$) db 0
dw 0xaa55             

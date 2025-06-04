[org 0x7c00]
mov dx,0x50 ;count time
mov bl,'2'  ; data rakhlam koto theke print korbe
mov cx,dx ; cx e loop er count time dilam. ei register count time control kore
loop_:
    mov ah , 0x09
    mov bh,0x0
    mov bl,0x03
    mov al , bl
    add bl,1
    int 0x10

loop loop_
;CX রেজিস্টারের মান থেকে ১ বিয়োগ করবে।

; যদি CX এখনো শূন্য না হয় (অর্থাৎ > 0 থাকে), তাহলে প্রোগ্রাম loop_ লেবেলে ফিরে যাবে লুপ চালানোর জন্য।
    
times 510-($-$$) db 0
dw 0xaa55  
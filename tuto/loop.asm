[org 0x7c00]
mov bl,'2'  ; data rakhlam koto theke print korbe mane loop er starting number pore +1 korbe j oitar starting number
mov cx,0x90 ; cx e loop er count time dilam. ei register count time control kore
loop_:
   mov ah,0x0e
   mov al,bl
   add bl,0x1
   int 0x10

loop loop_
;CX রেজিস্টারের মান থেকে ১ বিয়োগ করবে।
; যদি CX এখনো শূন্য না হয় (অর্থাৎ > 0 থাকে), তাহলে প্রোগ্রাম loop_ লেবেলে ফিরে যাবে লুপ চালানোর জন্য।
    
times 510-($-$$) db 0
dw 0xaa55  
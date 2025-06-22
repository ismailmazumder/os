[org 0x7c00]

mov bx, 0x2000
mov al, [bx]     ; bx যেই address দেখায় (0x2000), সেই address এর ভিতরের ভ্যালু al-এ রাখো
; bx যেই মেমোরি address দেখায়, সেই মেমোরির ভ্যালু ax-এ



times 510-($-$$) db 0
dw 0xaa55             

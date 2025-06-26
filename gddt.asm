[org 0x7c00]

start:
    cli                 ; Disable interrupts

    ; Load GDT descriptor
    lgdt [gdt_descriptor]

    ; Enter protected mode
    mov eax, cr0
    or eax, 1           ; Set PE bit
    mov cr0, eax

    ; Far jump to flush pipeline and load CS
    jmp 0x08:protected_mode_entry  ;  nicher niyom e just 1 gun kora hoise na ja koraw same
                                   ;; Far jump → new CS + EIP

[bits 32]
protected_mode_entry:
    mov ax, 0x10        ; Data segment selector (index 2 * 8 = 0x10)  Data Segment ২য় এন্ট্রি (index=2), তাই সিলেক্টর = 2 × 8 = 0x10।
    mov ds, ax          ; ekhane sob segment data segment er upor diye jabe tai ax sobgulay and 0x8 diye gun kora value 0x08 হলো GDT এর দ্বিতীয় এন্ট্রির (index 1) সিলেক্টর. 0x10 >> 3 = 2 → GDT-র ২ নম্বর Entry
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax



gdt_start:
    dq 0
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10011010b
    db 11001111b      ; Flags + Limit High (byte 6)
    db 0x00           ; Base High (byte 7)

    ;data

        dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10010010b
    db 11001111b      ; Flags + Limit High (byte 6)
    db 0x00           ; Base High (byte 7)

gdt_end:


gdt_descriptor:
    dw gdt_end - gdt_start - 1    ; Limit (size of GDT - 1)
    dd gdt_start                  ; Base (address of GDT start)

    

times 510-($-$$) db 0
dw 0xaa55             
[bits 16]
[org 0x7c00]

start:
    cli                 ; Disable interrupts

    ; Load GDT descriptor
    lgdt [gdt_descriptor]

    ; Enable A20 line here if needed (not shown)

    ; Enter protected mode
    mov eax, cr0
    or eax, 1           ; Set PE bit
    mov cr0, eax

    ; Far jump to flush pipeline and load CS
    jmp 0x08:protected_mode_entry

; ------------------------
; 32-bit protected mode code starts here
; ------------------------
[bits 32]
protected_mode_entry:
    mov ax, 0x10        ; Data segment selector (index 2 * 8 = 0x10)
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    ; Hang here (infinite loop)
.hang:
    jmp .hang

; ------------------------
; Global Descriptor Table (GDT)
; ------------------------
gdt_start:
    dq 0                    ; Null descriptor

    ; Code Segment Descriptor (index 1 = selector 0x08)
    dw 0xFFFF               ; Limit low (bits 0-15)
    dw 0x0000               ; Base low  (bits 0-15)
    db 0x00                 ; Base mid  (bits 16-23)
    db 10011010b            ; Access byte (0x9A) — present, ring0, code, exec, readable
    db 11001111b            ; Flags + Limit high (0xCF) — granularity=4KB, 32-bit segment
    db 0x00                 ; Base high (bits 24-31)

    ; Data Segment Descriptor (index 2 = selector 0x10)
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10010010b            ; Access byte (0x92) — present, ring0, data, writable
    db 11001111b            ; Flags + Limit high (0xCF)
    db 0x00

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1    ; Limit (size of GDT - 1)
    dd gdt_start                  ; Base (address of GDT start)

; ------------------------
; Boot sector padding and signature
; ------------------------
times 510-($-$$) db 0
dw 0xAA55

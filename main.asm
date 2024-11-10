[org 0x7C00]       ; Bootloader origin at 0x7C00 (where BIOS loads it)

start:
    ; Set video mode 13h (320x200, 256 colors)
    mov ah, 0x00     ; BIOS function to set video mode
    mov al, 0x13     ; Video mode 13h (320x200, 256 colors)
    int 0x10         ; Call BIOS interrupt 10h to set video mode

    ; Prepare to read image data into video memory (segment 0xA000)
    mov ax, 0xA000   ; Video memory segment address
    mov es, ax       ; Set ES register to video segment
    xor bx, bx       ; Clear BX (buffer offset)

    ; BIOS function to read 125 sectors from the disk (to cover 64,000 bytes)
    mov ah, 0x02     ; BIOS function: Read sectors
    mov al, 125      ; Number of sectors to read (320 * 200 / 512 = 125)
    mov ch, 0x00     ; Cylinder number (start at 0)
    mov cl, 0x02     ; Sector number to start reading from (sector 2)
    mov dh, 0x00     ; Head number (0)
    mov dl, 0x00     ; Drive number (0x00 for floppy)
    int 0x13         ; BIOS interrupt to read sectors

    ; Display the image by copying pixel data to video memory
    mov cx, 64000    ; Number of pixels (320 * 200)
    xor di, di       ; Start at offset 0 in video memory
draw_loop:
    mov al, [es:di]  ; Get pixel data from ES:DI
    stosb            ; Store AL at ES:DI and increment DI
    loop draw_loop   ; Decrement CX and repeat until CX is 0

hang:
    jmp hang         ; Infinite loop to keep the image displayed

; Boot sector signature (mandatory)
times 510-($-$$) db 0  ; Fill the rest with zeros to reach 510 bytes
dw 0xAA55              ; Boot sector signature (0x55AA)

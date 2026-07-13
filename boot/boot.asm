[org 0x7C00]        ; tell NASM our code will be loaded at address 0x7C00

start:
    mov ah, 0x0e     ; BIOS teletype function (print a character)
    mov al, 'A'
    int 0x10         ; call BIOS video interrupt -> prints 'A'

    mov al, 'f'
    int 0x10

    mov al, 'n'
    int 0x10

    mov al, 'e'
    int 0x10

    mov al, 'x'
    int 0x10

    mov al , 'O'
    int 0x10

    mov al, 'S'
    int 0x10

hang:
    jmp hang         ; infinite loop - stop here forever, don't run into garbage memory

times 510-($-$$) db 0   ; pad the rest of the 512 bytes with zeros
dw 0xAA55               ; boot signature - last 2 bytes, tells BIOS "this is bootable"
org 0x7C00

start:
    mov ah, 0x00
    mov al, 0x03
    int 0x10

    mov si , message
    call print_string
    call keypress

    jmp done
print_string:
    lodsb
    cmp al , 0 
    je print_done 
    mov ah , 0x0E
    int 0x10
    jmp print_string

keypress:
    mov ah , 0x00
    int 0x16
    mov ah , 0x0E
    int 0x10
    jmp keypress
print_done:
    ret 
done:
    jmp done
message : db "Hello World" , 0


times 510-($-$$) db 0
dw 0xAA55
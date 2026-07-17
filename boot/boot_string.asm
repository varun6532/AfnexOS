org [0x7C00]
section .data
message: db "Afnex OS Booted" , 0
section .text 
global start
start: 
    mov si , message
print_string:
    lodsb
    cmp al, 0
    je done
    mov ah , 0x0E
    int 0x10
    jmp print_string

done:
    jmp done

time 510-($-$$) db 0
dw 0xAA55

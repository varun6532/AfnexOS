org 0x7C00

start:
    mov si, message
print_string:
    lodsb
    cmp al, 0
    je done
    mov ah, 0x0E
    int 0x10
    jmp print_string
done:
    jmp done

message: db "Afnex OS Booted", 0

times 510-($-$$) db 0
dw 0xAA55
org 0x7C00

start:
    mov ah, 0x00
    mov al, 0x03
    int 0x10

    mov si, message
    call print_string

    cli                     ; disable interrupts before switching modes
    lgdt [gdt_descriptor]   ; load our GDT

    mov eax, cr0
    or eax, 1
    mov cr0, eax            ; set the protected mode bit

    jmp CODE_SEG:init_pm    ; far jump into 32-bit code, flushes CPU pipeline

print_string:
    lodsb
    cmp al, 0
    je print_done
    mov ah, 0x0E
    int 0x10
    jmp print_string
print_done:
    ret

message: db "Afnex OS booted with clear the screen.", 0

; ---- GDT ----
gdt_start:
    dq 0x0000000000000000

gdt_code:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10011010b
    db 11001111b
    db 0x00

gdt_data:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10010010b
    db 11001111b
    db 0x00

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

[bits 32]
init_pm:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000
    mov esp, ebp

    ; we are now in 32-bit protected mode
    ; halt here for 
   mov byte [0xB8000], 'Z'
   mov byte [0xB8001], 0x0F

    jmp $

times 510-($-$$) db 0
dw 0xAA55
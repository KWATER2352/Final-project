section .data
plain   db "KILOS"
msglen  equ $ - plain
key     db "WORLD"
encrypted db msglen dup(0)
decrypted db msglen dup(0)
newline db 10
output  db "output.txt", 0

section .text
global _start

_start:
    mov ecx, msglen
    mov esi, plain
    mov edi, key
    mov ebx, encrypted
encrypt_loop:
    mov al, [esi]
    mov dl, [edi]
    xor al, dl
    mov [ebx], al
    inc esi
    inc edi
    inc ebx
    loop encrypt_loop

    mov ecx, msglen
    mov esi, encrypted
    mov edi, key
    mov ebx, decrypted
decrypt_loop:
    mov al, [esi]
    mov dl, [edi]
    xor al, dl
    mov [ebx], al
    inc esi
    inc edi
    inc ebx
    loop decrypt_loop

    mov eax, 5
    mov ebx, output
    mov ecx, 577
    mov edx, 0644
    int 0x80
    mov ebx, eax

    mov eax, 4
    mov ecx, plain
    mov edx, msglen
    int 0x80
    mov eax, 4
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ecx, key
    mov edx, msglen
    int 0x80
    mov eax, 4
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ecx, encrypted
    mov edx, msglen
    int 0x80
    mov eax, 4
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ecx, decrypted
    mov edx, msglen
    int 0x80
    mov eax, 4
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 6
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80


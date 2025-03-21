section .data
    enter_message db "Enter a message: ", 10, 0
    encrypted_msg_label db "Encrypted message: ", 10, 0
    decrypted_msg_label db "Decrypted message: ", 10, 0
    newline db 10, 0

section .bss
    input_msg resb 256           ; Buffer to store user input
    encrypted_msg resb 256       ; Buffer to store the encrypted message

section .text
    global _start

_start:
    
    mov eax, 4
    mov ebx, 1
    mov ecx, enter_message
    mov edx, 16
    int 0x80

    
    mov eax, 3
    mov ebx, 0
    mov ecx, input_msg
    mov edx, 256
    int 0x80
    mov ecx, eax                  ; Store length of input in ECX

    
    dec ecx
    mov byte [input_msg + ecx], 0

    ; Encrypt input by shifting each character by +2
    mov esi, input_msg
    mov edi, encrypted_msg
    mov edx, ecx                  

encrypt_loop:
    dec ecx
    js print_encrypted
    mov al, byte [esi + ecx]
    add al, 2
    mov byte [edi + ecx], al
    jmp encrypt_loop

print_encrypted:
    ; Display "Encrypted message" label
    mov eax, 4
    mov ebx, 1
    mov ecx, encrypted_msg_label
    mov edx, 19
    int 0x80

    
    mov eax, 4
    mov ebx, 1
    mov ecx, encrypted_msg
    mov edx, edx
    int 0x80

    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    
    mov ecx, edx
    mov esi, encrypted_msg

decrypt_loop:
    dec ecx
    js print_decrypted
    mov al, byte [esi + ecx]
    sub al, 2
    mov byte [esi + ecx], al
    jmp decrypt_loop

print_decrypted:
    mov eax, 4
    mov ebx, 1
    mov ecx, decrypted_msg_label
    mov edx, 19
    int 0x80

   
    mov eax, 4
    mov ebx, 1
    mov ecx, encrypted_msg
    mov edx, edx
    int 0x80

 
    mov eax, 1
    xor ebx, ebx
    int 0x80
                   

section .data
    enter_message db "Enter a message: ", 10, 0
    encrypted_msg_label db "Encrypted message: ", 10, 0
    decrypted_msg_label db "Decrypted message:  ", 10, 0
    newline db 10, 0

section .bss
    input_msg resb 16
    encrypted_msg resb 16

section .text
    global _start

_start:
    ; Prompt user to enter a message
    mov eax, 4
    mov ebx, 1
    mov ecx, enter_message
    mov edx, 16
    int 0x80

    ; Read user input
    mov eax, 3
    mov ebx, 0
    mov ecx, input_msg
    mov edx, 16
    int 0x80
    mov ecx, eax
    dec ecx
    mov byte [input_msg + ecx], 0

    ; Encrypt message by shifting each character by +2 in ASCII
    mov esi, input_msg
    mov edi, encrypted_msg

encrypt_loop:
    dec ecx
    js print_encrypted
    mov al, byte [esi + ecx]
    add al, 2
    mov byte [edi + ecx], al
    jmp encrypt_loop

print_encrypted:
    ; Print encrypt label
    mov eax, 4
    mov ebx, 1
    mov ecx, encrypted_msg_label
    mov edx, 18
    int 0x80

    ; Print encrypted message
    mov eax, 4
    mov ebx, 1
    mov ecx, encrypted_msg
    mov edx, 16
    int 0x80

    ; Print newline to separate encrypted and original messages
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Print Decrypt 
    mov eax, 4
    mov ebx, 1
    mov ecx, decrypted_msg_label
    mov edx, 18
    int 0x80

    ; Print the original input message
    mov eax, 4
    mov ebx, 1
    mov ecx, input_msg
    mov edx, 16
    int 0x80

    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80

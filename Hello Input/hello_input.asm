; Hello World program in NASM for Linux

section .data
    msg db "Please enter your name: ", 0
    len equ $ - msg
    hello db "Hello, "
    hello_len equ $ - hello
    exclamation db "!", 0

section .bss
    name resb 32 ; reserve space for 32-byte string

section .text
    global _start

_start:
    ; Print prompt message
    mov eax, 4      ; system call for "write"
    mov ebx, 1      ; file descriptor for STDOUT (standard output)
    mov ecx, msg    ; pointer to message to print
    mov edx, len    ; message length
    int 0x80

    ; Read input from user
    mov eax, 3      ; system call for "read"
    mov ebx, 0      ; file descriptor for STDIN (standard input)
    mov ecx, name   ; buffer to read into
    mov edx, 32     ; maximum number of bytes to read
    int 0x80

    ; Print greeting
    mov eax, 4      ; system call for "write"
    mov ebx, 1      ; file descriptor for STDOUT (standard output)
    mov ecx, hello  ; pointer to "Hello, "
    mov edx, hello_len ; length of "Hello, "
    int 0x80

    ; Print name
    mov eax, 4      ; system call for "write"
    mov ebx, 1      ; file descriptor for STDOUT (standard output)
    mov ecx, name   ; pointer to name entered by user
    mov edx, eax    ; length of name
    int 0x80

    ; Print exclamation mark
    mov eax, 4      ; system call for "write"
    mov ebx, 1      ; file descriptor for STDOUT (standard output)
    mov ecx, exclamation ; pointer to "!"
    mov edx, 1      ; length of "!"
    int 0x80

    ; Exit program
    mov eax, 1      ; system call for "exit"
    xor ebx, ebx    ; return value of 0
    int 0x80

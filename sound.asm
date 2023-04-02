section .data
    ; Define frequency and duration of the sound
    frequency equ 440
    duration equ 200

section .text
    global _start

_start:
    ; Enable the PC speaker
    mov al, 0b10110000
    out 0x43, al

    ; Calculate the frequency divisor and send it to the speaker
    mov eax, 1193180
    mov ebx, eax
    mov al, byte 0
    mov ah, byte 0
    mov dx, frequency
    div dx
    mov al, bl
    out 0x42, al
    mov al, ah
    out 0x42, al

    ; Wait for the duration of the sound
    mov ecx, duration
    mov eax, 119318
    mul ecx
    mov ecx, eax
    mov eax, edx
    xor edx, edx
    mov ebx, 1000
    div ebx
    mov ecx, eax
    mov eax, 1
    int 0x80

    ; Disable the PC speaker and exit
    mov al, 0
    out 0x61, al
    mov eax, 1
    xor ebx, ebx
    int 0x80

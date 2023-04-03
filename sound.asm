section .data
    freq    dd  440

section .bss
    count   resw    1

section .text
    global _start

_start:
    ; Get the frequency from memory
    mov eax, [freq]

    ; Set up the sound
    mov al, 0xB6
    out 0x43, al

    ; Split the frequency into high and low bytes
    movzx bx, al
    mov bl, 0
    mov cx, 1193180
    div cx
    mov [count], ax

    ; Send the low byte to port 0x42
    mov al, bl
    out 0x42, al

    ; Send the high byte to port 0x42
    mov al, bh
    out 0x42, al

    ; Play the sound for 1 second
    mov ecx, [count]
    mov eax, 1000000
    mul ecx
    mov ecx, eax
    call usleep

    ; Stop the sound
    mov al, 0
    out 0x42, al

    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80

usleep:
    push ebp
    mov ebp, esp

    ; Get the arguments from the stack
    mov eax, [ebp+8]
    mov edx, [ebp+12]

    ; Calculate the time to sleep
    mov ebx, 1000000
    div ebx

    ; Loop and wait
    push ecx
    push edx
    mov ecx, eax
    mov edx, ebx
    mov eax, 0x0
    int 0x80
    pop edx
    pop ecx

    ; Restore the stack and return
    mov esp, ebp
    pop ebp
    ret


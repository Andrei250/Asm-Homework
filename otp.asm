%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY 

;;pentru fiecare pozitie, fac xor intre cele 2 caractere
forLoop:
    mov bl, byte[esi]
    xor bl, byte[edi]
    mov byte[edx], bl
    inc edx
    inc esi
    inc edi
    loop forLoop

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

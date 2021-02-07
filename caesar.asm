%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

;;label care face modulo din key
compare:
    cmp edi, 26
    jl forLoop
    sub edi, 26
    jmp compare

;;loop pentru rezolvarea problemei
forLoop:
    ;;verificare daca caracterul primit este litera
    ;;daca nu il salvez asa cum este
    movzx ebx, byte[esi]
    mov eax, 'z'
    cmp ebx, eax
    jg store
    mov eax, 'A'
    cmp ebx, eax
    jl store
    mov eax, 'Z'
    cmp ebx, eax
    jle solve
    mov eax, 'a'
    cmp ebx, eax
    jl store

;;daca este litera verific ce tip de litera este( mare sau mica )
solve:
    movzx ebx, byte[esi]
    cmp bl, 'Z'
    jg littleLetter

;;litera mare
bigLetter:
    add ebx, edi
    cmp bl, 'Z'
    jle store
    sub bl, 26 
    jmp store

;;litera mica
littleLetter:
    add ebx, edi
    cmp ebx, 'z'
    jle store
    sub bl, 26 
    jmp store

;;retine noul caracter
store:
    mov byte[edx], bl
    inc edx
    inc esi
    loop forLoop

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
%include "io.mac"

section .text
    global vigenere
    extern printf

section .data
    counter DD 0
    letter DB 'A'

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

;;parcurg caracter cu caracter si verific daca caracterul curent este litera    
forLoop:
    movzx eax, byte[esi]
    cmp al, 'z'
    jg store
    cmp al, 'A'
    jl store
    cmp al, 'a'
    jge solve
    cmp al, 'Z'
    jg store

;;aflu ce litera este in key si scad caracterul 'A' pentru a afla pozitia
solve:
    movzx eax, byte[edi]
    mov byte [letter], al
    inc byte [counter]
    sub byte [letter], 'A'
    inc edi
    cmp byte [counter], bl
    jl getChar
    mov edi, [ebp + 20]
    mov byte [counter], 0

;;label pentru verificarea literei mari sua mici
getChar:
    xor eax, eax
    movzx eax, byte[esi]
    cmp al, 'Z'
    jg littleLetter

;;rezolvare litera mare
bigLetter:
    add al, byte [letter]
    cmp al, 'Z'
    jle store
    sub al, 26 
    jmp store

;;rezolvare litera mica
littleLetter:
    add al, byte [letter]
    cmp eax, 'z'
    jle store
    sub al, 26 
    jmp store

;;retin raspunsul
store:
    mov byte[edx], al
    inc edx
    inc esi
    loop forLoop
    mov byte [counter], 0

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
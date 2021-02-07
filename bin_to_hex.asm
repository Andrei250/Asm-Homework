%include "io.mac"

section .text
    global bin_to_hex
    extern printf

section .data
    leng DD 0
    savedLen DD 0

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length
    ;; DO NOT MODIFY

    mov ebx, ecx
    mov dword [leng], 0

;;label care completeaza array-ul hexa cu 0-uri
completeArray: 
    cmp ebx, 0
    jl solveProblem ;; daca s-a parcurs tot sirul, sari la rezolvare
    mov byte [edx + ebx], 0
    dec ebx
    jmp completeArray

;;Rezolvarea problemei
solveProblem:
    mov ebx, ecx

;;label care calculeaza numarul de elemente din hexa_value (edx)
calcLength:
    cmp ebx, 0
    jle solve
    inc dword [leng]
    sub ebx, 4
    jmp calcLength

;;label care salveaza lungimea sirului hexa in variabile din .data
solve:
    mov eax, 0
    mov ebx, dword[leng]
    mov dword [savedLen], ebx
    xor ebx, ebx
    dec dword [leng]
    dec ecx

;; Loop pentru parcurgerea sirului de biti si calcularea valorii hexa
forLoop:
    cmp byte[esi + ecx], '0'
    je continueSolving ;; daca valoarea bitului e 0 continuam 
    cmp ebx, 0 ;; daca nu cautam ce putere a lui 2 este
    jg add2
    add eax, 1
    jmp continueSolving

;;2^1
add2:
    cmp ebx, 1
    jg add4
    add eax, 2
    jmp continueSolving

;;2^2
add4:
    cmp ebx, 2
    jg add8
    add eax, 4
    jmp continueSolving

;;2^3
add8:
    add eax, 8

;;label care verifica daca au fost luati 4 biti si ii converteste in hexa
continueSolving:
    inc ebx
    cmp ebx, 4
    jl endLoop
    mov ebx, dword [leng]
    cmp eax, 9
    jg higherThan9
    add eax, '0'
    mov byte [edx + ebx], al
    xor eax, eax
    xor ebx, ebx
    dec dword [leng]
    jmp endLoop

;;label care transforma un nr > 9 in hexa ( si < 16)
higherThan9:
    add eax, 'A'
    sub eax, 10
    mov byte [edx + ebx], al
    xor ebx, ebx
    dec dword [leng]
    xor eax, eax

endLoop:
    dec ecx
    jge forLoop

    ;;converstirea bitilor ramasi
    cmp ebx, 0
    je endOfProgram
    add eax, '0'
    mov byte[edx], al

;;label care adauga '\n' la final de string
endOfProgram:
    mov eax, dword [savedLen]
    mov byte [edx + eax], 10


    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
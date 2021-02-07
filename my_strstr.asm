%include "io.mac"

section .text
    global my_strstr
    extern printf

section .data
    counter DD 0
    len DD 0
    savedLen DD 0
    currentPos DD 0
    letterOne DB 0
    letterTwo DB 0

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY

    mov dword [savedLen], ecx
    mov dword [len], 0

;;loop pentru rezolvare problemei
forLoop:
    movzx eax, byte[ebx]
    cmp al, byte[esi]
    jne endLoop
    mov eax, 0

;;daca primul caracter din needle se potriveste cu cel curent din heysack
;;intra in acest second loop si verifica caracter cu caracter
secondForLoop:
    mov dword [currentPos], eax
    add eax, dword [len]
    cmp eax, dword [savedLen]
    jge endLoop
    mov eax, dword [currentPos]
    cmp eax, edx
    jge storeAns ;; daca s-a ajuns la finalul needle-ului atunci am indexul
    movzx eax, byte[ebx + eax]
    mov byte[letterOne], al
    mov eax, dword [currentPos]
    movzx eax, byte[esi + eax]
    mov byte [letterTwo], al
    movzx eax, byte [letterOne]
    cmp al, byte [letterTwo] ;; daca cele 2 caractere difera, sar la final
    jne endLoop
    mov eax, dword [currentPos] 
    inc eax
    jmp secondForLoop

;;incrementez toate valorile (heysack-ul, pozitia curenta - in 2 variabile)
endLoop:
    inc esi
    inc dword [counter]
    inc dword [len]
    dec ecx
    jnz forLoop
    inc dword [counter]

;;retin raspunsul
storeAns:
    mov eax, dword [counter]
    mov [edi], eax
    mov dword [counter], 0

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

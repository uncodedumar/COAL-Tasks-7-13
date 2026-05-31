INCLUDE Irvine32.inc

.data
    inventory   DWORD 1001, 1002, 1005, 1010, 2003, 2007, 3001, 3005
    msg1        BYTE "--- Inventory ---", 0
    msg2        BYTE "Enter product code to search: ", 0
    msg3        BYTE "Product found at position: ", 0
    msg4        BYTE "Product code not found in inventory", 0
    msg5        BYTE "Search again? (1=Yes / 0=No): ", 0

.code

;------------------------------------------------------------
SearchInventory PROC
; Inputs:  ESI = pointer to inventory array
;          ECX = number of elements (8)
;          EAX = value to search for
; Outputs: EBX = 1 if found, 0 if not found
;          EDX = 0-based index position if found
;------------------------------------------------------------
    mov edx, 0

searchLoop:
    cmp [esi], eax
    je itemFound
    add esi, 4
    inc edx
    loop searchLoop

    mov ebx, 0
    ret

itemFound:
    mov ebx, 1
    ret
SearchInventory ENDP


;------------------------------------------------------------
main PROC
;------------------------------------------------------------
    mov ecx, 8
    mov esi, OFFSET inventory
    mov edx, OFFSET msg1
    call WriteString
    call Crlf

displayLoop:
    mov eax, [esi]
    call WriteDec
    call Crlf
    add esi, 4
    loop displayLoop

doWhile:
    mov edx, OFFSET msg2
    call WriteString
    call ReadInt

    mov esi, OFFSET inventory
    mov ecx, 8
    call SearchInventory

    cmp ebx, 1
    jne notFound

    push edx
    mov edx, OFFSET msg3
    call WriteString
    pop edx
    inc edx              ; Converts 0-based index to 1-based display position
    mov eax, edx
    call WriteDec
    call Crlf
    jmp askAgain

notFound:
    mov edx, OFFSET msg4
    call WriteString
    call Crlf

askAgain:
    mov edx, OFFSET msg5
    call WriteString
    call ReadInt
    cmp eax, 1
    je doWhile

    exit
main ENDP

END main
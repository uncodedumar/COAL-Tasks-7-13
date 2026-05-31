INCLUDE Irvine32.inc

.data
    array       DWORD 10, 20, 30, 40, 50
    reversed    DWORD 5 DUP(?)
    
    msg_orig    BYTE "Original Array: ", 0
    msg_rev     BYTE "Reversed Array: ", 0
    space       BYTE " ", 0

.code
main PROC

    ; Display "Original Array: "
    mov edx, OFFSET msg_orig
    call WriteString
    
    ; Setup loop to print original array
    mov esi, OFFSET array
    mov ecx, 5

printOrigLoop:
    mov eax, [esi]
    call WriteDec
    mov edx, OFFSET space
    call WriteString
    add esi, 4
    loop printOrigLoop
    call Crlf

    ; --- REVERSING THE ARRAY USING THE STACK ---

    ; Step 1: Push all elements of 'array' onto the stack
    mov esi, OFFSET array
    mov ecx, 5

pushLoop:
    push [esi]
    add esi, 4
    loop pushLoop

    ; Step 2: Pop elements from the stack into 'reversed' array
    mov edi, OFFSET reversed
    mov ecx, 5

popLoop:
    pop [edi]
    add edi, 4
    loop popLoop

    ; --- DISPLAY REVERSED ARRAY ---

    ; Display "Reversed Array: "
    mov edx, OFFSET msg_rev
    call WriteString

    ; Setup loop to print reversed array
    mov esi, OFFSET reversed
    mov ecx, 5

printRevLoop:
    mov eax, [esi]
    call WriteDec
    mov edx, OFFSET space
    call WriteString
    add esi, 4
    loop printRevLoop
    call Crlf

    exit
main ENDP

END main
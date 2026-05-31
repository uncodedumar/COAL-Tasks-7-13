INCLUDE Irvine32.inc

.data
    array       DWORD 45, 23, 89, 12, 56
    count       DWORD 5
    
    msg_orig    BYTE "Original Array: ", 0
    msg_sorted  BYTE "Sorted Array:   ", 0
    space       BYTE " ", 0

.code
main PROC

    ; 1. Display "Original Array: "
    mov  edx, OFFSET msg_orig
    call WriteString
    
    mov  esi, OFFSET array
    mov  ecx, count

PrintOrig:
    mov  eax, [esi]
    call WriteDec
    mov  edx, OFFSET space
    call WriteString
    add  esi, 4
    loop PrintOrig
    call Crlf

    ; 2. Bubble Sort Logic
    mov  ecx, count
    dec  ecx                ; Outer loop counter (N - 1 iterations)

OuterLoop:
    push ecx                ; Save outer loop counter
    mov  esi, OFFSET array  ; Reset ESI to point to the start of the array

InnerLoop:
    mov  eax, [esi]         ; Load current element array[i]
    cmp  eax, [esi + 4]     ; Compare with next element array[i+1]
    jle  NoSwap             ; If array[i] <= array[i+1], no swap needed

    ; Swap the elements
    mov  ebx, [esi + 4]
    mov  [esi], ebx
    mov  [esi + 4], eax

NoSwap:
    add  esi, 4             ; Move to the next element pair
    loop InnerLoop          ; End of inner loop iteration

    pop  ecx                ; Restore outer loop counter
    loop OuterLoop          ; End of outer loop iteration

    ; 3. Display "Sorted Array: "
    mov  edx, OFFSET msg_sorted
    call WriteString
    
    mov  esi, OFFSET array
    mov  ecx, count

PrintSorted:
    mov  eax, [esi]
    call WriteDec
    mov  edx, OFFSET space
    call WriteString
    add  esi, 4
    loop PrintSorted
    call Crlf

    exit
main ENDP

END main
INCLUDE Irvine32.inc

.data
    array       DWORD 10, 20, 30, 40, 50
    searchVal   DWORD 30
    
    msgFound    BYTE "Element found at index: ", 0
    msgNotFound BYTE "Element not found in the array.", 0

.code
main PROC

    ; Initialize registers for Binary Search
    mov esi, OFFSET array   ; Base address of the array
    mov ebx, 0              ; Low index = 0
    mov ecx, 4              ; High index = 4 (N - 1)
    mov edx, searchVal      ; Value to search for

BinarySearch:
    ; Check if low > high (ebx > ecx) -> Element not found
    cmp ebx, ecx
    jg  NotFound

    ; Calculate mid index: mid = (low + high) / 2
    mov eax, ebx
    add eax, ecx
    shr eax, 1              ; Shift right by 1 divides EAX by 2 (EAX = mid)

    ; Calculate memory offset for array[mid]: EDI = mid * 4
    mov edi, eax
    shl edi, 2              ; Shift left by 2 multiplies EDI by 4 (scale factor)

    ; Compare array[mid] with searchVal (edx)
    cmp [esi + edi], edx
    je  Found               ; If equal, element found
    jl  SearchRight         ; If array[mid] < searchVal, search right half

    ; Search Left Half: high = mid - 1
    mov ecx, eax
    dec ecx
    jmp BinarySearch

SearchRight:
    ; Search Right Half: low = mid + 1
    mov ebx, eax
    inc ebx
    jmp BinarySearch

Found:
    ; Display success message and the 0-based index (EAX contains mid)
    mov edx, OFFSET msgFound
    call WriteString
    call WriteDec
    call Crlf
    jmp  Quit

NotFound:
    ; Display failure message
    mov edx, OFFSET msgNotFound
    call WriteString
    call Crlf

Quit:
    exit
main ENDP

END main
INCLUDE Irvine32.inc

.Data
grades      DWORD 85, 72, 100, 63, 78, 55
gradecount  DWORD 6

strgrade    BYTE "Grade ", 0
strcolon    BYTE ": ", 0
strhighest  BYTE "Highest: ", 0
strlowest   BYTE "Lowest: ", 0
strtotal    BYTE "Total: ", 0

.Code

;---------------------------------------------------
FindHighest PROC
; Inputs: ESI = pointer to array, ECX = array count
; Outputs: EAX = highest value
;---------------------------------------------------
    mov eax, [esi]
    add esi, 4
    dec ecx

FH_loop:
    cmp [esi], eax
    jle FH_skip
    mov eax, [esi]
FH_skip:
    add esi, 4
    loop FH_loop

    ret
FindHighest ENDP

;---------------------------------------------------
FindLowest PROC
; Inputs: ESI = pointer to array, ECX = array count
; Outputs: EAX = lowest value
;---------------------------------------------------
    mov eax, [esi]
    add esi, 4
    dec ecx

FL_loop:
    cmp [esi], eax
    jge FL_skip
    mov eax, [esi]
FL_skip:
    add esi, 4
    loop FL_loop

    ret
FindLowest ENDP

;---------------------------------------------------
main PROC
;---------------------------------------------------
    ; 1. Display individual grades loop
    mov esi, OFFSET grades
    mov ecx, 6
    mov ebx, 1

DisplayLoop:
    mov edx, OFFSET strgrade
    call WriteString

    mov eax, ebx
    call WriteInt

    mov edx, OFFSET strcolon
    call WriteString

    mov eax, [esi]
    call WriteInt
    call Crlf

    add esi, 4
    inc ebx
    loop DisplayLoop

    ; 2. Calculate and display Total
    mov esi, OFFSET grades
    mov ecx, 6
    mov ebx, 0

Sumloop:
    add ebx, [esi]
    add esi, 4
    loop Sumloop

    mov edx, OFFSET strtotal
    call WriteString
    mov eax, ebx
    call WriteInt
    call Crlf

    ; 3. Find and display Highest Grade
    mov esi, OFFSET grades
    mov ecx, gradecount
    call FindHighest

    mov edx, OFFSET strhighest
    call WriteString
    call WriteInt
    call crlf

    ; 4. Find and display Lowest Grade
    mov esi, OFFSET grades
    mov ecx, gradecount
    call FindLowest

    mov edx, OFFSET strlowest
    call WriteString
    call WriteInt
    call crlf

    call WaitMsg
    exit
main ENDP

END main
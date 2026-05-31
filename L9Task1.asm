INCLUDE Irvine32.inc

.data
    value        DWORD 25
    result_shl1  DWORD ?
    result_shl3  DWORD ?
    result_x7    DWORD ?
    result_x9    DWORD ?
    result_mul2  DWORD ?
    result_mul8  DWORD ?
    result_mul7  DWORD ?
    result_mul9  DWORD ?

    msg_original BYTE "Original Value: ", 0
    msg_x2_shift BYTE "x2 (SHL):       ", 0
    msg_x8_shift BYTE "x8 (SHL):       ", 0
    msg_x7_shift BYTE "x7 (SHL+SUB):   ", 0
    msg_x9_shift BYTE "x9 (SHL+ADD):   ", 0
    msg_x2_mul   BYTE "x2 (MUL):       ", 0
    msg_x8_mul   BYTE "x8 (MUL):       ", 0
    msg_x7_mul   BYTE "x7 (MUL):       ", 0
    msg_x9_mul   BYTE "x9 (MUL):       ", 0
    msg_divider  BYTE "-------------------------------------", 0

.code
main PROC

    ; Display original value
    mov edx, OFFSET msg_original
    call WriteString
    mov eax, value
    call WriteDec
    call Crlf

    mov edx, OFFSET msg_divider
    call WriteString
    call Crlf

    ; --- PART 1: MULTIPLICATION VIA SHIFTING ---

    ; Multiply by 2 using SHL (Shift Left by 1)
    mov eax, value
    shl eax, 1
    mov result_shl1, eax
    mov edx, OFFSET msg_x2_shift
    call WriteString
    call WriteDec
    call Crlf

    ; Multiply by 8 using SHL (Shift Left by 3)
    mov eax, value
    shl eax, 3
    mov result_shl3, eax
    mov edx, OFFSET msg_x8_shift
    call WriteString
    call WriteDec
    call Crlf

    ; Multiply by 7 using SHL and SUB ( value * 8 - value )
    mov eax, value
    shl eax, 3
    sub eax, value
    mov result_x7, eax
    mov edx, OFFSET msg_x7_shift
    call WriteString
    call WriteDec
    call Crlf

    ; Multiply by 9 using SHL and ADD ( value * 8 + value )
    mov eax, value
    shl eax, 3
    add eax, value
    mov result_x9, eax
    mov edx, OFFSET msg_x9_shift
    call WriteString
    call WriteDec
    call Crlf

    mov edx, OFFSET msg_divider
    call WriteString
    call Crlf

    ; --- PART 2: MULTIPLICATION VIA MUL INSTRUCTION ---

    ; Multiply by 2 using MUL
    mov eax, value
    mov ebx, 2
    mul ebx
    mov result_mul2, eax
    mov edx, OFFSET msg_x2_mul
    call WriteString
    call WriteDec
    call Crlf

    ; Multiply by 8 using MUL
    mov eax, value
    mov ebx, 8
    mul ebx
    mov result_mul8, eax
    mov edx, OFFSET msg_x8_mul
    call WriteString
    call WriteDec
    call Crlf

    ; Multiply by 7 using MUL
    mov eax, value
    mov ebx, 7
    mul ebx
    mov result_mul7, eax
    mov edx, OFFSET msg_x7_mul
    call WriteString
    call WriteDec
    call Crlf

    ; Multiply by 9 using MUL
    mov eax, value
    mov ebx, 9
    mul ebx
    mov result_mul9, eax
    mov edx, OFFSET msg_x9_mul
    call WriteString
    call WriteDec
    call Crlf

    exit
main ENDP

END main
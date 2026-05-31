INCLUDE Irvine32.inc

.data
    val1    DWORD 10
    val2    DWORD 20
    msg1    BYTE "Before Swap: ", 0
    msg2    BYTE "After Swap:  ", 0
    comma   BYTE ", ", 0

.code

;------------------------------------------------------------
Swap PROC
; Receives parameters via stack: [ESP+12] = val2, [ESP+8] = val1
; Note: Since parameters are passed by value, this swaps the copies
;------------------------------------------------------------
    PUSH EAX
    PUSH EBX
    
    MOV  EAX, [ESP+12]  ; Load val1 copy
    MOV  EBX, [ESP+16]  ; Load val2 copy (offset changes due to PUSHes)
    
    ; Swap values in registers
    XCHG EAX, EBX
    
    POP  EBX
    POP  EAX
    RET
Swap ENDP

;------------------------------------------------------------
main PROC
;------------------------------------------------------------
    ; Display values before swap
    MOV  EDX, OFFSET msg1
    CALL WriteString
    
    MOV  EAX, val1
    CALL WriteDec
    MOV  EDX, OFFSET comma
    CALL WriteString
    
    MOV  EAX, val2
    CALL WriteDec
    CALL Crlf

    ; Push parameters onto stack and call Swap
    PUSH val2
    PUSH val1
    CALL Swap
    ADD  ESP, 8          ; Clean up stack

    ; Display values after swap
    MOV  EDX, OFFSET msg2
    CALL WriteString
    
    MOV  EAX, val1
    CALL WriteDec
    MOV  EDX, OFFSET comma
    CALL WriteString
    
    MOV  EAX, val2
    CALL WriteDec
    CALL Crlf

    exit
main ENDP

END main
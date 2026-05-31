INCLUDE Irvine32.inc

.data
    numA        DWORD ?
    numB        DWORD ?
    sumResult   DWORD ?
    subResult   DWORD ?
    prompt1     BYTE "Enter first number: ", 0
    prompt2     BYTE "Enter second number: ", 0
    sumMsg      BYTE "Sum: ", 0
    diffMsg     BYTE "Difference: ", 0

.code

;------------------------------------------------------------
AddTwo PROC
; Receives parameters via stack: [ESP+12] = numB, [ESP+8] = numA
;------------------------------------------------------------
    PUSH EAX
    PUSH EBX
    MOV  EAX, [ESP+12]
    MOV  EBX, [ESP+8]
    ADD  EAX, EBX
    MOV  sumResult, EAX
    POP  EBX
    POP  EAX
    RET
AddTwo ENDP

;------------------------------------------------------------
SubTwo PROC
; Receives parameters via stack: [ESP+12] = numB, [ESP+8] = numA
;------------------------------------------------------------
    PUSH EAX
    PUSH EBX
    MOV  EAX, [ESP+12]
    MOV  EBX, [ESP+8]
    SUB  EAX, EBX
    MOV  subResult, EAX
    POP  EBX
    POP  EAX
    RET
SubTwo ENDP

;------------------------------------------------------------
main PROC
;------------------------------------------------------------
    ; Get first number
    MOV  EDX, OFFSET prompt1
    CALL WriteString
    CALL ReadInt
    MOV  numA, EAX

    ; Get second number
    MOV  EDX, OFFSET prompt2
    CALL WriteString
    CALL ReadInt
    MOV  numB, EAX

    ; Perform Addition
    PUSH numB
    PUSH numA
    CALL AddTwo
    ADD  ESP, 8          ; Clean up stack parameters

    ; Display Addition Result
    MOV  EDX, OFFSET sumMsg
    CALL WriteString
    MOV  EAX, sumResult
    CALL WriteInt
    CALL Crlf

    ; Perform Subtraction
    PUSH numB
    PUSH numA
    CALL SubTwo
    ADD  ESP, 8          ; Clean up stack parameters

    ; Display Subtraction Result
    MOV  EDX, OFFSET diffMsg
    CALL WriteString
    MOV  EAX, subResult
    CALL WriteInt
    CALL Crlf

    exit
main ENDP

END main
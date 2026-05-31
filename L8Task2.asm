INCLUDE Irvine32.inc

.data
    marks       DWORD 5 DUP(0)
    total       DWORD 0
    avg         DWORD 0
    highMark    DWORD 0
    lowMark     DWORD 0

    promptMsg   BYTE "Enter marks for Student ", 0
    colonMsg    BYTE ": ", 0
    invalidMsg  BYTE "Invalid marks. Enter 0-100: ", 0
    studentMsg  BYTE "Student ", 0
    totalMsg    BYTE "Total Marks: ", 0
    avgMsg      BYTE "Average Marks: ", 0
    highMsg     BYTE "Highest Mark: ", 0
    lowMsg      BYTE "Lowest Mark: ", 0

.code

;------------------------------------------------------------
PrintMarks PROC
; Displays the marks of all 5 students
;------------------------------------------------------------
    PUSH EAX
    PUSH EBX
    PUSH ECX
    PUSH EDX
    PUSH ESI
    
    MOV  ECX, 5
    MOV  ESI, OFFSET marks
    MOV  EBX, 1

PrintLoop:
    MOV  EDX, OFFSET studentMsg
    CALL WriteString
    MOV  EAX, EBX
    CALL WriteInt
    MOV  EDX, OFFSET colonMsg
    CALL WriteString
    MOV  EAX, [ESI]
    CALL WriteInt
    CALL Crlf
    ADD  ESI, 4
    INC  EBX
    LOOP PrintLoop
    
    POP  ESI
    POP  EDX
    POP  ECX
    POP  EBX
    POP  EAX
    RET
PrintMarks ENDP

;------------------------------------------------------------
CalcTotal PROC
; Calculates the sum of all marks and stores it in 'total'
;------------------------------------------------------------
    PUSH EAX
    PUSH ECX
    PUSH ESI
    
    MOV  ECX, 5
    MOV  ESI, OFFSET marks
    MOV  EAX, 0

CalcLoop:
    ADD  EAX, [ESI]
    ADD  ESI, 4
    LOOP CalcLoop
    
    MOV  total, EAX
    POP  ESI
    POP  ECX
    POP  EAX
    RET
CalcTotal ENDP

;------------------------------------------------------------
CalcAverage PROC
; Calculates the integer average by repetitive subtraction
;------------------------------------------------------------
    PUSH EAX
    PUSH EBX
    
    MOV  EAX, total
    MOV  EBX, 0

SubLoop:
    CMP  EAX, 5
    JL   SubDone
    SUB  EAX, 5
    INC  EBX
    JMP  SubLoop

SubDone:
    MOV  avg, EBX
    POP  EBX
    POP  EAX
    RET
CalcAverage ENDP

;------------------------------------------------------------
FindHighLow PROC
; Finds both the highest and lowest marks in the array
;------------------------------------------------------------
    PUSH EAX
    PUSH EBX
    PUSH ECX
    PUSH ESI
    
    MOV  ESI, OFFSET marks
    MOV  EAX, [ESI]             ; EAX tracks the highest mark
    MOV  EBX, [ESI]             ; EBX tracks the lowest mark
    ADD  ESI, 4
    MOV  ECX, 4

ScanLoop:
    CMP  [ESI], EAX
    JLE  CheckLow
    MOV  EAX, [ESI]

CheckLow:
    CMP  [ESI], EBX
    JGE  Next
    MOV  EBX, [ESI]

Next:
    ADD  ESI, 4
    LOOP ScanLoop
    
    MOV  highMark, EAX
    MOV  lowMark, EBX
    
    POP  ESI
    POP  ECX
    POP  EBX
    POP  EAX
    RET
FindHighLow ENDP

;------------------------------------------------------------
main PROC
;------------------------------------------------------------
    MOV  ESI, OFFSET marks
    MOV  EBX, 1
    MOV  ECX, 5

InputLoop:
    PUSH ECX
    MOV  EDX, OFFSET promptMsg
    CALL WriteString
    MOV  EAX, EBX
    CALL WriteInt
    MOV  EDX, OFFSET colonMsg
    CALL WriteString

ReadMark:
    CALL ReadInt
    CMP  EAX, 0
    JL   BadMark
    CMP  EAX, 100
    JG   BadMark
    JMP  GoodMark

BadMark:
    MOV  EDX, OFFSET invalidMsg
    CALL WriteString
    JMP  ReadMark

GoodMark:
    MOV  [ESI], EAX
    ADD  ESI, 4
    INC  EBX
    POP  ECX
    LOOP InputLoop

    ; Process data and display statistics
    CALL PrintMarks
    
    CALL CalcTotal
    MOV  EDX, OFFSET totalMsg
    CALL WriteString
    MOV  EAX, total
    CALL WriteInt
    CALL Crlf

    CALL CalcAverage
    MOV  EDX, OFFSET avgMsg
    CALL WriteString
    MOV  EAX, avg
    CALL WriteInt
    CALL Crlf

    CALL FindHighLow
    MOV  EDX, OFFSET highMsg
    CALL WriteString
    MOV  EAX, highMark
    CALL WriteInt
    CALL Crlf

    MOV  EDX, OFFSET lowMsg
    CALL WriteString
    MOV  EAX, lowMark
    CALL WriteInt
    CALL Crlf

    exit
main ENDP

END main
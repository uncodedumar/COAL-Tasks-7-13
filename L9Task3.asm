INCLUDE Irvine32.inc

.data
    age          DWORD ?
    fee          DWORD ?
    
    promptAge    BYTE "Enter your age: ", 0
    msgChild     BYTE "Category: Child", 0
    msgTeen      BYTE "Category: Teenager", 0
    msgAdult     BYTE "Category: Adult", 0
    msgSenior    BYTE "Category: Senior", 0
    msgFee       BYTE "Your entry fee is: $", 0

.code
main PROC

    ; Prompt user for age
    mov edx, OFFSET promptAge
    call WriteString
    call ReadInt
    mov age, eax

    ; --- CONDITIONAL LADDER (IF-ELSE REPLICATED IN ASSEMBLY) ---

    ; IF age < 12
    cmp age, 12
    jl  IsChild

    ; ELSE IF age < 18
    cmp age, 18
    jl  IsTeen

    ; ELSE IF age < 60
    cmp age, 60
    jl  IsAdult

    ; ELSE (age >= 60)
    jmp IsSenior

IsChild:
    mov edx, OFFSET msgChild
    call WriteString
    call Crlf
    mov fee, 5
    jmp DisplayFee

IsTeen:
    mov edx, OFFSET msgTeen
    call WriteString
    call Crlf
    mov fee, 10
    jmp DisplayFee

IsAdult:
    mov edx, OFFSET msgAdult
    call WriteString
    call Crlf
    mov fee, 20
    jmp DisplayFee

IsSenior:
    mov edx, OFFSET msgSenior
    call WriteString
    call Crlf
    mov fee, 15
    jmp DisplayFee

DisplayFee:
    ; Display calculated entry fee
    mov edx, OFFSET msgFee
    call WriteString
    mov eax, fee
    call WriteDec
    call Crlf

    exit
main ENDP

END main
INCLUDE Irvine32.inc

.data
    playerScores DWORD 5 DUP(0)

    strEnter     BYTE "Enter score for Player ", 0
    strColon     BYTE ": ", 0
    strInvalid   BYTE "Invalid score. Please re-enter: ", 0
    strHeader    BYTE "--- Leaderboard ---", 0
    strPlayer    BYTE "Player ", 0
    strWinning   BYTE "Winning Score: ", 0
    strTotal     BYTE "Total Score: ", 0

.code

;------------------------------------------------------------
GetHighScore PROC
; Inputs:  ESI = pointer to playerScores array
;          ECX = array count (5)
; Outputs: EAX = highest score found
;------------------------------------------------------------
    mov  eax, [esi]
    add  esi, 4
    dec  ecx

GHS_Loop:
    cmp  [esi], eax
    jle  GHS_Skip
    mov  eax, [esi]
GHS_Skip:
    add  esi, 4
    loop GHS_Loop

    ret
GetHighScore ENDP


;------------------------------------------------------------
main PROC
;------------------------------------------------------------
    ; 1. Input Loop with Validation
    mov  esi, OFFSET playerScores
    mov  ecx, 5
    mov  ebx, 1

InputLoop:
    mov  edx, OFFSET strEnter
    call WriteString

    mov  eax, ebx
    call WriteInt

    mov  edx, OFFSET strColon
    call WriteString

    call ReadInt

Validate:
    cmp  eax, 0
    jge  ValidOK

    mov  edx, OFFSET strInvalid
    call WriteString
    call ReadInt
    jmp  Validate

ValidOK:
    mov  [esi], eax
    add  esi, 4
    inc  ebx
    loop InputLoop

    ; Print Leaderboard Header
    call Crlf
    mov  edx, OFFSET strHeader
    call WriteString
    call Crlf

    ; 2. Display Scores Loop
    mov  esi, OFFSET playerScores
    mov  ecx, 5
    mov  ebx, 1

DisplayLoop:
    mov  edx, OFFSET strPlayer
    call WriteString

    mov  eax, ebx
    call WriteInt

    mov  edx, OFFSET strColon
    call WriteString

    mov  eax, [esi]
    call WriteInt
    call Crlf

    add  esi, 4
    inc  ebx
    loop DisplayLoop

    ; 3. Find and Display Winning Score
    mov  esi, OFFSET playerScores
    mov  ecx, 5
    call GetHighScore

    mov  edx, OFFSET strWinning
    call WriteString
    call WriteInt
    call Crlf

    ; 4. Calculate and Display Total Score
    mov  esi, OFFSET playerScores
    mov  ecx, 5
    mov  ebx, 0

TotalLoop:
    add  ebx, [esi]
    add  esi, 4
    loop TotalLoop

    mov  edx, OFFSET strTotal
    call WriteString
    mov  eax, ebx
    call WriteInt
    call Crlf

    call WaitMsg
    exit
main ENDP

END main
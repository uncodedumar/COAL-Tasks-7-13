INCLUDE Irvine32.inc

.data
    targetNum    DWORD 42
    guess        DWORD ?
    attempts     DWORD 0
    isCorrect    DWORD 0

    promptMsg    BYTE "Enter your guess (1-100): ", 0
    tooHighMsg   BYTE "Too High! Try again.", 0
    tooLowMsg    BYTE "Too Low! Try again.", 0
    correctMsg   BYTE "Correct! You guessed it in ", 0
    attemptsMsg  BYTE " attempts.", 0

.code
main PROC
    
gameLoop:
    ; Check loop condition: if isCorrect == 1, exit the loop
    cmp  isCorrect, 1
    je   gameEnd

    ; Prompt user for guess
    mov  edx, OFFSET promptMsg
    call WriteString
    call ReadInt
    mov  guess, eax

    ; Increment attempts count
    inc  attempts

    ; --- CONDITIONAL STRUCTURE ---
    
    ; Compare guess with targetNum
    mov  eax, guess
    cmp  eax, targetNum
    je   MatchFound
    jg   TooHigh

    ; Else: Guess is too low
    mov  edx, OFFSET tooLowMsg
    call WriteString
    call Crlf
    jmp  gameLoop

TooHigh:
    mov  edx, OFFSET tooHighMsg
    call WriteString
    call Crlf
    jmp  gameLoop

MatchFound:
    ; Set sentinel variable to break the loop on next iteration
    mov  isCorrect, 1
    jmp  gameLoop

gameEnd:
    ; Display victory messages and number of attempts
    mov  edx, OFFSET correctMsg
    call WriteString

    mov  eax, attempts
    call WriteDec

    mov  edx, OFFSET attemptsMsg
    call WriteString
    call Crlf

    exit
main ENDP

END main
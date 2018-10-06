%include 'math.asm'
%include 'print.asm'
%include 'read.asm'
%include 'convert.asm'

section .data
    prompt db 'Enter a number from zero to nine: ', 0 ; Prompts the user to enter a number
    correct db 'Your answer is correct!', 0 ; Tells the user that their answer is correct
    incorrect db 'Sorry, but your answer was incorrect. The correct answer was: ', 0 ; Tells the user that their answer was incorrect

section .bss
    guess resb 1 ; The number that the user will guess

section .txt
global _start
_start:
    ; Use rand() function in math.asm to generate random number in eax
    mov eax, 10 ; Maximum integer for rand() function
    call rand
    push eax ; Push the random number so that we can retrieve it later

    ; Prompt the user to enter a number
    mov eax, prompt
    call print

    ; Scan the user's input
    mov eax, guess
    mov ebx, 1
    call read

    ; Convert the string into an integer
    mov eax, guess
    call str2int

    ; Check if the user was correct
    pop ebx ; Retrieve the random number
    push ebx ; Push the correct answer so that we can retrieve it later
    cmp eax, ebx ; Check to see if the guess was correct
    je c ; Jump to correct if the guess was correct

    ; Print out the incorrect message
    mov eax, incorrect ; Move the incorrect prompt into eax
    call print ; Print out the incorrect prompt
    pop eax ; Retrive the correct answer
    mov ebx, guess ; Put the buffer in ebx
    call int2str ; Convert the integer into a string
    mov eax, guess ; Move the output into eax
    call printLF ; Print out the correct answer
    jmp done ; Finish the program

c: ; Called when the user gives the correct answer
    mov eax, correct ; Move the correct string into eax
    call printLF ; Print out the correct string

done: ; Called when the program is done executing
    mov eax, 1
    mov ebx, 0
    int 0x80

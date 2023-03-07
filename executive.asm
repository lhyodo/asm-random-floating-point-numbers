; ****************************************************************************************************************************
; Program name: "Append Float Array".                                                                                        *
; This program will allow a user to input two float arrays and append them into one large array.                             *
; Copyright (C) 2023 Leo Hyodo.                                                                                              *
;                                                                                                                            *
; This file is part of the software program "Append Float Array".                                                            *
; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
; version 3 as published by the Free Software Foundation.                                                                    *
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
; A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
; ****************************************************************************************************************************




; ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

; Author information
;  Author name: Leo Hyodo
;  Author email: lhyodo@csu.fullerton.edu

; Program information
;  Program name: Append Float Array
;  Programming languages: Assembly, C, bash
;  Date program began: 2023 Feb 6
;  Date of last update: 2023 Feb 21
;  Date of reorganization of comments: 2023 Feb 21
;  Files in this program: executive.asm, main.c, display_array.c, magnitude.asm, input_array.asm, append.asm, run.sh
;  Status: Finished.  The program was tested extensively with no errors in WSL 2.0.

; This file
;   File name: manager.asm
;   Language: X86 with Intel syntax.
;   Max page width: 133 columns
;   Assemble: Assemble: nasm -f elf64 -l manager.lis -o manager.o manager.asm
;   Link: gcc -m64 -no-pie -o addFloatArray.out manager.o input_array.o append.o main.o magnitude.o display_array.o -std=c11
;   Purpose: This is the central module that will direct calls to different functions including input_array, display_array,
;            magnitude, and append Using those functions, the magnitude of all the elements in a user created array will be 
;            calculated and be returned to the caller of this function (in main.c).
          
; ========================================================================================================
extern printf
extern scanf
extern rdrand
extern compare
extern stdin
extern fgets
extern strlen
extern fill_random_array
extern show_array
extern quick_sort
extern normalize_array
global executive

INPUT_LEN equ 64

segment .data
namePrompt db "Please enter your first and last name: ",0
titlePrompt db "Please enter your title (Mr., Ms., Sargeant, Chief, etc.): ",0
greeting db "Nice to meet you %s %s",10,0
farewell db "Goodbye, %s %s. We hope you enjoyed your arrays.",10,0

brief db "This program will generate 64-bit IEEE float numbers.",10,0
qtyPrompt db "How many numbers do you want. Today's limit is 100 per customer. ",0

nowBeingSorted db "The array is now being sorted.",10,0
heresYourArray db "Your numbers have been stored in an array. Here is that array.",10,0
updatedArray db "Here is the updated array.",10,0

normalArray db "The random numbers will be normalized. Here is the normalized array",10,0


intFormat db "%d",0
stringFormat db "%s",0


segment .bss  ;Reserved for uninitialized data
title resb INPUT_LEN
name resb INPUT_LEN
array1 resq 100

segment .text ;Reserved for executing instructions.

executive:

;Prolog ===== Insurance for any caller of this assembly module ========================================================
;Any future program calling this module that the data in the caller's GPRs will not be modified.
push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

;==========
;retrieve the name of the user and replace the newline char with a nullchar
;"Please enter your first and last name: "
mov rax, 0
mov rdi, namePrompt
call printf

;fgets takes parameters of uninitialized data, the size in bytes, 
;and a dereferenced pointer to the stream where the characters are read from.
mov rax, 0
mov rdi, name
mov rsi, INPUT_LEN
mov rdx, [stdin]
call fgets

;after fgets is called, the name variable is initialized with INPUT_LEN bytes
;of the contents of stdin.

;retrieving the name using fgets also retrieves the newline character
;to remove the newline character, the length of name must be retrieved
mov rax, 0
mov rdi, name
call strlen

;the length is stored in rax, so we can subtract 1 from the length
;to obtain the location of the newline character
;we replace the newline character with a nullchar, 0.
sub rax, 1
mov byte [name + rax],0

;==========
;repeat the steps above to retrieve the title and replace the newline char
;Please enter your title (Mr., Ms., Sargeant, Chief, etc.): 
mov rax, 0
mov rdi, stringFormat
mov rsi, titlePrompt
call printf

mov rax, 0
mov rdi, title
mov rsi, INPUT_LEN
mov rdx, [stdin]
call fgets

mov rax, 0
mov rdi, title
call strlen

sub rax, 1
mov byte [title + rax],0

mov rax, 0
mov rdi, greeting
mov rsi, title
mov rdx, name
call printf
;==========

;brief db "This program will generate 64-bit IEEE float numbers.",10,0
mov rax, 0
mov rdi, brief
call printf

;prompt user to enter how many random numbers to store in an array
mov rax, 0
mov rdi, qtyPrompt
call printf

;retrieve an integer and store it in r15
push qword 0
push qword 0
mov rax, 0
mov rdi, intFormat
mov rsi, rsp
call scanf
pop r15
pop rax

;call fill_random_array which fills array1 with random floating point numbers through
;the rdrand function
mov rax, 0
mov rdi, array1
mov rsi, r15
call fill_random_array

;heresYourArray db "Your numbers have been stored in an array. Here is that array.",10,0
mov rax, 0
mov rdi, heresYourArray
call printf

;prints the stored array in IEEE754 and scientific decimal format
mov rax, 0
mov rdi, array1
mov rsi, r15
call show_array

;the quick_sort function takes parameters(the array, the number of elements in the array, 
;the size of each element in bytes, and a function that compares two elements and
;determines their new positions in relation to eachother.
mov rax, 0
mov rdi, array1
mov rsi, r15
mov rdx, 8
mov rcx, compare
call quick_sort

;nowBeingSorted db "The array is now being sorted.",10,0
mov rax, 0
mov rdi, nowBeingSorted
call printf

;updatedArray db "Here is the updated array.",10,0
mov rax, 0
mov rdi, updatedArray
call printf

;prints the stored array in IEEE754 and scientific decimal format
mov rax, 0
mov rdi, array1
mov rsi, r15
call show_array

;takes array1 and normalizes it by replacing each element's left 12 bits with 3FF
;as a result, its elements fall between floating point numbers 1.0 and 2.0
mov rax, 0
mov rdi, array1
mov rsi, r15
call normalize_array

;after normalizing, the array is no longer in order, so a call
;to quick_sort is necessary
mov rax, 0
mov rdi, array1
mov rsi, r15
mov rdx, 8
mov rcx, compare
call quick_sort

;normalArray db "The random numbers will be normalized. Here is the normalized array",10,0
mov rax, 0
mov rdi, normalArray
call printf

;prints the stored array in IEEE754 and scientific decimal format
mov rax, 0
mov rdi, array1
mov rsi, r15
call show_array

;farewell db "Goodbye, %s %s. We hope you enjoyed your arrays.",10,0
mov rax, 0
mov rdi, farewell
mov rsi, title
mov rdx, name
call printf



;End of the program
mov rax, 0

;===== Restore original values to integer registers ===================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

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
;  Files in this program: fill_random_array.asm, main.c, display_array.c, magnitude.asm, input_array.asm, append.asm, run.sh
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
global normalize_array


segment .data

segment .bss  ;Reserved for uninitialized data
array1 resq 6 ;Array of 6 quad words reserved before run time.


segment .text ;Reserved for executing instructions.

normalize_array:

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



push qword 0  ;Remain on the boundary

mov r13, rdi ;the array
mov r14, rsi ;number of random numbers

mov r15, 0 ;counter
begin_loop:
cmp r15, r14
je exit_loop

mov r12, [r13 + 8*r15]
shl r12, 12
shr r12, 12
mov r11, 1023
shl r11, 52
or r11, r12
mov [r13 + 8*r15], r11


; rdrand r12 ;generate qword

; ;if shifting r12 back after, bits are lost. so copy is needed
; mov rbx, r12
; ;check for isnaan
; shr rbx, 52 ;shift r12 to the right by size of the mantissa
; cmp rbx, 0x7FF ;check if pos nan
; je begin_loop
; cmp rbx, 0xFFF ;check if neg nan
; je begin_loop
; mov [r13 + 8*r15], r12


inc r15
jmp begin_loop

exit_loop:
;End of the program
pop rax ;Counter the push at the beginning
mov rax, r13 ;Return the magnitude of the result array to the caller module

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

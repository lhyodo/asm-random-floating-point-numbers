// ****************************************************************************************************************************
// Program name: "Append Float Array".                                                                                        *
// This program will allow a user to input two float arrays and append them into one large array.                             *
// Copyright (C) 2023 Leo Hyodo.                                                                                              *
//                                                                                                                            *
// This file is part of the software program "Append Float Array".                                                            *
// This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
// version 3 as published by the Free Software Foundation.                                                                    *
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
// A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
// ****************************************************************************************************************************




// ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

// Author information
//  Author name: Leo Hyodo
//  Author email: lhyodo@csu.fullerton.edu

// Program information
//  Program name: Append Float Array
//  Programming languages: Assembly, C, bash
//  Date program began: 2023 Feb 6
//  Date of last update: 2023 Feb 21
//  Date of reorganization of comments: 2023 Feb 21
//  Files in this program: manager.asm, main.c, display_array.c, magnitude.asm, input_array.asm, append.asm, run.sh
//  Status: Finished.  The program was tested extensively with no errors in WSL 2.0.

// This file
//   File name: main.c
//   Language: C
//   Max page width: 134 columns
//   Compile: gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c11
//   Link: gcc -m64 -no-pie -o addFloatArray.out manager.o input_array.o append.o main.o magnitude.o display_array.o -std=c11
//   Purpose: This is the central module that will direct calls to different functions including input_array, display_array,
//            magnitude, and append Using those functions, the magnitude of all the elements in a user created array will be 
//            calculated and be returned to the caller of this function (in main.c).
          
// ========================================================================================================
#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern double executive();      
// manager is an assembly module that will direct calls to other 
// functions that will fill two arrays, append them, and compute and return its magnitude


int main(int argc, char *argv[])
{
  printf("Welcome to Arrays of floats\n");
  printf("Brought to you by Leo Hyodo\n");
  double answer = executive();   // The manager module will return the magnitude of the array contents
  printf("Main will return 0 to the operating system.\n");
}

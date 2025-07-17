section .text
  global _start

_start:
  push 13
  call evenorodd
  jmp exit

evenorodd:
  ;prologue
  push ebp
  mov ebp, esp
  sub esp, 8

  ;body
  and DWORD[ebp+8], 1
  jz even

  mov DWORD[ebp-4], oddmessage
  mov DWORD[ebp-8], oddmessagelen
  jmp printstatement

even:
  mov DWORD[ebp-4], evenmessage
  mov DWORD[ebp-8], evenmessagelen
  jmp  printstatement

printstatement:
  mov ecx, DWORD[ebp-4]
  mov edx, DWORD[ebp-8]
  mov eax, 4
  mov ebx, 1
  int 0x80

  ;epilogue
  leave
  ret

exit:
  mov eax, 1
  int 0x80

section .data
  oddmessage db 'odd', 10
  oddmessagelen equ $ - oddmessage

  evenmessage db 'even', 10
  evenmessagelen equ $ - evenmessage
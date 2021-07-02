.global _start

.data
num1:
  .long 5
  .long 10

num2:
  .long 15
  .long 20

.text

_start:
  #upper 32 bits in EDX
  #lower 32 bits in EAX
  movl num1, %edx
  movl num1+4, %eax
  addl num2+4, %eax
  jc carry
  addl num2, %edx
  addl num2, %edx
  jmp done

carry:
  addl $1, %edx

done:
  movl %eax, %eax
